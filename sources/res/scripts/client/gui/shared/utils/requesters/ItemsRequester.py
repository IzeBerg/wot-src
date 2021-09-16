from abc import ABCMeta, abstractmethod
from collections import defaultdict, namedtuple
import typing, operator, constants, dossiers2, nations
from account_shared import LayoutIterator
from adisp import async, process
from constants import CustomizationInvData, SkinInvData
from debug_utils import LOG_WARNING, LOG_DEBUG, LOG_ERROR
from goodies.goodie_constants import GOODIE_STATE
from gui.shared.gui_items import GUI_ITEM_TYPE, GUI_ITEM_TYPE_NAMES, ItemsCollection, getVehicleSuitablesByType
from gui.shared.utils.requesters import vehicle_items_getter
from gui.shared.gui_items.gui_item_economics import ITEM_PRICE_EMPTY
from gui.shared.utils.requesters.battle_pass_requester import BattlePassRequester
from helpers import dependency
from items import vehicles, tankmen, getTypeOfCompactDescr, makeIntCompactDescrByID
from items.components.c11n_constants import SeasonType, CustomizationDisplayType
from items.components.crew_skins_constants import CrewSkinType
from skeletons.gui.shared import IItemsRequester, IItemsCache
from skeletons.gui.shared.gui_items import IGuiItemsFactory
from skeletons.gui.game_control import IVehiclePostProgressionController
from nation_change.nation_change_helpers import iterVehiclesWithNationGroupInOrder, iterVehTypeCDsInNationGroup, isMainInNationGroupSafe
from shared_utils.account_helpers.diff_utils import synchronizeDicts
if typing.TYPE_CHECKING:
    import skeletons.gui.shared.utils.requesters as requesters
    from gui.veh_post_progression.models.progression import PostProgressionItem
    from items.vehicles import VehicleType
DO_LOG_BROKEN_SYNC = False

def getDiffID(itemdID):
    if isinstance(itemdID, tuple):
        itemdID, _ = itemdID
    return itemdID


class _CriteriaCondition(object):
    __metaclass__ = ABCMeta

    @abstractmethod
    def __call__(self, item):
        pass


class PredicateCondition(_CriteriaCondition):

    def lookInInventory(self):
        return False

    def getIntCDProtector(self):
        return

    def __init__(self, predicate):
        self.predicate = predicate

    def __call__(self, item):
        return self.predicate(item)


class InventoryPredicateCondition(PredicateCondition):

    def lookInInventory(self):
        return True


class CompoundPredicateCondition(PredicateCondition):

    def __init__(self, *predicates):
        self.predicates = predicates

    def lookInInventory(self):
        for predicate in self.predicates:
            if not predicate.lookInInventory():
                return False

        return True

    def __call__(self, item):
        for predicate in self.predicates:
            if not predicate(item):
                return False

        return True


class NegativeCompoundPredicateCondition(CompoundPredicateCondition):

    def __call__(self, item):
        for predicate in self.predicates:
            if not predicate(item):
                return True

        return False

    def lookInInventory(self):
        for predicate in self.predicates:
            if predicate.lookInInventory():
                return False

        return super(NegativeCompoundPredicateCondition, self).lookInInventory()


class OrCompoundPredicateCondition(CompoundPredicateCondition):

    def __call__(self, item):
        for predicate in self.predicates:
            if predicate(item):
                return True

        return not self.predicates

    def lookInInventory(self):
        for predicate in self.predicates:
            if not predicate.lookInInventory():
                return False

        return self.predicates


class IntCDProtector(object):
    __slots__ = ('__intCDs', )

    def __init__(self, *intCDs):
        super(IntCDProtector, self).__init__()
        self.__intCDs = intCDs

    def isUnlinked(self):
        return not self.__intCDs

    def isTriggered(self, intCD):
        return intCD not in self.__intCDs


class RequestCriteria(object):

    def __init__(self, *args):
        self._conditions = args
        self._protector = None
        return

    def __call__(self, item):
        for c in self._conditions:
            if not c(item):
                return False

        return True

    def __or__(self, other):
        return RequestCriteria(*(self._conditions + other.getConditions()))

    def __invert__(self):
        return RequestCriteria(NegativeCompoundPredicateCondition(*self._conditions))

    def __xor__(self, other):
        selfConditions = CompoundPredicateCondition(*self._conditions)
        otherConditions = CompoundPredicateCondition(*other.getConditions())
        return RequestCriteria(OrCompoundPredicateCondition(selfConditions, otherConditions))

    def getConditions(self):
        return self._conditions

    def getIntCDProtector(self):
        return self._protector

    def lookInInventory(self):
        for condition in self._conditions:
            if condition.lookInInventory():
                return True

        return False

    @property
    def conditions(self):
        return self._conditions


class IntCDProtectionRequestCriteria(RequestCriteria):

    def __init__(self, condition, intCDs):
        super(IntCDProtectionRequestCriteria, self).__init__(PredicateCondition(condition))
        self._protector = IntCDProtector(*intCDs)


class VehsSuitableCriteria(RequestCriteria):

    def __init__(self, vehsItems, itemTypeIDs=None):
        itemTypeIDs = itemTypeIDs or GUI_ITEM_TYPE.VEHICLE_MODULES
        suitableCompDescrs = set()
        for vehicle in vehsItems:
            for itemTypeID in itemTypeIDs:
                self._selectAllSuitableItemsByVehicle(vehicle, itemTypeID, suitableCompDescrs)

        super(VehsSuitableCriteria, self).__init__(PredicateCondition(lambda item: item.intCD in suitableCompDescrs))

    def _selectAllSuitableItemsByVehicle(self, vehicle, itemTypeID, outSuitableCompDescrs):
        self._selectAllSuitableItemsByVehicleDescr(vehicle.descriptor, itemTypeID, outSuitableCompDescrs)

    @staticmethod
    def _selectAllSuitableItemsByVehicleDescr(vehicleDescr, itemTypeID, outSuitableCompDescrs):
        for descr in getVehicleSuitablesByType(vehicleDescr, itemTypeID)[0]:
            outSuitableCompDescrs.add(descr.compactDescr)


class VehsMultiNationSuitableCriteria(VehsSuitableCriteria):
    itemsCache = dependency.descriptor(IItemsCache)

    def _selectAllSuitableItemsByVehicle(self, vehicle, itemTypeID, outSuitableCompDescrs):
        self._selectAllSuitableItemsByVehicleDescr(vehicle.descriptor, itemTypeID, outSuitableCompDescrs)
        if vehicle.hasNationGroup:
            targetVehCD = iterVehTypeCDsInNationGroup(vehicle.intCD).next()
            if targetVehCD:
                self._selectAllSuitableItemsByVehicleDescr(self.itemsCache.items.getItemByCD(targetVehCD).descriptor, itemTypeID, outSuitableCompDescrs)


