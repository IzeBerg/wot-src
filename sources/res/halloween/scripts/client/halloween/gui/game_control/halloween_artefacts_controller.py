import typing, itertools
from collections import namedtuple
from adisp import adisp_async
import Event, nations
from gui import GUI_NATIONS
from gui.ClientUpdateManager import g_clientUpdateManager
from gui import SystemMessages
from gui.shared.utils import decorators
from constants import EVENT_CLIENT_DATA, PREMIUM_ENTITLEMENTS
from gui.server_events.bonuses import getNonQuestBonuses, VehiclesBonus, mergeBonuses, CustomizationsBonus, NationalBlueprintBonus, IntelligenceBlueprintBonus
from gui.shared.gui_items.Vehicle import Vehicle
from gui.shared.gui_items import GUI_ITEM_TYPE
from halloween.gui.shared.gui_items.processors.processors import OpenArtefactProcessor
from halloween.skeletons.halloween_controller import IHalloweenController
from halloween.skeletons.halloween_artefacts_controller import IHalloweenArtefactsController
from halloween_common.halloween_constants import ArtefactsSettings, ArtefactType, RENT_VEHICLE_PREFIX, ARTEFACT_ID_MASK
from helpers import dependency
from skeletons.account_helpers.settings_core import ISettingsCore
from skeletons.gui.customization import ICustomizationService
from skeletons.gui.server_events import IEventsCache
from skeletons.gui.shared import IItemsCache
from shared_utils import first
from gui.shared.money import Currency
from gui.shared.utils.requesters.blueprints_requester import getFragmentNationID
if typing.TYPE_CHECKING:
    from gui.server_events.bonuses import TokensBonus, SimpleBonus
QuestConditions = namedtuple('QuestConditions', ('name', 'description', 'totalValue',
                                                 'progress'))
QuestConditions.__new__.__defaults__ = ('', '', 0, 0)
ArtefactPrice = namedtuple('ArtefactPrice', ('currency', 'amount'))
ArtefactPrice.__new__.__defaults__ = (None, 0)
QUEST_BONUS_CONDITIONS = ('cumulative', 'cumulativeExt', 'cumulativeSum', 'vehicleKillsCumulative',
                          'vehicleDamageCumulative', 'vehicleStunCumulative', 'battles')
PHASE_COMPLETION_QUEST_BR_CONDITION = ('halloween_phase', 'greater')
TOTAL_PHASE_COUNT = 4
_blueprints_national_order = [ str('blueprint_national_' + nation) for nation in GUI_NATIONS ]
BONUS_ORDER = [
 'dossier', 'vehicles', 'slots', 'tankmen', 'crewSkins', ArtefactsSettings.CREW_100, 'berths', 'customizations', 'crewBooks', ArtefactsSettings.KEY_TOKEN, Currency.BPCOIN, 'battlePassPoints', PREMIUM_ENTITLEMENTS.VIP, PREMIUM_ENTITLEMENTS.PLUS, PREMIUM_ENTITLEMENTS.BASIC, Currency.CRYSTAL, Currency.GOLD, Currency.CREDITS, 'xp', Currency.FREE_XP, Currency.EQUIP_COIN, 'battle_bonus_x5', 'crew_bonus_x3', 'battlePassQuestChainToken', 'tokens', 'battleToken', 'vehicleXP', 'tankmenXP', 'goodies', 'items', 'blueprints_universal'] + _blueprints_national_order + ['blueprints', 'blueprintsAny']

class Artefact(namedtuple('Artefact', ('artefactID', 'decodePrice', 'skipPrice', 'bonusRewards', 'questConditions',
                        'artefactTypes', 'difficulty'))):

    def getCtx(self):
        return dict(self._asdict())


def getTokenValue(bonus):
    token = first(bonus.getTokens().iterkeys(), '')
    if token.startswith('xpx5') or token.startswith('Expx5'):
        return 'battle_bonus_x5'
    return token


def getBlueprintsValue(bonus):
    fragmentCD = bonus.getValue()[0]
    if isinstance(bonus, NationalBlueprintBonus):
        blueprintNation = nations.MAP.get(getFragmentNationID(fragmentCD), nations.NONE_INDEX)
        return str('blueprint_national_' + blueprintNation)
    if isinstance(bonus, IntelligenceBlueprintBonus):
        return 'blueprints_universal'
    return 'blueprints'