class REQ_CRITERIA(object):
    EMPTY = RequestCriteria()
    NONE = RequestCriteria(lambda i: False)
    CUSTOM = staticmethod(lambda predicate: RequestCriteria(PredicateCondition(predicate)))
    HIDDEN = RequestCriteria(PredicateCondition(operator.attrgetter('isHidden')))
    SECRET = RequestCriteria(PredicateCondition(operator.attrgetter('isSecret')))
    COLLECTIBLE = RequestCriteria(PredicateCondition(operator.attrgetter('isCollectible')))
    DISCLOSABLE = RequestCriteria(PredicateCondition(lambda item: item.inventoryCount > 0 or not item.isSecret))
    UNLOCKED = RequestCriteria(PredicateCondition(operator.attrgetter('isUnlocked')))
    REMOVABLE = RequestCriteria(PredicateCondition(operator.attrgetter('isRemovable')))
    INVENTORY = RequestCriteria(InventoryPredicateCondition(lambda item: item.inventoryCount > 0))
    NATIONS = staticmethod(lambda nationIDs=nations.INDICES.keys(): RequestCriteria(PredicateCondition(lambda item: item.nationID in nationIDs)))
    INNATION_IDS = staticmethod(lambda innationIDs: RequestCriteria(PredicateCondition(lambda item: item.innationID in innationIDs)))
    ITEM_TYPES = staticmethod(lambda *args: RequestCriteria(PredicateCondition(lambda item: item.itemTypeID in args)))
    ITEM_TYPES_NAMES = staticmethod(lambda *args: RequestCriteria(PredicateCondition(lambda item: item.itemTypeName in args)))
    IN_CD_LIST = staticmethod(lambda itemsList: RequestCriteria(PredicateCondition(lambda item: item.intCD in itemsList)))
    INVENTORY_OR_UNLOCKED = RequestCriteria(InventoryPredicateCondition(lambda item: item.inventoryCount > 0 or item.isUnlocked and not item.isInitiallyUnlocked))
    DISCOUNT_BUY = RequestCriteria(PredicateCondition(lambda item: item.buyPrices.itemPrice.isActionPrice() and not item.isRestoreAvailable()))
    DISCOUNT_SELL = RequestCriteria(PredicateCondition(lambda item: not item.isRented and item.sellPrices.itemPrice.isActionPrice()))
    IN_OWNERSHIP = RequestCriteria(PredicateCondition(lambda item: item.inventoryCount > 0 and not item.isRented))
    TYPE_CRITERIA = staticmethod(lambda itemsTypeID, condition: RequestCriteria(PredicateCondition(lambda item: condition(item) if item.itemTypeID in itemsTypeID else True)))

    class VEHICLE(object):
        ACTIVE_IN_NATION_GROUP = RequestCriteria(PredicateCondition(lambda item: item.activeInNationGroup))
        ACTIVE_OR_MAIN_IN_NATION_GROUP = RequestCriteria(PredicateCondition(lambda item: item.activeInNationGroup if item.isInInventory else isMainInNationGroupSafe(item.intCD)))
        FAVORITE = RequestCriteria(PredicateCondition(lambda item: item.isFavorite))
        PREMIUM = RequestCriteria(PredicateCondition(lambda item: item.isPremium))
        READY = RequestCriteria(PredicateCondition(lambda item: item.isReadyToFight))
        OBSERVER = RequestCriteria(PredicateCondition(lambda item: item.isObserver))
        EARN_CRYSTALS = RequestCriteria(PredicateCondition(lambda item: item.isEarnCrystals))
        LOCKED = RequestCriteria(PredicateCondition(lambda item: item.isLocked))
        CLASSES = staticmethod(lambda types=constants.VEHICLE_CLASS_INDICES.keys(): RequestCriteria(PredicateCondition(lambda item: item.type in types)))
        LEVELS = staticmethod(lambda levels=range(1, constants.MAX_VEHICLE_LEVEL + 1): RequestCriteria(PredicateCondition(lambda item: item.level in levels)))
        ROLES = staticmethod(lambda roles=constants.ROLE_LABEL_TO_TYPE.keys(): RequestCriteria(PredicateCondition(lambda item: item.roleLabel in roles)))
        LEVEL = staticmethod(lambda level=1: RequestCriteria(PredicateCondition(lambda item: item.level == level)))
        SPECIFIC_BY_CD = staticmethod(lambda typeCompDescrs: RequestCriteria(PredicateCondition(lambda item: item.intCD in typeCompDescrs)))
        SPECIFIC_BY_NAME = staticmethod(lambda typeNames: RequestCriteria(PredicateCondition(lambda item: item.name in typeNames)))
        SPECIFIC_BY_INV_ID = staticmethod(lambda invIDs: RequestCriteria(PredicateCondition(lambda item: item.invID in invIDs)))
        SUITABLE = staticmethod(lambda vehsItems, itemTypeIDs=None: VehsSuitableCriteria(vehsItems, itemTypeIDs))
        SUITABLE_FOR_MULTI_NATION = staticmethod(lambda vehsItems, itemTypeIDs=None: VehsMultiNationSuitableCriteria(vehsItems, itemTypeIDs))
        RENT = RequestCriteria(PredicateCondition(lambda item: item.isRented))
        TELECOM = RequestCriteria(PredicateCondition(lambda item: item.isTelecom))
        ACTIVE_RENT = RequestCriteria(InventoryPredicateCondition(lambda item: item.isRented and not item.rentalIsOver))
        EXPIRED_RENT = RequestCriteria(PredicateCondition(lambda item: item.isRented and item.rentalIsOver))
        IS_OUTFIT_LOCKED = RequestCriteria(PredicateCondition(lambda item: item.isOutfitLocked))
        EXPIRED_IGR_RENT = RequestCriteria(PredicateCondition(lambda item: item.isRented and item.rentalIsOver and item.isPremiumIGR))
        RENT_PROMOTION = RequestCriteria(PredicateCondition(lambda item: item.isRentPromotion))
        SEASON_RENT = RequestCriteria(PredicateCondition(lambda item: item.isSeasonRent))
        DISABLED_IN_PREM_IGR = RequestCriteria(PredicateCondition(lambda item: item.isDisabledInPremIGR))
        IS_PREMIUM_IGR = RequestCriteria(PredicateCondition(lambda item: item.isPremiumIGR))
        ELITE = RequestCriteria(PredicateCondition(lambda item: item.isElite))
        IS_BOT = RequestCriteria(PredicateCondition(lambda item: item.name.endswith('_bot')))
        IS_CREW_LOCKED = RequestCriteria(PredicateCondition(lambda item: item.isCrewLocked))
        FULLY_ELITE = RequestCriteria(PredicateCondition(lambda item: item.isFullyElite))
        EVENT = RequestCriteria(PredicateCondition(lambda item: item.isEvent))
        EVENT_BATTLE = RequestCriteria(PredicateCondition(lambda item: item.isOnlyForEventBattles))
        EPIC_BATTLE = RequestCriteria(PredicateCondition(lambda item: item.isOnlyForEpicBattles))
        BATTLE_ROYALE = RequestCriteria(PredicateCondition(lambda item: item.isOnlyForBattleRoyaleBattles))
        MAPS_TRAINING = RequestCriteria(PredicateCondition(lambda item: item.isOnlyForMapsTrainingBattles))
        HAS_XP_FACTOR = RequestCriteria(PredicateCondition(lambda item: item.dailyXPFactor != -1))
        IS_RESTORE_POSSIBLE = RequestCriteria(PredicateCondition(lambda item: item.isRestorePossible()))
        CAN_TRADE_IN = RequestCriteria(PredicateCondition(lambda item: item.canTradeIn))
        CAN_TRADE_OFF = RequestCriteria(PredicateCondition(lambda item: item.canTradeOff))
        CAN_SELL = RequestCriteria(PredicateCondition(lambda item: item.canSell))
        CAN_NOT_BE_SOLD = RequestCriteria(PredicateCondition(lambda item: item.canNotBeSold))
        CAN_PERSONAL_TRADE_IN_SALE = RequestCriteria(PredicateCondition(lambda item: item.canPersonalTradeInSale))
        CAN_PERSONAL_TRADE_IN_BUY = RequestCriteria(PredicateCondition(lambda item: item.canPersonalTradeInBuy))
        IS_IN_BATTLE = RequestCriteria(PredicateCondition(lambda item: item.isInBattle))
        SECRET = RequestCriteria(PredicateCondition(lambda item: item.isSecret))
        NAME_VEHICLE = staticmethod(lambda nameVehicle: RequestCriteria(PredicateCondition(lambda item: nameVehicle in item.searchableUserName)))
        NAME_VEHICLE_WITH_SHORT = staticmethod(lambda nameVehicle: RequestCriteria(PredicateCondition(lambda item: nameVehicle in item.searchableShortUserName or nameVehicle in item.searchableUserName)))
        DISCOUNT_RENT_OR_BUY = RequestCriteria(PredicateCondition(lambda item: (item.buyPrices.itemPrice.isActionPrice() or item.getRentPackageActionPrc() != 0) and not item.isRestoreAvailable()))
        HAS_TAGS = staticmethod(lambda tags: RequestCriteria(PredicateCondition(lambda item: item.tags.issuperset(tags))))
        FOR_ITEM = staticmethod(lambda style: RequestCriteria(PredicateCondition(style.mayInstall)))

    class TANKMAN(object):
        IN_TANK = RequestCriteria(PredicateCondition(lambda item: item.isInTank))
        ROLES = staticmethod(lambda roles=tankmen.ROLES: RequestCriteria(PredicateCondition(lambda item: item.descriptor.role in roles)))
        NATIVE_TANKS = staticmethod(lambda vehiclesList=[]: RequestCriteria(PredicateCondition(lambda item: item.vehicleNativeDescr.type.compactDescr in vehiclesList)))
        DISMISSED = RequestCriteria(PredicateCondition(lambda item: item.isDismissed))
        ACTIVE = ~DISMISSED

    class CREW_ITEM(object):
        IN_ACCOUNT = RequestCriteria(PredicateCondition(lambda item: item.inAccount()))
        BOOK_RARITIES = staticmethod(lambda rarityTypes: RequestCriteria(PredicateCondition(lambda item: item.getBookType() in rarityTypes)))
        NATIONS = staticmethod(lambda nationIDs=nations.INDICES.keys(): RequestCriteria(PredicateCondition(lambda item: item.nationID in nationIDs or item.getNationID() == nations.NONE_INDEX)))

    class BOOSTER(object):
        ENABLED = RequestCriteria(PredicateCondition(lambda item: item.enabled))
        IN_ACCOUNT = RequestCriteria(InventoryPredicateCondition(lambda item: item.count > 0))
        ACTIVE = RequestCriteria(PredicateCondition(lambda item: item.finishTime is not None and item.state == GOODIE_STATE.ACTIVE))
        IS_READY_TO_ACTIVATE = RequestCriteria(PredicateCondition(lambda item: item.isReadyToActivate))
        BOOSTER_TYPES = staticmethod(lambda boosterTypes: RequestCriteria(PredicateCondition(lambda item: item.boosterType in boosterTypes)))
        IN_BOOSTER_ID_LIST = staticmethod(lambda boostersList: RequestCriteria(PredicateCondition(lambda item: item.boosterID in boostersList)))
        QUALITY = staticmethod(lambda qualityValues: RequestCriteria(PredicateCondition(lambda item: item.quality in qualityValues)))
        DURATION = staticmethod(lambda durationTimes: RequestCriteria(PredicateCondition(lambda item: item.effectTime in durationTimes)))

    class DEMOUNT_KIT(object):
        IS_ENABLED = RequestCriteria(PredicateCondition(lambda item: item.enabled))
        IN_ACCOUNT = RequestCriteria(InventoryPredicateCondition(lambda item: item.count > 0))

    class EQUIPMENT(object):
        BUILTIN = staticmethod(RequestCriteria(PredicateCondition(lambda item: item.isBuiltIn)))

    class BATTLE_BOOSTER(object):
        ALL = RequestCriteria(PredicateCondition(lambda item: item.itemTypeID == GUI_ITEM_TYPE.BATTLE_BOOSTER))
        CREW_EFFECT = RequestCriteria(PredicateCondition(lambda item: item.isCrewBooster()))
        OPTIONAL_DEVICE_EFFECT = RequestCriteria(PredicateCondition(lambda item: not item.isCrewBooster()))

    class SHELL(object):
        TYPE = staticmethod(lambda typesList: RequestCriteria(PredicateCondition(lambda item: item.type in typesList)))

    class ARTEFACT(object):
        DESCRIPTOR_NAME = staticmethod(lambda descriptorName: RequestCriteria(PredicateCondition(lambda item: item.name == descriptorName)))

    class OPTIONAL_DEVICE(object):
        SIMPLE = RequestCriteria(PredicateCondition(lambda item: not item.isDeluxe and not item.isTrophy))
        DELUXE = RequestCriteria(PredicateCondition(lambda item: item.isDeluxe))
        TROPHY = RequestCriteria(PredicateCondition(lambda item: item.isTrophy))
        HAS_ANY_FROM_CATEGORIES = staticmethod(lambda *categories: RequestCriteria(PredicateCondition(lambda item: not item.descriptor.categories.isdisjoint(categories))))

    class BADGE(object):
        SELECTED = RequestCriteria(PredicateCondition(lambda item: item.isSelected))
        PREFIX_LAYOUT = RequestCriteria(PredicateCondition(lambda item: item.isPrefixLayout()))
        ACHIEVED = RequestCriteria(PredicateCondition(lambda item: item.isAchieved))

    class CUSTOMIZATION(object):
        SUMMER = RequestCriteria(PredicateCondition(lambda item: item.isSummer()))
        WINTER = RequestCriteria(PredicateCondition(lambda item: item.isWinter()))
        DESERT = RequestCriteria(PredicateCondition(lambda item: item.isDesert()))
        ALL_SEASON = RequestCriteria(PredicateCondition(lambda item: item.isAllSeason()))
        SEASON = staticmethod(lambda season: RequestCriteria(PredicateCondition(lambda item: item.season & season)))
        HISTORICAL = RequestCriteria(PredicateCondition(lambda item: item.customizationDisplayType() == CustomizationDisplayType.HISTORICAL))
        NON_HISTORICAL = RequestCriteria(PredicateCondition(lambda item: item.customizationDisplayType() == CustomizationDisplayType.NON_HISTORICAL))
        FANTASTICAL = RequestCriteria(PredicateCondition(lambda item: item.customizationDisplayType() == CustomizationDisplayType.FANTASTICAL))
        FOR_VEHICLE = staticmethod(lambda vehicle: RequestCriteria(PredicateCondition(lambda item: item.mayInstall(vehicle))))
        UNLOCKED_BY = staticmethod(lambda token: RequestCriteria(PredicateCondition(lambda item: item.requiredToken == token)))
        IS_UNLOCKED = staticmethod(lambda progress: RequestCriteria(PredicateCondition(lambda item: not item.requiredToken or item.requiredToken and progress.getTokenCount(item.requiredToken) > 0)))
        PRICE_GROUP = staticmethod(lambda priceGroup: RequestCriteria(PredicateCondition(lambda item: item.priceGroup == priceGroup)))
        PRICE_GROUP_TAG = staticmethod(lambda tag: RequestCriteria(PredicateCondition(lambda item: tag in item.priceGroupTags)))
        FREE_OR_IN_INVENTORY = RequestCriteria(PredicateCondition(lambda item: item.isInInventory or item.getBuyPrice() == ITEM_PRICE_EMPTY))
        ONLY_IN_GROUP = staticmethod(lambda group: RequestCriteria(PredicateCondition(lambda item: item.groupUserName == group)))
        DISCLOSABLE = staticmethod(lambda vehicle: RequestCriteria(PredicateCondition(lambda item: item.fullInventoryCount(vehicle.intCD) or not item.isHidden)))
        IS_INSTALLED_ON_VEHICLE = staticmethod(lambda vehicle: RequestCriteria(PredicateCondition(lambda item: item.installedCount(vehicle.intCD) > 0)))
        HAS_TAGS = staticmethod(lambda tags: RequestCriteria(PredicateCondition(lambda item: item.tags.issuperset(tags))))
        FULL_INVENTORY = RequestCriteria(PredicateCondition(lambda item: item.fullInventoryCount() > 0))
        ON_ACCOUNT = RequestCriteria(PredicateCondition(lambda item: item.fullCount() > 0))