_VALUE_GETTER_MAP = {'tokens': getTokenValue, 
   'battleToken': getTokenValue, 
   'blueprints': getBlueprintsValue}

def getBonusPriority(bonus):
    bonusType = bonus.getName()
    _getter = _VALUE_GETTER_MAP.get(bonusType)
    bonusValue = _getter(bonus) if _getter else None
    if bonusValue in BONUS_ORDER:
        position = BONUS_ORDER.index(bonusValue)
    elif bonusType in BONUS_ORDER:
        position = BONUS_ORDER.index(bonusType)
    else:
        position = len(BONUS_ORDER) + 1
    return position


def compareBonusesByPriority(bonus1, bonus2):
    return cmp(getBonusPriority(bonus1), getBonusPriority(bonus2))


def isArtefactQuest(qID):
    return qID.startswith(ArtefactsSettings.QUEST_PREFIX)


class HalloweenArtefactsController(IHalloweenArtefactsController):
    itemsCache = dependency.descriptor(IItemsCache)
    eventsCache = dependency.descriptor(IEventsCache)
    settingsCore = dependency.descriptor(ISettingsCore)
    halloweenCtrl = dependency.descriptor(IHalloweenController)
    c11n = dependency.descriptor(ICustomizationService)

    def __init__(self):
        super(HalloweenArtefactsController, self).__init__()
        self.onArtefactStatusUpdated = Event.Event()
        self.onArtefactKeyUpdated = Event.Event()
        self.onArtefactSettingsUpdated = Event.Event()
        self._artefacts = {}
        self._rewardsSettings = {}

    def fini(self):
        g_clientUpdateManager.removeObjectCallbacks(self)
        self.halloweenCtrl.onSettingsUpdate -= self.__updateSettings
        self.onArtefactStatusUpdated.clear()
        self.onArtefactKeyUpdated.clear()
        self.onArtefactSettingsUpdated.clear()
        self._artefacts = {}
        self._rewardsSettings = {}

    def isEnabled(self):
        return self._getConfig().get('enabled', False)

    def onLobbyInited(self, event):
        g_clientUpdateManager.addCallbacks({'tokens': self.__handleTokensUpdate, 
           'eventsData.' + str(EVENT_CLIENT_DATA.QUEST): self.__onQuestsUpdated})
        self.halloweenCtrl.onSettingsUpdate += self.__updateSettings
        self._initArtefacts()
        self._rewardsSettings = self._getRewardsSettings()

    def artefactsSorted(self):
        return sorted(self._artefacts.itervalues(), key=lambda artefact: self.getIndex(artefact.artefactID))

    def regularArtefacts(self):
        return self.artefactsSorted()[:-1]

    def getFinalArtefact(self):
        return next((x for x in self._artefacts.itervalues() if ArtefactType.FINAL in x.artefactTypes), None)

    def geArtefactIDFromOpenToken(self, token):
        return token.replace(self._getConfig().get('openedSuffix', ''), '')

    def isFinalArtefact(self, artefect):
        return ArtefactType.FINAL in artefect.artefactTypes

    def getArtefact(self, artefactID):
        return self._artefacts.get(artefactID)

    def isArtefactOpened(self, artefactID):
        openedTokenID = artefactID + self._getConfig().get('openedSuffix', '')
        return self.eventsCache.questsProgress.getTokenCount(openedTokenID) > 0

    def isArtefactReceived(self, artefactID):
        return self.eventsCache.questsProgress.getTokenCount(artefactID) > 0

    def getArtefactKeyQuantity(self):
        return self.eventsCache.questsProgress.getTokenCount(ArtefactsSettings.KEY_TOKEN)

    def getCurrentArtefactProgress(self):
        return sum(list(int(self.isArtefactOpened(artefactID)) for artefactID in self._artefacts))

    def getAvailableArtefactProgress(self):
        return sum(list(int(self.isArtefactReceived(artefactID)) for artefactID in self._artefacts))

    def getMaxArtefactsProgress(self):
        return len(self._artefacts) - 1

    def getArtefactsCount(self):
        return len(self._artefacts)

    def getMainGiftVehicle(self):
        finalArtefact = self.getFinalArtefact()
        if not finalArtefact:
            return
        else:
            for bonus in finalArtefact.bonusRewards:
                if not isinstance(bonus, VehiclesBonus):
                    continue
                vehiclesBonuses = bonus.getVehicles()
                mainVehicleBonus = vehiclesBonuses[0] if vehiclesBonuses else []
                return next((b for b in mainVehicleBonus if isinstance(b, Vehicle)), None)

            return

    def getIsHiddenBonusStyle(self, bonus):
        if bonus.bonusName == 'customizations':
            args = bonus.specialArgs
            if args:
                style = self.c11n.getItemByCD(args.itemCD)
                if style.id in self.hiddenBonusStyleIDs:
                    return True
        return False

    @property
    def hiddenBonusStyleIDs(self):
        return self._rewardsSettings.get('hiddenStyles', [])

    def getMainGiftStyle(self):
        finalArtefact = self.getFinalArtefact()
        if not finalArtefact:
            return
        else:
            for bonus in finalArtefact.bonusRewards:
                if not isinstance(bonus, CustomizationsBonus):
                    continue
                bonuses = bonus.getList()
                for item in bonuses:
                    customization = self.itemsCache.items.getItemByCD(item.get('intCD', 0))
                    if customization and customization.itemTypeID == GUI_ITEM_TYPE.STYLE:
                        return customization

            return

    def getArtefactIDForAccessToVehicle(self, vehTypeCD):
        for artefactID, artefact in self._getArtefacts().iteritems():
            accessToVehicle = artefact.get('accessToVehicle')
            if accessToVehicle == vehTypeCD:
                return artefactID

        return

    def getLackOfKeysForArtefact(self, artefactID):
        return max(0, self.__getArtefactKeyCost(artefactID) - self.getArtefactKeyQuantity())

    def getLackOfKeysForArtefacts(self):
        keysCount = 0
        for artefactID in self._artefacts:
            keysCount += self.__getArtefactKeyCost(artefactID)

        return max(0, keysCount - self.getArtefactKeyQuantity())

    @adisp_async
    @decorators.adisp_process('updating')
    def openArtefact(self, artefactID, isSkipQuest, callback):
        result = yield OpenArtefactProcessor(self, artefactID, isSkipQuest).request()
        if result.userMsg:
            SystemMessages.pushMessage(result.userMsg, type=result.sysMsgType)
        callback(result.success)

    def isProgressCompleted(self):
        return self.getCurrentArtefactProgress() >= self.getMaxArtefactsProgress()

    def getArtefactIDByIndex(self, index):
        return ARTEFACT_ID_MASK.format(index=index)

    def getIndex(self, artefactID):
        _, index, __ = artefactID.split(':')
        return int(index)

    def _initArtefacts(self):
        quests = self.eventsCache.getAllQuests(lambda q: isArtefactQuest(q.getID()))
        self._artefacts = dict((artefactID, Artefact(artefactID, ArtefactPrice(*self._getArtefactPrice(artefactID)), ArtefactPrice(*self._getArtefactQuestSkipPrice(artefactID)), self._getArtefactBonuses(artefactID, quests), self._getArtefactQuestConditions(artefactID, quests), self._getArtefactTypes(artefactID), self._getArtefactDifficulty(artefactID))) for artefactID in self._getArtefacts().iterkeys())

    def _getArtefactTypes(self, artefactID):
        return self._getArtefacts().get(artefactID, {}).get('type', [])

    def _getArtefactDifficulty(self, artefactID):
        return self._getArtefacts().get(artefactID, {}).get('difficulty', 0)

    def _getArtefactQuestSkipPrice(self, artefactID):
        return self._getArtefacts().get(artefactID, {}).get('questSkipCost', (None,
                                                                              0))

    def _getArtefactPrice(self, artefactID):
        return self._getArtefacts().get(artefactID, {}).get('cost', (None, 0))

    def _getArtefactQuestConditions(self, artefactID, quests):
        quest = quests.get(artefactID)
        if quest is not None:
            curProggres, totalValue = self.__getFirstQuestProgress(quest)
            return QuestConditions(quest.getUserName(), quest.getDescription(), totalValue, curProggres)
        else:
            return QuestConditions()

    def _getArtefactBonuses(self, artefactID, quests):
        if ArtefactType.FINAL in self._getArtefactTypes(artefactID):
            quest = quests.get(artefactID)
            if quest:
                return sorted(quest.getBonuses(), cmp=compareBonusesByPriority)
            return []
        rewards = []
        artefactConfig = self._getArtefacts().get(artefactID, {})
        bonusesConfig = artefactConfig.get('bonus', {})
        accessToVehicle = artefactConfig.get('accessToVehicle')
        if accessToVehicle:
            rentTime = self._getRentConfig().get('time', 0)
            opendSuffix = self._getRentConfig().get('openedSuffix')
            shopSuffix = self._getRentConfig().get('shopSuffix')
            vehiclesConfig = self._getRentConfig().get('vehicles', {})
            accessShopToken = vehiclesConfig.get(accessToVehicle, {}).get(shopSuffix, 'hw23_unknown')
            accessOpenToken = vehiclesConfig.get(accessToVehicle, {}).get(opendSuffix)
            if not self.eventsCache.questsProgress.getTokenCount(accessShopToken) > 0 or self.eventsCache.questsProgress.getTokenCount(accessOpenToken) > 0:
                rewards.extend(getNonQuestBonuses(VehiclesBonus.VEHICLES_BONUS, {accessToVehicle: {'rent': {'time': rentTime}}}))
        for bonusType, bonusValue in bonusesConfig.iteritems():
            rewards.extend(getNonQuestBonuses(bonusType, bonusValue))

        questsToRun = artefactConfig.get('questsToRun')
        if questsToRun:
            quests = self.eventsCache.getHiddenQuests(lambda q: q.getID() in questsToRun)
            if quests:
                rewards.extend(itertools.chain.from_iterable(q.getBonuses() for q in quests.itervalues()))
        sortedBonuses = sorted(mergeBonuses(rewards), cmp=compareBonusesByPriority)
        return sortedBonuses

    def _getConfig(self):
        return self.halloweenCtrl.getModeSettings().artefactsSettings

    def _getRentConfig(self):
        return self.halloweenCtrl.getModeSettings().rent

    def _getArtefacts(self):
        return self._getConfig().get('artefacts', {})

    def _getRewardsSettings(self):
        return self.halloweenCtrl.getModeSettings().rewardsSettings

    def __getFirstQuestProgress(self, quest):
        for condName in QUEST_BONUS_CONDITIONS:
            cond = quest.bonusCond.getConditions().find(condName)
            if not cond:
                continue
            curProgressData = quest.bonusCond.getProgress().get(None, {})
            totalValue = cond.getTotalValue()
            curProggres = (quest.isCompleted() or curProgressData.get)(cond.getKey(), 0) if 1 else totalValue
            return (curProggres, totalValue)

        return (0, 1)

    def __handleTokensUpdate(self, diff):
        for token in diff:
            if token.startswith(ArtefactsSettings.KEY_TOKEN):
                self.onArtefactKeyUpdated()
                continue
            if token.startswith(ArtefactsSettings.TOKEN_PREFIX):
                self.onArtefactStatusUpdated(token)
            if token.startswith(RENT_VEHICLE_PREFIX):
                self._initArtefacts()
                self.onArtefactSettingsUpdated()

    def __onQuestsUpdated(self, _):
        self._initArtefacts()
        self.onArtefactSettingsUpdated()

    def __updateSettings(self):
        self._initArtefacts()
        self.onArtefactSettingsUpdated()
        self._rewardsSettings = self._getRewardsSettings()

    def __getArtefactKeyCost(self, artefactID):
        artefact = self.getArtefact(artefactID)
        if not artefact:
            return 0
        else:
            if self.isArtefactOpened(artefactID):
                return 0
            if artefact.skipPrice.currency is not None and not self.isArtefactReceived(artefactID):
                amount = artefact.skipPrice.amount
            else:
                amount = artefact.decodePrice.amount
            return amount