class RESEARCH_CRITERIA(object):
    VEHICLE_TO_UNLOCK = ~REQ_CRITERIA.SECRET | ~REQ_CRITERIA.HIDDEN | ~REQ_CRITERIA.VEHICLE.PREMIUM | ~REQ_CRITERIA.VEHICLE.IS_PREMIUM_IGR | ~REQ_CRITERIA.VEHICLE.EVENT | ~REQ_CRITERIA.VEHICLE.BATTLE_ROYALE | ~REQ_CRITERIA.VEHICLE.MAPS_TRAINING


class ItemsRequester(IItemsRequester):
    itemsFactory = dependency.descriptor(IGuiItemsFactory)
    __vehPostProgressionCtrl = dependency.descriptor(IVehiclePostProgressionController)
    _AccountItem = namedtuple('_AccountItem', ['dossier', 'clanInfo', 'seasons', 'ranked', 'dogTag'])

    def __init__(self, inventory, stats, dossiers, goodies, shop, recycleBin, vehicleRotation, ranked, battleRoyale, badges, epicMetaGame, tokens, festivityRequester, blueprints=None, sessionStatsRequester=None, anonymizerRequester=None):
        self.__inventory = inventory
        self.__stats = stats
        self.__dossiers = dossiers
        self.__goodies = goodies
        self.__shop = shop
        self.__vehicleRotation = vehicleRotation
        self.__recycleBin = recycleBin
        self.__ranked = ranked
        self.__battleRoyale = battleRoyale
        self.__badges = badges
        self.__epicMetaGame = epicMetaGame
        self.__blueprints = blueprints
        self.__festivity = festivityRequester
        self.__tokens = tokens
        self.__sessionStats = sessionStatsRequester
        self.__anonymizer = anonymizerRequester
        self.__battlePass = BattlePassRequester()
        self.__itemsCache = defaultdict(dict)
        self.__brokenSyncAlreadyLoggedTypes = set()
        self.__fittingItemRequesters = {
         self.__inventory, self.__stats, self.__shop, self.__vehicleRotation, self.__recycleBin}
        self.__vehCustomStateCache = defaultdict(dict)

    @property
    def inventory(self):
        return self.__inventory

    @property
    def stats(self):
        return self.__stats

    @property
    def dossiers(self):
        return self.__dossiers

    @property
    def goodies(self):
        return self.__goodies

    @property
    def shop(self):
        return self.__shop

    @property
    def recycleBin(self):
        return self.__recycleBin

    @property
    def vehicleRotation(self):
        return self.__vehicleRotation

    @property
    def ranked(self):
        return self.__ranked

    @property
    def battleRoyale(self):
        return self.__battleRoyale

    @property
    def badges(self):
        return self.__badges

    @property
    def epicMetaGame(self):
        return self.__epicMetaGame

    @property
    def blueprints(self):
        return self.__blueprints

    @property
    def festivity(self):
        return self.__festivity

    @property
    def tokens(self):
        return self.__tokens

    @property
    def sessionStats(self):
        return self.__sessionStats

    @property
    def anonymizer(self):
        return self.__anonymizer

    @property
    def battlePass(self):
        return self.__battlePass

    @async
    @process
    def request(self, callback=None):
        from gui.Scaleform.Waiting import Waiting
        Waiting.show('download/inventory')
        yield self.__stats.request()
        yield self.__inventory.request()
        yield self.__vehicleRotation.request()
        Waiting.hide('download/inventory')
        Waiting.show('download/shop')
        yield self.__shop.request()
        Waiting.hide('download/shop')
        Waiting.show('download/dossier')
        yield self.__dossiers.request()
        yield self.__sessionStats.request()
        Waiting.hide('download/dossier')
        Waiting.show('download/discounts')
        yield self.__goodies.request()
        Waiting.hide('download/discounts')
        Waiting.show('download/recycleBin')
        yield self.__recycleBin.request()
        Waiting.hide('download/recycleBin')
        Waiting.show('download/anonymizer')
        yield self.__anonymizer.request()
        Waiting.hide('download/anonymizer')
        Waiting.show('download/ranked')
        yield self.__ranked.request()
        Waiting.hide('download/ranked')
        Waiting.show('download/ranked')
        yield self.__battleRoyale.request()
        Waiting.hide('download/ranked')
        Waiting.show('download/badges')
        yield self.__badges.request()
        Waiting.hide('download/badges')
        Waiting.show('download/epicMetaGame')
        yield self.epicMetaGame.request()
        Waiting.hide('download/epicMetaGame')
        Waiting.show('download/blueprints')
        yield self.__blueprints.request()
        Waiting.hide('download/blueprints')
        Waiting.show('download/tokens')
        yield self.__tokens.request()
        Waiting.hide('download/tokens')
        Waiting.show('download/battlePass')
        yield self.__battlePass.request()
        Waiting.hide('download/battlePass')
        Waiting.show('download/festivity')
        yield self.__festivity.request()
        Waiting.hide('download/festivity')
        self.__brokenSyncAlreadyLoggedTypes.clear()
        callback(self)

    def isSynced--- This code section failed: ---

 L. 863         0  LOAD_FAST             0  'self'
                3  LOAD_ATTR             0  '__blueprints'
                6  LOAD_CONST               None
                9  COMPARE_OP            9  is-not
               12  POP_JUMP_IF_FALSE   193  'to 193'
               15  LOAD_FAST             0  'self'
               18  LOAD_ATTR             2  '__stats'
               21  LOAD_ATTR             3  'isSynced'
               24  CALL_FUNCTION_0       0  None
               27  JUMP_IF_FALSE_OR_POP   196  'to 196'
               30  LOAD_FAST             0  'self'
               33  LOAD_ATTR             4  '__inventory'
               36  LOAD_ATTR             3  'isSynced'
               39  CALL_FUNCTION_0       0  None
               42  JUMP_IF_FALSE_OR_POP   196  'to 196'
               45  LOAD_FAST             0  'self'
               48  LOAD_ATTR             5  '__recycleBin'
               51  LOAD_ATTR             3  'isSynced'
               54  CALL_FUNCTION_0       0  None
               57  JUMP_IF_FALSE_OR_POP   196  'to 196'
               60  LOAD_FAST             0  'self'
               63  LOAD_ATTR             6  '__shop'
               66  LOAD_ATTR             3  'isSynced'
               69  CALL_FUNCTION_0       0  None
               72  JUMP_IF_FALSE_OR_POP   196  'to 196'
               75  LOAD_FAST             0  'self'
               78  LOAD_ATTR             7  '__dossiers'
               81  LOAD_ATTR             3  'isSynced'
               84  CALL_FUNCTION_0       0  None
               87  JUMP_IF_FALSE_OR_POP   196  'to 196'
               90  LOAD_FAST             0  'self'
               93  LOAD_ATTR             8  '__goodies'
               96  LOAD_ATTR             3  'isSynced'
               99  CALL_FUNCTION_0       0  None
              102  JUMP_IF_FALSE_OR_POP   196  'to 196'
              105  LOAD_FAST             0  'self'
              108  LOAD_ATTR             9  '__vehicleRotation'
              111  LOAD_ATTR             3  'isSynced'
              114  CALL_FUNCTION_0       0  None
              117  JUMP_IF_FALSE_OR_POP   196  'to 196'
              120  LOAD_FAST             0  'self'
              123  LOAD_ATTR            10  'ranked'
              126  LOAD_ATTR             3  'isSynced'
              129  CALL_FUNCTION_0       0  None
              132  JUMP_IF_FALSE_OR_POP   196  'to 196'
              135  LOAD_FAST             0  'self'
              138  LOAD_ATTR            11  '__anonymizer'
              141  LOAD_ATTR             3  'isSynced'
              144  CALL_FUNCTION_0       0  None
              147  JUMP_IF_FALSE_OR_POP   196  'to 196'
              150  LOAD_FAST             0  'self'
              153  LOAD_ATTR            12  'epicMetaGame'
              156  LOAD_ATTR             3  'isSynced'
              159  CALL_FUNCTION_0       0  None
              162  JUMP_IF_FALSE_OR_POP   196  'to 196'
              165  LOAD_FAST             0  'self'
              168  LOAD_ATTR            13  '__battleRoyale'
              171  LOAD_ATTR             3  'isSynced'
              174  CALL_FUNCTION_0       0  None
              177  JUMP_IF_FALSE_OR_POP   196  'to 196'
              180  LOAD_FAST             0  'self'
              183  LOAD_ATTR             0  '__blueprints'
              186  LOAD_ATTR             3  'isSynced'
              189  CALL_FUNCTION_0       0  None
              192  RETURN_END_IF    
            193_0  COME_FROM           177  '177'
            193_1  COME_FROM           162  '162'
            193_2  COME_FROM           147  '147'
            193_3  COME_FROM           132  '132'
            193_4  COME_FROM           117  '117'
            193_5  COME_FROM           102  '102'
            193_6  COME_FROM            87  '87'
            193_7  COME_FROM            72  '72'
            193_8  COME_FROM            57  '57'
            193_9  COME_FROM            42  '42'
           193_10  COME_FROM            27  '27'
           193_11  COME_FROM            12  '12'
              193  LOAD_GLOBAL          14  'False'
              196  RETURN_VALUE     

Parse error at or near `None' instruction at offset -1

    @async
    @process
    def requestUserDossier(self, databaseID, callback):
        dr = self.__dossiers.getUserDossierRequester(databaseID)
        userAccDossier = yield dr.getAccountDossier()
        clanInfo = yield dr.getClanInfo()
        seasons = yield dr.getRated7x7Seasons()
        ranked = yield dr.getRankedInfo()
        dogTag = yield dr.getDogTag()
        container = self.__itemsCache[GUI_ITEM_TYPE.ACCOUNT_DOSSIER]
        container[databaseID] = self._AccountItem(userAccDossier, clanInfo, seasons, ranked, dogTag)
        callback((userAccDossier, clanInfo, dr.isHidden))

    def unloadUserDossier(self, databaseID):
        container = self.__itemsCache[GUI_ITEM_TYPE.ACCOUNT_DOSSIER]
        if databaseID in container:
            del container[databaseID]
            self.__dossiers.closeUserDossier(databaseID)

    @async
    @process
    def requestUserVehicleDossier(self, databaseID, vehTypeCompDescr, callback):
        dr = self.__dossiers.getUserDossierRequester(databaseID)
        userVehDossier = yield dr.getVehicleDossier(vehTypeCompDescr)
        container = self.__itemsCache[GUI_ITEM_TYPE.VEHICLE_DOSSIER]
        container[(databaseID, vehTypeCompDescr)] = userVehDossier
        callback(userVehDossier)

    def clear(self):
        while self.__itemsCache:
            itemsType, cache = self.__itemsCache.popitem()
            if itemsType == GUI_ITEM_TYPE.VEHICLE:
                for item in cache.itervalues():
                    item.stopPerksController()

            cache.clear()

        self.__vehCustomStateCache.clear()
        self.__inventory.clear()
        self.__shop.clear()
        self.__stats.clear()
        self.__dossiers.clear()
        self.__goodies.clear()
        self.__vehicleRotation.clear()
        self.__recycleBin.clear()
        self.__ranked.clear()
        self.__battleRoyale.clear()
        self.__badges.clear()
        self.__tokens.clear()
        self.epicMetaGame.clear()
        self.__blueprints.clear()
        self.__festivity.clear()
        self.__anonymizer.clear()

    def onDisconnected(self):
        self.__tokens.onDisconnected()

    def fini(self):
        self.__fittingItemRequesters = {}

    def invalidateCache(self, diff=None):
        invalidate = defaultdict(set)
        if diff is None:
            LOG_DEBUG('Gui items cache full invalidation')
            for itemTypeID, cache in self.__itemsCache.iteritems():
                if itemTypeID not in (GUI_ITEM_TYPE.ACCOUNT_DOSSIER, GUI_ITEM_TYPE.VEHICLE_DOSSIER,
                 GUI_ITEM_TYPE.BATTLE_ABILITY):
                    cache.clear()

            self.inventory.initC11nItemsNoveltyData()
        else:
            for statName, data in diff.get('stats', {}).iteritems():
                if statName in ('unlocks', ('unlocks', '_r')):
                    self._invalidateUnlocks(data, invalidate)
                elif statName == 'eliteVehicles':
                    invalidate[GUI_ITEM_TYPE.VEHICLE].update(data)
                elif statName in ('vehTypeXP', 'vehTypeLocks'):
                    invalidate[GUI_ITEM_TYPE.VEHICLE].update(iterVehiclesWithNationGroupInOrder(data.keys()))
                elif statName in (('multipliedXPVehs', '_r'), ('multipliedRankedBattlesVehs', '_r')):
                    getter = vehicles.getVehicleTypeCompactDescr
                    vehiclesDict = self.__inventory.getItems(GUI_ITEM_TYPE.VEHICLE)
                    inventoryVehiclesCDs = []
                    if vehiclesDict:
                        inventoryVehiclesCDs = [ getter(v['compDescr']) for v in vehiclesDict.itervalues() ]
                    invalidate[GUI_ITEM_TYPE.VEHICLE].update(inventoryVehiclesCDs)
                elif statName in ('oldVehInvIDs', ):
                    invalidate[GUI_ITEM_TYPE.VEHICLE].update(data)

            for cacheType, data in diff.get('cache', {}).iteritems():
                if cacheType == 'vehsLock':
                    for itemID in data.keys():
                        vehData = self.__inventory.getVehicleData(getDiffID(itemID))
                        if vehData is not None:
                            invalidate[GUI_ITEM_TYPE.VEHICLE].add(vehData.descriptor.type.compactDescr)

            for cacheType, data in diff.get('groupLocks', {}).iteritems():
                if cacheType in ('isGroupLocked', 'groupBattles'):
                    getter = vehicles.getVehicleTypeCompactDescr
                    inventoryVehiclesCDs = [ getter(v['compDescr']) for v in self.inventory.getItems(GUI_ITEM_TYPE.VEHICLE).itervalues() ]
                    invalidate[GUI_ITEM_TYPE.VEHICLE].update(inventoryVehiclesCDs)

            for itemTypeID, itemsDiff in diff.get('inventory', {}).iteritems():
                if itemTypeID == GUI_ITEM_TYPE.VEHICLE:
                    if 'compDescr' in itemsDiff:
                        for strCD in itemsDiff['compDescr'].itervalues():
                            if strCD is not None:
                                invalidate[itemTypeID].add(vehicles.getVehicleTypeCompactDescr(strCD))

                    for data in itemsDiff.itervalues():
                        for itemID in data.iterkeys():
                            vehData = self.__inventory.getVehicleData(getDiffID(itemID))
                            if vehData is not None:
                                invalidate[itemTypeID].add(vehData.descriptor.type.compactDescr)
                                invalidate[GUI_ITEM_TYPE.TANKMAN].update(self.__getTankmenIDsForVehicle(vehData))

                elif itemTypeID == GUI_ITEM_TYPE.TANKMAN:
                    for data in itemsDiff.itervalues():
                        invalidate[itemTypeID].update(data.keys())
                        for itemID in data.keys():
                            tmanInvID = getDiffID(itemID)
                            tmanData = self.__inventory.getTankmanData(tmanInvID)
                            if tmanData is not None and tmanData.vehicle != -1:
                                invalidate[GUI_ITEM_TYPE.VEHICLE].update(self.__getVehicleCDForTankman(tmanData))
                                invalidate[GUI_ITEM_TYPE.TANKMAN].update(self.__getTankmenIDsForTankman(tmanData))

                elif itemTypeID == GUI_ITEM_TYPE.CREW_SKINS:
                    for data in itemsDiff.itervalues():
                        invalidate[GUI_ITEM_TYPE.TANKMAN].update(data.keys())

                    if SkinInvData.ITEMS in itemsDiff:
                        skinsDiff = itemsDiff[SkinInvData.ITEMS]
                        skinCDs = [ makeIntCompactDescrByID('crewSkin', CrewSkinType.CREW_SKIN, v) for v in skinsDiff.keys() ]
                        invalidate[itemTypeID].update(skinCDs)
                    if SkinInvData.OUTFITS in itemsDiff:
                        outfitDiff = itemsDiff[SkinInvData.OUTFITS]
                        for tmanInvID in outfitDiff.keys():
                            tmanData = self.__inventory.getTankmanData(tmanInvID)
                            if tmanData is not None and tmanData.vehicle != constants.VEHICLE_NO_INV_ID:
                                invalidate[GUI_ITEM_TYPE.VEHICLE].update(self.__getVehicleCDForTankman(tmanData))
                                invalidate[GUI_ITEM_TYPE.TANKMAN].update(self.__getTankmenIDsForTankman(tmanData))

                elif itemTypeID == GUI_ITEM_TYPE.CREW_BOOKS:
                    invalidate[itemTypeID].update(itemsDiff.keys())
                elif itemTypeID == GUI_ITEM_TYPE.SHELL:
                    invalidate[itemTypeID].update(itemsDiff.keys())
                    vehicleItems = self.__inventory.getItems(GUI_ITEM_TYPE.VEHICLE)
                    if vehicleItems:
                        for shellIntCD in itemsDiff.iterkeys():
                            for vehicle in vehicleItems.itervalues():
                                shells = vehicle['shells']
                                for intCD, _, _ in LayoutIterator(shells):
                                    if shellIntCD == intCD:
                                        vehicleIntCD = vehicles.getVehicleTypeCompactDescr(vehicle['compDescr'])
                                        invalidate[GUI_ITEM_TYPE.VEHICLE].add(vehicleIntCD)
                                        vehicleData = self.__inventory.getItemData(vehicleIntCD)
                                        if vehicleData is not None:
                                            gunIntCD = vehicleData.descriptor.gun.compactDescr
                                            invalidate[GUI_ITEM_TYPE.GUN].add(gunIntCD)

                elif itemTypeID == GUI_ITEM_TYPE.CUSTOMIZATION:
                    for vehicleIntCD, outfitsData in itemsDiff.get(CustomizationInvData.OUTFITS, {}).iteritems():
                        invalidate[GUI_ITEM_TYPE.VEHICLE].add(vehicleIntCD)
                        for season in outfitsData or SeasonType.RANGE:
                            invalidate[GUI_ITEM_TYPE.OUTFIT].add((vehicleIntCD, season))

                    storageKeys = (CustomizationInvData.ITEMS, CustomizationInvData.NOVELTY_DATA,
                     CustomizationInvData.DRESSED, CustomizationInvData.PROGRESSION)
                    for storageKey in storageKeys:
                        for cType, items in itemsDiff.get(storageKey, {}).iteritems():
                            for idx in items.iterkeys():
                                intCD = vehicles.makeIntCompactDescrByID('customizationItem', cType, getDiffID(idx))
                                invalidate[GUI_ITEM_TYPE.CUSTOMIZATION].add(intCD)

                    for vehicleIntCD, outfitsData in itemsDiff.get(CustomizationInvData.OUTFITS_POOL, {}).iteritems():
                        invalidate[GUI_ITEM_TYPE.VEHICLE].add(vehicleIntCD)

                else:
                    invalidate[itemTypeID].update(itemsDiff.keys())

            for itemType, itemsDiff in diff.get('recycleBin', {}).iteritems():
                deletedItems = itemsDiff.get('buffer', {})
                for itemID in deletedItems.iterkeys():
                    if itemType == 'tankmen':
                        invalidate[GUI_ITEM_TYPE.TANKMAN].add(itemID * -1)
                    else:
                        invalidate[GUI_ITEM_TYPE.VEHICLE].add(itemID)

            if ('battlePass', '_r') in diff or 'battlePass' in diff:
                if ('battlePass', '_r') in diff:
                    invalidate['battlePass'] = diff[('battlePass', '_r')]
                if 'battlePass' in diff:
                    synchronizeDicts(diff['battlePass'], invalidate.setdefault('battlePass', {}))
            if 'goodies' in diff:
                vehicleDiscounts = self.__shop.getVehicleDiscountDescriptions()
                for goodieID in diff['goodies'].iterkeys():
                    if goodieID in vehicleDiscounts:
                        vehicleDiscount = vehicleDiscounts[goodieID]
                        invalidate[GUI_ITEM_TYPE.VEHICLE].add(vehicleDiscount.target.targetValue)

            vehicleSelectedAbilities = diff.get('epicMetaGame', {}).get('selectedAbilities', {}).keys()
            if vehicleSelectedAbilities:
                invalidate[GUI_ITEM_TYPE.VEHICLE].update(vehicleSelectedAbilities)
            existingIDs = self.__itemsCache[GUI_ITEM_TYPE.VEH_POST_PROGRESSION].keys()
            invalidIDs = self.__vehPostProgressionCtrl.getInvalidProgressions(diff, existingIDs)
            if invalidIDs:
                invalidate[GUI_ITEM_TYPE.VEH_POST_PROGRESSION].update(invalidIDs)
                invalidate[GUI_ITEM_TYPE.VEHICLE].update(invalidIDs)
            for itemTypeID, uniqueIDs in invalidate.iteritems():
                self._invalidateItems(itemTypeID, uniqueIDs)

        return invalidate

    def getVehicle(self, vehInvID):
        vehInvData = self.__inventory.getVehicleData(vehInvID)
        if vehInvData is not None:
            return self.__makeVehicle(vehInvData.descriptor.type.compactDescr, vehInvData)
        else:
            return

    def getStockVehicle(self, typeCompDescr):
        if getTypeOfCompactDescr(typeCompDescr) == GUI_ITEM_TYPE.VEHICLE:
            return self.itemsFactory.createVehicle(typeCompDescr=typeCompDescr)
        else:
            return

    def getVehicleCopy(self, vehicle):
        return self.itemsFactory.createVehicle(typeCompDescr=vehicle.intCD, strCompactDescr=vehicle.descriptor.makeCompactDescr(), inventoryID=vehicle.invID, proxy=self, extData=self.__inventory.getVehExtData(vehicle.intCD))

    def getVehicleCopyByCD(self, typeCompDescr):
        vehicle = self.getItemByCD(typeCompDescr)
        vehicleCopy = self.getVehicleCopy(vehicle)
        return vehicleCopy

    def getLayoutsVehicleCopy(self, vehicle, ignoreDisabledProgression=False):
        copyVehicle = self.getVehicleCopy(vehicle)
        copyVehicle.optDevices.setInstalled(*vehicle.optDevices.installed)
        copyVehicle.shells.setInstalled(*vehicle.shells.installed)
        copyVehicle.consumables.setInstalled(*vehicle.consumables.installed)
        copyVehicle.battleBoosters.setInstalled(*vehicle.battleBoosters.installed)
        copyVehicle.installPostProgression(vehicle.postProgression.getState(), ignoreDisabledProgression)
        copyVehicle.crew = vehicle.crew
        return copyVehicle

    def getTankman(self, tmanInvID):
        tankman = None
        tmanInvData = self.__inventory.getTankmanData(tmanInvID)
        if tmanInvData is not None:
            tankman = self.__makeTankman(tmanInvID, tmanInvData)
        else:
            duration = self.__shop.tankmenRestoreConfig.billableDuration
            tankmanData = self.__recycleBin.getTankman(tmanInvID, duration)
            if tankmanData is not None:
                tankman = self.__makeDismissedTankman(tmanInvID, tankmanData)
        return tankman

    def getCrewSkin(self, skinID):
        typeCompDescr = vehicles.makeIntCompactDescrByID(GUI_ITEM_TYPE_NAMES[GUI_ITEM_TYPE.CREW_SKINS], CrewSkinType.CREW_SKIN, skinID)
        return self.__makeSimpleItem(typeCompDescr)

    def getItems(self, itemTypeID=None, criteria=REQ_CRITERIA.EMPTY, nationID=None, onlyWithPrices=True):
        result = ItemsCollection()
        if not isinstance(itemTypeID, tuple):
            itemTypeID = (
             itemTypeID,)
        for typeID in itemTypeID:
            if typeID == GUI_ITEM_TYPE.VEHICLE and nationID is None and criteria.lookInInventory():
                vehGetter = self.getVehicle
                for vehInvID in (self.inventory.getItems(GUI_ITEM_TYPE.VEHICLE) or {}).iterkeys():
                    item = vehGetter(vehInvID)
                    if criteria(item):
                        result[item.intCD] = item

            else:
                itemGetter = self.getItemByCD
                protector = criteria.getIntCDProtector()
                if protector is not None and protector.isUnlinked():
                    return result
                for intCD in vehicle_items_getter.getItemsIterator(self.__shop.getItemsData(), nationID=nationID, itemTypeID=typeID, onlyWithPrices=onlyWithPrices):
                    if protector is not None and protector.isTriggered(intCD):
                        continue
                    item = itemGetter(intCD)
                    if criteria(item):
                        result[intCD] = item

        return result

    def getTankmen(self, criteria=REQ_CRITERIA.TANKMAN.ACTIVE):
        result = ItemsCollection()
        activeTankmenInvData = self.__inventory.getItemsData(GUI_ITEM_TYPE.TANKMAN)
        for invID, tankmanInvData in activeTankmenInvData.iteritems():
            item = self.__makeTankman(invID, tankmanInvData)
            if criteria(item):
                result[invID] = item

        result.update(self.getDismissedTankmen(criteria))
        return result

    def getDismissedTankmen(self, criteria=REQ_CRITERIA.TANKMAN.DISMISSED):
        result = ItemsCollection()
        duration = self.__shop.tankmenRestoreConfig.billableDuration
        dismissedTankmenData = self.__recycleBin.getTankmen(duration)
        for invID, tankmanData in dismissedTankmenData.iteritems():
            item = self.__makeDismissedTankman(invID, tankmanData)
            if criteria(item):
                result[invID] = item

        return result

    def removeUnsuitableTankmen(self, allTankmen, criteria=None):
        if criteria is None:
            return allTankmen
        else:
            result = []
            for tankman in allTankmen:
                vehicleDescr = tankman.vehicleDescr
                if vehicleDescr is not None:
                    currentVehicle = self.getItemByCD(vehicleDescr.type.compactDescr)
                    if not criteria(currentVehicle):
                        continue
                result.append(tankman)

            return result

    def getVehicles(self, criteria=REQ_CRITERIA.EMPTY):
        return self.getItems(GUI_ITEM_TYPE.VEHICLE, criteria=criteria)

    def getStyles(self, criteria=REQ_CRITERIA.EMPTY):
        return self.getItems(GUI_ITEM_TYPE.STYLE, criteria=criteria)

    def getBadges(self, criteria=REQ_CRITERIA.EMPTY):
        result = ItemsCollection()
        for badgeID, badgeData in self.__badges.available.iteritems():
            item = self.itemsFactory.createBadge(badgeData, proxy=self)
            if criteria(item):
                result[badgeID] = item

        return result

    def getBadgeByID(self, badgeID):
        badgeData = self.__badges.available.get(badgeID)
        if badgeData is None:
            return
        else:
            return self.itemsFactory.createBadge(badgeData, proxy=self)

    def getItemByCD(self, typeCompDescr):
        if getTypeOfCompactDescr(typeCompDescr) == GUI_ITEM_TYPE.VEHICLE:
            return self.__makeVehicle(typeCompDescr)
        return self.__makeSimpleItem(typeCompDescr)

    def getItem(self, itemTypeID, nationID, innationID):
        typeCompDescr = vehicles.makeIntCompactDescrByID(GUI_ITEM_TYPE_NAMES[itemTypeID], nationID, innationID)
        if itemTypeID == GUI_ITEM_TYPE.VEHICLE:
            return self.__makeVehicle(typeCompDescr)
        return self.__makeSimpleItem(typeCompDescr)

    def getTankmanDossier(self, tmanInvID):
        tankman = self.getTankman(tmanInvID)
        tmanDossierDescr = self.__getTankmanDossierDescr(tmanInvID)
        currentVehicleItem = None
        if tankman.isInTank:
            extDossier = self.getVehicleDossier(tankman.vehicleDescr.type.compactDescr)
            currentVehicleItem = self.getItemByCD(tankman.vehicleDescr.type.compactDescr)
        else:
            extDossier = self.getAccountDossier()
        return self.itemsFactory.createTankmanDossier(tankman.descriptor, tmanDossierDescr, extDossier, currentVehicleItem=currentVehicleItem)

    def getVehicleDossier(self, vehTypeCompDescr, databaseID=None):
        if databaseID is None:
            return self.itemsFactory.createVehicleDossier(self.__getVehicleDossierDescr(vehTypeCompDescr), vehTypeCompDescr)
        else:
            container = self.__itemsCache[GUI_ITEM_TYPE.VEHICLE_DOSSIER]
            dossier = container.get((int(databaseID), vehTypeCompDescr))
            if dossier is None:
                LOG_WARNING('Vehicle dossier for this user is empty', vehTypeCompDescr, databaseID)
                return
            return self.itemsFactory.createVehicleDossier(dossier, vehTypeCompDescr, playerDBID=databaseID)

    def getVehicleDossiersIterator(self):
        for intCD, dossier in self.__dossiers.getVehDossiersIterator():
            yield (
             intCD, dossiers2.getVehicleDossierDescr(dossier))

    def getAccountDossier(self, databaseID=None):
        if databaseID is None:
            dossierDescr = self.__getAccountDossierDescr()
            return self.itemsFactory.createAccountDossier(dossierDescr)
        else:
            container = self.__itemsCache[GUI_ITEM_TYPE.ACCOUNT_DOSSIER]
            dossier = container.get(int(databaseID)).dossier
            if dossier is None:
                LOG_WARNING('Trying to get empty user dossier', databaseID)
                return
            return self.itemsFactory.createAccountDossier(dossier, databaseID)

    def getClanInfo(self, databaseID=None):
        if databaseID is None:
            return (self.__stats.clanDBID, self.__stats.clanInfo)
        else:
            container = self.__itemsCache[GUI_ITEM_TYPE.ACCOUNT_DOSSIER]
            clanInfo = container.get(int(databaseID)).clanInfo
            if clanInfo is None:
                LOG_WARNING('Trying to get empty user clan info', databaseID)
                return
            return clanInfo

    def getDogTag(self, databaseID=None):
        if databaseID is None:
            return
        else:
            container = self.__itemsCache[GUI_ITEM_TYPE.ACCOUNT_DOSSIER]
            dogTag = container.get(int(databaseID)).dogTag
            if dogTag is None:
                LOG_WARNING('Trying to get empty user dogTag', databaseID)
                return
            return dogTag

    def getVehPostProgression(self, vehIntCD, vehType=None):
        return self.__makeItem(GUI_ITEM_TYPE.VEH_POST_PROGRESSION, uid=vehIntCD, vehIntCD=vehIntCD, state=self.__inventory.getVehPostProgression(vehIntCD), vehType=vehType)

    def getPreviousItem(self, itemTypeID, invDataIdx):
        itemData = self.__inventory.getPreviousItem(itemTypeID, invDataIdx)
        return self.__makeItem(itemTypeID, invDataIdx, strCompactDescr=itemData.compDescr, inventoryID=itemData.invID, proxy=self)

    def doesVehicleExist(self, intCD):
        itemTypeID, nationID, innationID = vehicles.parseIntCompactDescr(intCD)
        return innationID in vehicles.g_list.getList(nationID)

    def _invalidateItems(self, itemTypeID, uniqueIDs):
        cache = self.__itemsCache[itemTypeID]
        for uid in uniqueIDs:
            invRes = self.__inventory.invalidateItem(itemTypeID, uid)
            if uid in cache:
                LOG_DEBUG('Item marked as invalid', uid, cache[uid], invRes)
                self.__deleteItemFromCache(cache, uid, itemTypeID)
            else:
                LOG_DEBUG('No cached item', uid, invRes)

    def _invalidateUnlocks(self, unlocked, result):
        vehInCache = self.__itemsCache[GUI_ITEM_TYPE.VEHICLE]
        for itemCD in unlocked:
            itemTypeID = getTypeOfCompactDescr(itemCD)
            if itemTypeID == GUI_ITEM_TYPE.VEHICLE:
                result[itemTypeID].add(itemCD)
                if itemCD in vehInCache:
                    self._invalidateUnlocks(vehInCache[itemCD].getAutoUnlockedItems(), result)
            elif itemTypeID in GUI_ITEM_TYPE.VEHICLE_MODULES:
                result[itemTypeID].add(itemCD)
            elif itemTypeID != GUI_ITEM_TYPE.FUEL_TANK:
                LOG_WARNING('Item is not vehicle or module', itemTypeID)

    def __deleteItemFromCache(self, cache, uid, itemTypeID):
        if itemTypeID == GUI_ITEM_TYPE.VEHICLE:
            item = cache[uid]
            if item.isCustomStateSet():
                self.__vehCustomStateCache[uid] = item.getCustomState()
            elif uid in self.__vehCustomStateCache:
                del self.__vehCustomStateCache[uid]
            item.stopPerksController()
        del cache[uid]

    def __getAccountDossierDescr(self):
        return dossiers2.getAccountDossierDescr(self.__stats.accountDossier)

    def __getTankmanDossierDescr(self, tmanInvID):
        tmanData = self.__inventory.getTankmanData(tmanInvID)
        if tmanData is not None:
            return dossiers2.getTankmanDossierDescr(tmanData.descriptor.dossierCompactDescr)
        else:
            return dossiers2.getTankmanDossierDescr()

    def __getVehicleDossierDescr(self, vehTypeCompDescr):
        return dossiers2.getVehicleDossierDescr(self.__dossiers.getVehicleDossier(vehTypeCompDescr))

    def __makeItem(self, itemTypeIdx, uid, *args, **kwargs):
        container = self.__itemsCache[itemTypeIdx]
        if uid in container:
            return container[uid]
        else:
            self.__checkFittingItemsSync(itemTypeIdx)
            item = self.itemsFactory.createGuiItem(itemTypeIdx, *args, **kwargs)
            if item is not None:
                container[uid] = item
                self.__restoreItemCustomState(itemTypeIdx, uid, item)
            return item

    def __restoreItemCustomState(self, itemTypeIdx, uid, item):
        if itemTypeIdx == GUI_ITEM_TYPE.VEHICLE:
            prevItem = self.__vehCustomStateCache.get(uid, None)
            if prevItem:
                item.setCustomState(prevItem)
                del self.__vehCustomStateCache[uid]
        return

    def __makeVehicle(self, typeCompDescr, vehInvData=None):
        vehInvData = vehInvData or self.__inventory.getItemData(typeCompDescr)
        vehExtData = self.__inventory.getVehExtData(typeCompDescr)
        if vehInvData is not None:
            return self.__makeItem(GUI_ITEM_TYPE.VEHICLE, typeCompDescr, strCompactDescr=vehInvData.compDescr, inventoryID=vehInvData.invID, typeCompDescr=typeCompDescr, proxy=self, extData=vehExtData)
        else:
            return self.__makeItem(GUI_ITEM_TYPE.VEHICLE, typeCompDescr, typeCompDescr=typeCompDescr, proxy=self, extData=vehExtData)

    def __makeTankman(self, tmanInvID, tmanInvData=None):
        tmanInvData = tmanInvData or self.__inventory.getTankmanData(tmanInvID)
        if tmanInvData is not None:
            vehicle = None
            if tmanInvData.vehicle > 0:
                vehicle = self.getVehicle(tmanInvData.vehicle)
            return self.__makeItem(GUI_ITEM_TYPE.TANKMAN, tmanInvID, strCompactDescr=tmanInvData.compDescr, inventoryID=tmanInvID, vehicle=vehicle, proxy=self)
        else:
            return

    def __makeDismissedTankman(self, tmanID, tmanData):
        strCD, dismissedAt = tmanData
        return self.__makeItem(GUI_ITEM_TYPE.TANKMAN, tmanID, strCompactDescr=strCD, inventoryID=tmanID, proxy=self, dismissedAt=dismissedAt)

    def __makeSimpleItem(self, typeCompDescr):
        return self.__makeItem(getTypeOfCompactDescr(typeCompDescr), typeCompDescr, intCompactDescr=typeCompDescr, proxy=self)

    def __getTankmenIDsForVehicle(self, vehData):
        vehTmanIDs = set()
        for tmanInvID in vehData.crew:
            if tmanInvID is not None:
                vehTmanIDs.add(tmanInvID)

        return vehTmanIDs

    def __getTankmenIDsForTankman(self, tmanData):
        vehData = self.__inventory.getVehicleData(tmanData.vehicle)
        if vehData is not None:
            return self.__getTankmenIDsForVehicle(vehData)
        else:
            return set()

    def __getVehicleCDForTankman(self, tmanData):
        vehData = self.__inventory.getVehicleData(tmanData.vehicle)
        if vehData is not None:
            return {vehData.descriptor.type.compactDescr}
        else:
            return set()

    def __checkFittingItemsSync(self, itemTypeID):
        unsyncedList = [ r.__class__.__name__ for r in self.__fittingItemRequesters if not r.isSynced() ]
        if not unsyncedList or itemTypeID in self.__brokenSyncAlreadyLoggedTypes:
            return
        self.__brokenSyncAlreadyLoggedTypes.add(itemTypeID)
        requesters = (
         self.__stats, self.__inventory, self.__recycleBin, self.__shop, self.__dossiers,
         self.__goodies, self.__vehicleRotation, self.ranked, self.__battleRoyale)
        unsyncedList = [ r.__class__.__name__ for r in [ r for r in requesters if not r.isSynced() ] ]
        LOG_ERROR('Trying to create fitting item when requesters are not fully synced:', unsyncedList, stack=True)