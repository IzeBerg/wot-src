from __future__ import unicode_literals
import logging, operator, time, types
from Queue import Queue
from collections import OrderedDict, defaultdict, deque
from copy import copy, deepcopy
from itertools import islice, chain
import typing, ArenaType, BigWorld, constants, nations, personal_missions
from account_shared import getFairPlayViolationName
from adisp import adisp_async, adisp_process
from battle_pass_common import BATTLE_PASS_CHOICE_REWARD_OFFER_GIFT_TOKENS, BATTLE_PASS_TOKEN_3D_STYLE, BattlePassRewardReason, FinalReward
from early_access_common import EARLY_ACCESS_PREFIX, EARLY_ACCESS_POSTPR_KEY
from blueprints.BlueprintTypes import BlueprintTypes
from blueprints.FragmentTypes import getFragmentType
from cache import cached_property
from chat_shared import MapRemovedFromBLReason, SYS_MESSAGE_TYPE, decompressSysMessage
from constants import ARENA_BONUS_TYPE, ARENA_GUI_TYPE, AUTO_MAINTENANCE_RESULT, AUTO_MAINTENANCE_TYPE, FAIRPLAY_VIOLATIONS, FINISH_REASON, INVOICE_ASSET, KICK_REASON, KICK_REASON_NAMES, NC_MESSAGE_PRIORITY, NC_MESSAGE_TYPE, OFFER_TOKEN_PREFIX, PREBATTLE_TYPE, PREMIUM_ENTITLEMENTS, PREMIUM_TYPE, RESTRICTION_TYPE, SYS_MESSAGE_CLAN_EVENT, SYS_MESSAGE_CLAN_EVENT_NAMES, SYS_MESSAGE_FORT_EVENT_NAMES, SwitchState, SECONDS_IN_DAY, BattleRoyaleResult, LOOTBOX_TOKEN_PREFIX
from debug_utils import LOG_ERROR
from dog_tags_common.components_config import componentConfigAdapter
from dog_tags_common.config.common import ComponentViewType
from dossiers2.custom.records import DB_ID_TO_RECORD, RECORD_DB_IDS
from dossiers2.ui.achievements import ACHIEVEMENT_BLOCK, BADGES_BLOCK
from dossiers2.ui.layouts import IGNORED_BY_BATTLE_RESULTS
from epic_constants import EPIC_BATTLE_LEVEL_IMAGE_INDEX
from goodies.goodie_constants import GOODIE_VARIETY
from gui import GUI_NATIONS, GUI_SETTINGS, makeHtmlString
from gui.Scaleform.genConsts.CURRENCIES_CONSTANTS import CURRENCIES_CONSTANTS
from gui.Scaleform.genConsts.RANKEDBATTLES_ALIASES import RANKEDBATTLES_ALIASES
from gui.SystemMessages import SM_TYPE
from gui.clans.formatters import getClanFullName
from gui.collection.collections_constants import COLLECTION_ITEM_PREFIX_NAME
from gui.dog_tag_composer import dogTagComposer
from gui.game_control.blueprints_convert_sale_controller import BCSActionState
from gui.impl import backport
from gui.impl.backport import getNiceNumberFormat
from gui.impl.gen import R
from gui.mapbox.mapbox_helpers import formatMapboxRewards
from gui.prb_control.formatters import getPrebattleFullDescription
from gui.ranked_battles.constants import YEAR_AWARD_SELECTABLE_OPT_DEVICE_PREFIX, YEAR_POINTS_TOKEN
from gui.ranked_battles.ranked_helpers import getQualificationBattlesCountFromID, isQualificationQuestID
from gui.ranked_battles.ranked_models import PostBattleRankInfo, RankChangeStates
from gui.resource_well.resource_well_constants import ServerResourceType
from gui.achievements.achievements_constants import Achievements20SystemMessages
from gui.server_events.awards_formatters import BATTLE_BONUS_X5_TOKEN, CompletionTokensBonusFormatter, CREW_BONUS_X3_TOKEN
from gui.server_events.bonuses import DEFAULT_CREW_LVL, EntitlementBonus, MetaBonus, VehiclesBonus, getMergedBonusesFromDicts
from gui.server_events.finders import PERSONAL_MISSION_TOKEN
from gui.server_events.recruit_helper import getRecruitInfo
from gui.shared import formatters as shared_fmts
from gui.shared.formatters import icons, text_styles
from gui.shared.formatters.currency import applyAll, getBWFormatter, getStyle
from gui.shared.formatters.time_formatters import RentDurationKeys, getTillTimeByResource, getTimeLeftInfo
from gui.shared.gui_items.Tankman import Tankman
from gui.shared.gui_items.Vehicle import getShortUserName, getUserName, getWotPlusExclusiveVehicleTypeUserName
from gui.shared.gui_items.crew_skin import localizedFullName
from gui.shared.gui_items.dossier.achievements.abstract.class_progress import ClassProgressAchievement
from gui.shared.gui_items.dossier.factories import getAchievementFactory
from gui.shared.gui_items.fitting_item import RentalInfoProvider
from gui.shared.gui_items.loot_box import REFERRAL_PROGRAM_CATEGORY
from gui.shared.gui_items.loot_box import EventLootBoxes
from gui.shared.money import Currency, MONEY_UNDEFINED, Money, ZERO_MONEY
from gui.shared.notifications import NotificationGuiSettings, NotificationPriorityLevel
from gui.shared.system_factory import collectTokenQuestsSubFormatters
from gui.shared.utils.requesters.ShopRequester import _NamedGoodieData
from gui.shared.utils.requesters.blueprints_requester import getFragmentNationID, getUniqueBlueprints
from gui.shared.utils.transport import z_loads
from gui.battle_pass.battle_pass_constants import ChapterState
from helpers import dependency, getLocalizedData, html, i18n, int2roman, time_utils
from items import ITEM_TYPES as I_T, getTypeInfoByIndex, getTypeInfoByName, tankmen, vehicles as vehicles_core, ITEM_TYPE_NAMES
from items.components.c11n_constants import CustomizationType, CustomizationTypeNames, UNBOUND_VEH_KEY
from items.components.crew_books_constants import CREW_BOOK_RARITY
from items.components.crew_skins_constants import NO_CREW_SKIN_ID
from items.tankmen import RECRUIT_TMAN_TOKEN_PREFIX
from items.vehicles import getVehicleType
from maps_training_common.maps_training_constants import SCENARIO_INDEXES, SCENARIO_RESULT
from messenger import g_settings
from messenger.ext import passCensor
from messenger.formatters import NCContextItemFormatter, TimeFormatter
from messenger.formatters.service_channel_helpers import EOL, MessageData, getCustomizationItem, getCustomizationItemData, getRewardsForQuests, mergeRewards, popCollectionEntitlements, parseTokenBonusCount
from nations import NAMES
from shared_utils import BoundMethodWeakref, first
from skeletons.gui.battle_matters import IBattleMattersController
from skeletons.gui.game_control import IBattlePassController, IBattleRoyaleController, ICollectionsSystemController, IEpicBattleMetaGameController, IFunRandomController, IMapboxController, IRankedBattlesController, IResourceWellController, IWinbackController, IWotPlusController, IBRProgressionOnTokensController, IEarlyAccessController, IGuiLootBoxesController, IWhiteTigerController
from skeletons.gui.goodies import IGoodiesCache
from skeletons.gui.lobby_context import ILobbyContext
from skeletons.gui.offers import IOffersDataProvider
from skeletons.gui.platform.catalog_service_controller import IPurchaseCache
from skeletons.gui.server_events import IEventsCache
from skeletons.gui.shared import IItemsCache
from gui.impl.lobby.comp7.comp7_quest_helpers import isComp7Quest, getComp7QuestType
from comp7_common import Comp7QuestType, COMP7_TOKEN_WEEKLY_REWARD_ID
from soft_exception import SoftException
if typing.TYPE_CHECKING:
    from typing import Any, Dict, List, Tuple, Callable, Optional
    from account_helpers.offers.events_data import OfferEventData, OfferGift
    from gui.platform.catalog_service.controller import _PurchaseDescriptor
    from messenger.proto.bw.wrappers import ServiceChannelMessage
_logger = logging.getLogger(__name__)
_TEMPLATE = b'template'
_RENT_TYPE_NAMES = {RentDurationKeys.DAYS: b'rentDays', 
   RentDurationKeys.BATTLES: b'rentBattles', 
   RentDurationKeys.WINS: b'rentWins'}
_BR_VIOLATIONS = (
 FAIRPLAY_VIOLATIONS.BATTLEROYALE_DESERTER, FAIRPLAY_VIOLATIONS.BATTLEROYALE_AFK)
_PREMIUM_MESSAGES = {PREMIUM_TYPE.BASIC: {str(SYS_MESSAGE_TYPE.premiumBought): R.strings.messenger.serviceChannelMessages.premiumBought(), 
                        str(SYS_MESSAGE_TYPE.premiumExtended): R.strings.messenger.serviceChannelMessages.premiumExtended(), 
                        str(SYS_MESSAGE_TYPE.premiumExpired): R.strings.messenger.serviceChannelMessages.premiumExpired(), 
                        str(SYS_MESSAGE_TYPE.premiumChanged): R.strings.messenger.serviceChannelMessages.premiumChanged()}, 
   PREMIUM_TYPE.PLUS: {str(SYS_MESSAGE_TYPE.premiumBought): R.strings.messenger.serviceChannelMessages.premiumPlusBought(), 
                       str(SYS_MESSAGE_TYPE.premiumExtended): R.strings.messenger.serviceChannelMessages.premiumPlusExtended(), 
                       str(SYS_MESSAGE_TYPE.premiumExpired): R.strings.messenger.serviceChannelMessages.premiumPlusExpired(), 
                       str(SYS_MESSAGE_TYPE.premiumChanged): R.strings.messenger.serviceChannelMessages.premiumPlusChanged()}}
_PREMIUM_TEMPLATES = {PREMIUM_ENTITLEMENTS.BASIC: b'battleQuestsPremium', 
   PREMIUM_ENTITLEMENTS.PLUS: b'battleQuestsPremiumPlus'}
_PROGRESSION_INVOICE_POSTFIX = b'progression'
EPIC_LEVELUP_TOKEN_TEMPLATE = b'epicmetagame:levelup:'

def _getTimeStamp(message):
    if message.createdAt is not None:
        result = time_utils.getTimestampFromUTC(message.createdAt.timetuple())
    else:
        result = time_utils.getCurrentTimestamp()
    return result


def _extendCustomizationData(newData, extendable, htmlTplPostfix):
    if extendable is None:
        return
    else:
        customizations = newData.get(b'customizations', [])
        for customizationItem in customizations:
            splittedCustType = customizationItem.get(b'custType', b'').split(b':')
            custType = splittedCustType[0]
            custValue = customizationItem[b'value']
            if len(splittedCustType) == 2 and _PROGRESSION_INVOICE_POSTFIX in splittedCustType[1]:
                continue
            if custValue > 0:
                operation = b'added'
            elif custValue < 0:
                operation = b'removed'
            else:
                operation = None
            if operation is not None:
                guiItemType, itemUserName, tags = getCustomizationItemData(customizationItem[b'id'], custType)
                if b'hiddenInUI' in tags:
                    continue
                custValue = abs(custValue)
                if custValue > 1:
                    extendable.append(backport.text(R.strings.system_messages.customization.dyn(operation).dyn((b'{}Value').format(guiItemType))(), itemUserName, custValue))
                else:
                    extendable.append(backport.text(R.strings.system_messages.customization.dyn(operation).dyn(guiItemType)(), itemUserName))
            if b'compensatedNumber' in customizationItem:
                compStr = InvoiceReceivedFormatter.getCustomizationCompensationString(customizationItem, htmlTplPostfix=htmlTplPostfix)
                if compStr:
                    extendable.append(compStr)

        return


@dependency.replace_none_kwargs(lobbyContext=ILobbyContext, itemsCache=IItemsCache)
def _extendCrewSkinsData(newData, extendable, lobbyContext=None, itemsCache=None):
    if extendable is None:
        return
    else:
        crewSkinsData = newData.get(b'crewSkins', None)
        if crewSkinsData is None:
            return
        totalCompensation = ZERO_MONEY
        accrued = []
        debited = []
        for crewSkinData in crewSkinsData:
            crewSkinID = crewSkinData.get(b'id', NO_CREW_SKIN_ID)
            count = crewSkinData.get(b'count', 0)
            if crewSkinID != NO_CREW_SKIN_ID:
                totalCompensation += Money(credits=crewSkinData.get(b'customCompensation', 0))
                if count:
                    crewSkinItem = itemsCache.items.getCrewSkin(crewSkinID)
                    if crewSkinItem is not None:
                        crewSkinUserStrings = accrued if count > 0 else debited
                        if abs(count) > 1:
                            crewSkinUserStrings.append(backport.text(R.strings.messenger.serviceChannelMessages.crewSkinsCount(), label=localizedFullName(crewSkinItem), count=str(abs(count))))
                        else:
                            crewSkinUserStrings.append(localizedFullName(crewSkinItem))

        if accrued:
            resultStr = g_settings.htmlTemplates.format(b'crewSkinsAccruedReceived', ctx={b'crewSkins': (b', ').join(accrued)})
            extendable.append(resultStr)
        if debited:
            resultStr = g_settings.htmlTemplates.format(b'crewSkinsDebitedReceived', ctx={b'crewSkins': (b', ').join(debited)})
            extendable.append(resultStr)
        formattedCurrencies = []
        currencies = totalCompensation.getSetCurrencies(byWeight=True)
        for currency in currencies:
            formattedCurrencies.append(applyAll(currency, totalCompensation.get(currency=currency)))

        if formattedCurrencies:
            extendable.append(backport.text(R.strings.system_messages.crewSkinsCompensation.success(), compensation=(b', ').join(formattedCurrencies)))
        return


def _processRareAchievements(rares):
    unknownAchieves = 0
    achievements = []
    for rareID in rares:
        achieve = getAchievementFactory((ACHIEVEMENT_BLOCK.RARE, rareID)).create()
        if achieve is None:
            unknownAchieves += 1
        else:
            achievements.append(achieve.getUserName())

    if unknownAchieves:
        shortcut = R.strings.system_messages.actionAchievement
        if unknownAchieves > 1:
            shortcut = R.strings.system_messages.actionAchievements
        achievements.append(backport.text(shortcut.title()))
    return achievements


def _getRareAchievements(dossiers):
    rares = []
    for d in dossiers.itervalues():
        it = d if not isinstance(d, dict) else d.iteritems()
        for (blck, _), rec in it:
            if blck == ACHIEVEMENT_BLOCK.RARE:
                rares.append(rec[b'value'])

    return rares


def _toPairLists(dct):
    return [ [k, v] for k, v in dct.iteritems() ]


def _composeAchievements(dossiers):
    result = {}
    for dossierKey, rec in dossiers.iteritems():
        uniqueReceived, uniqueRemoved, other = {}, {}, []
        it = rec if not isinstance(rec, dict) else rec.iteritems()
        for recType, recData in it:
            value = recData[b'value']
            if value == 0:
                continue
            updated = uniqueReceived if value > 0 else uniqueRemoved
            _updateUnique(recType, recData, updated, other)

        result[dossierKey] = _toPairLists(uniqueReceived) + _toPairLists(uniqueRemoved) + other

    return result


def _updateUnique(recType, recData, uniqueAchieves, nonMerged):
    if recType not in uniqueAchieves:
        uniqueAchieves[recType] = recData
        return
    savedRecData = uniqueAchieves[recType]
    if savedRecData[b'type'] == recData[b'type']:
        savedRecData[b'value'] += recData[b'value']
        savedActualValue = savedRecData[b'actualValue']
        updateFunc = max if recData[b'value'] > 0 else min
        savedRecData[b'actualValue'] = updateFunc(savedActualValue, recData[b'actualValue'])
    else:
        nonMerged.append([recType, recData])


def _getFormatAchieveString(name, block, recData):
    if b'actualValue' in recData:
        achieve = getAchievementFactory((block, name)).create(recData[b'actualValue'])
    else:
        achieve = None
        _logger.warning(b"Couldn't find 'actualValue' field in data %s", recData)
    if achieve is not None:
        achieveName = achieve.getUserName()
    else:
        achieveName = backport.text(R.strings.achievements.dyn(name)())
    if not isinstance(achieve, ClassProgressAchievement):
        value = abs(recData[b'value'])
        if value > 1:
            return (b'').join((achieveName,
             backport.text(R.strings.messenger.serviceChannelMessages.multiplier(), count=backport.getIntegralFormat(value))))
    return achieveName


def _getRaresAchievementsStrings(battleResults):
    dossiers = battleResults.get(b'dossier', {})
    rares = []
    for d in dossiers.itervalues():
        it = d if not isinstance(d, dict) else d.iteritems()
        for (blck, _), rec in it:
            if blck == ACHIEVEMENT_BLOCK.RARE:
                value = rec[b'value']
                if value > 0:
                    rares.append(value)

    if rares:
        return _processRareAchievements(rares)
    else:
        return


def _getCrewBookUserString(itemDescr):
    params = {}
    if itemDescr.type not in CREW_BOOK_RARITY.NO_NATION_TYPES:
        params[b'nation'] = i18n.makeString((b'#nations:{}').format(itemDescr.nation))
    return i18n.makeString(itemDescr.name, **params)


def _getAchievementsFromQuestData(data):
    achievesList = []
    for rec in data.get(b'dossier', {}).values():
        it = rec if not isinstance(rec, dict) else rec.iteritems()
        for (block, name), value in it:
            if block not in ACHIEVEMENT_BLOCK.ALL:
                continue
            achieve = getAchievementFactory((block, name)).create(value.get(b'actualValue', 0))
            if achieve is not None:
                achievesList.append(achieve.getUserName())
            else:
                achievesList.append(backport.text(R.strings.achievements.dyn(name)()))

    return achievesList


def _processTankmanToken(tokenName):
    if tokenName.startswith(RECRUIT_TMAN_TOKEN_PREFIX):
        tankmanInfo = getRecruitInfo(tokenName)
        if tankmanInfo is not None:
            rBattlePass = R.strings.battle_pass
            text = backport.text(rBattlePass.universalTankmanBonus(), name=tankmanInfo.getFullUserName())
            return g_settings.htmlTemplates.format(b'battlePassTMan', {b'text': text})
    return


def _processOfferToken(tokenName, count):
    if tokenName.startswith(OFFER_TOKEN_PREFIX):
        text = backport.text(R.strings.messenger.serviceChannelMessages.offerTokenBonus.title())
        offerName = g_settings.htmlTemplates.format(b'offerTokenText', {b'text': text})
        template = b'offersAccruedInvoiceReceived' if count > 0 else b'offersDebitedInvoiceReceived'
        return g_settings.htmlTemplates.format(template, {b'offer': offerName})
    else:
        return


@dependency.replace_none_kwargs(collections=IGuiLootBoxesController)
def _processLootBoxKeyToken(tokenName, amount, collections=None):
    if tokenName.startswith(constants.LOOTBOX_KEY_PREFIX) and amount > 0:
        tokenId = collections.getKeyByTokenID(tokenName)
        if tokenId:
            template = b'lbKeysAccruedInvoiceReceived'
            return g_settings.htmlTemplates.format(template, {b'lootbox_key': backport.text(R.strings.lootboxes.userName.dyn(tokenId.userName)()), 
               b'amount': amount})
    return


@dependency.replace_none_kwargs(collections=ICollectionsSystemController)
def _getCollectionItemName(entitlementName, collections=None):
    from gui.collection.collections_helpers import getItemName
    collectionID, itemID = entitlementName.split(b'_')[2:]
    return getItemName(int(collectionID), collections.getCollectionItem(int(collectionID), int(itemID)))


class ServiceChannelFormatter(object):

    def format(self, data, *args):
        return []

    def isNotify(self):
        return True

    def isAsync(self):
        return False

    def canBeEmpty(self):
        return False

    def _getGuiSettings(self, data, key=None, priorityLevel=None, messageType=None, messageSubtype=None, decorator=None):
        try:
            isAlert = data.isHighImportance and data.active
        except AttributeError:
            isAlert = False

        if priorityLevel is None:
            priorityLevel = g_settings.msgTemplates.priority(key)
        lifeTime = g_settings.msgTemplates.lifeTime(key)
        return NotificationGuiSettings(self.isNotify(), priorityLevel, isAlert, messageType=messageType, messageSubtype=messageSubtype, decorator=decorator, lifeTime=lifeTime)


class SimpleFormatter(ServiceChannelFormatter):

    def __init__(self, templateName):
        self._template = templateName

    def format(self, message, *args):
        if message is None:
            return []
        else:
            formatted = g_settings.msgTemplates.format(self._template, ctx=self.getCtx(message, *args))
            return [MessageData(formatted, self._getGuiSettings(message, self._template))]

    def getCtx(self, message, *args):
        return

    def getConvertedDateTime(self, dTime):
        return TimeFormatter.getShortDatetimeFormat(time_utils.makeLocalServerTime(dTime))


class ExclusiveVehicleWotPlusFormatter(ServiceChannelFormatter):

    def __init__(self, isEnabled=False):
        self.template = b'WotPlusExclusiveVehicleDisabledMessage' if not isEnabled else b'WotPlusExclusiveVehicleEnabledMessage'

    def format(self, message, *args):
        if message.data:
            formatted = g_settings.msgTemplates.format(self.template, ctx={b'vehicleName': self.__getVehicleName(message.data.get(b'vehCD', -1)), 
               b'vehicleType': self.__getVehicleType(message.data.get(b'vehCD', -1))})
            return [
             MessageData(formatted, self._getGuiSettings(message, self.template))]
        return []

    def __getVehicleName(self, vehTypeCD):
        return getUserName(getVehicleType(vehTypeCD))

    def __getVehicleType(self, vehTypeCD):
        return getWotPlusExclusiveVehicleTypeUserName(getVehicleType(vehTypeCD).getVehicleClass())


class WaitItemsSyncFormatter(ServiceChannelFormatter):
    _itemsCache = dependency.descriptor(IItemsCache)

    def __init__(self):
        self.__callbackQueue = None
        return

    def isAsync(self):
        return True

    @adisp_async
    def _waitForSyncItems(self, callback):
        if self._itemsCache.isSynced():
            callback(True)
        else:
            self.__registerHandler(callback)

    def __registerHandler(self, callback):
        if not self.__callbackQueue:
            self.__callbackQueue = Queue()
        self.__callbackQueue.put(callback)
        self._itemsCache.onSyncCompleted += self.__onSyncCompleted

    def __unregisterHandler(self):
        self.__callbackQueue = None
        self._itemsCache.onSyncCompleted -= self.__onSyncCompleted
        return

    def __onSyncCompleted(self, *_):
        while not self.__callbackQueue.empty():
            try:
                self.__callbackQueue.get_nowait()(self._itemsCache.isSynced())
            except Exception:
                _logger.exception(b'Exception in service channel formatter')

        self.__unregisterHandler()


class ServerRebootFormatter(ServiceChannelFormatter):

    def format(self, message, *args):
        if message.data:
            local_dt = time_utils.utcToLocalDatetime(message.data)
            formatted = g_settings.msgTemplates.format(b'serverReboot', ctx={b'date': local_dt.strftime(b'%c')})
            return [
             MessageData(formatted, self._getGuiSettings(message, b'serverReboot'))]
        else:
            return [
             MessageData(None, None)]


class ServerRebootCancelledFormatter(ServiceChannelFormatter):

    def format(self, message, *args):
        if message.data:
            local_dt = time_utils.utcToLocalDatetime(message.data)
            formatted = g_settings.msgTemplates.format(b'serverRebootCancelled', ctx={b'date': local_dt.strftime(b'%c')})
            return [
             MessageData(formatted, self._getGuiSettings(message, b'serverRebootCancelled'))]
        else:
            return [
             MessageData(None, None)]


class FormatSpecialReward(object):
    __lobbyContext = dependency.descriptor(ILobbyContext)
    __battleMattersController = dependency.descriptor(IBattleMattersController)
    __winbackController = dependency.descriptor(IWinbackController)
    __funRandomController = dependency.descriptor(IFunRandomController)

    def getString(self, message):
        formattedItems = self.__formattedItems(message)
        if not formattedItems:
            return None
        else:
            return g_settings.msgTemplates.format(b'specialReward', ctx={b'specialRewardItems': formattedItems})

    def __formattedItems(self, message):
        data = message.data
        itemsNames = []
        data = self.__extractExcludedItems(data)
        itemsNames.extend(self.__getCrewBookNames(data.get(b'items', {})))
        itemsNames.extend(self.__getBlueprintNames(data.get(b'blueprints', {})))
        if not itemsNames:
            return None
        else:
            return g_settings.htmlTemplates.format(b'specialRewardItems', ctx={b'names': (b'<br/>').join(itemsNames)})

    def __getCrewBookNames(self, items):
        result = []
        for intCD, count in items.iteritems():
            itemTypeID, _, _ = vehicles_core.parseIntCompactDescr(intCD)
            if itemTypeID != I_T.crewBook:
                continue
            itemDescr = tankmen.getItemByCompactDescr(intCD)
            name = _getCrewBookUserString(itemDescr)
            result.append(backport.text(R.strings.messenger.serviceChannelMessages.battleResults.quests.items.name(), name=name, count=backport.getIntegralFormat(count)))

        return result

    def __getBlueprintNames(self, blueprints):
        vehicleFragments, nationFragments, universalFragments = getUniqueBlueprints(blueprints)
        result = []
        for fragmentCD, count in vehicleFragments.iteritems():
            fragmentsCount = backport.getIntegralFormat(count)
            vehicleName = getUserName(vehicles_core.getVehicleType(abs(fragmentCD)))
            result.append(backport.text(R.strings.messenger.serviceChannelMessages.specialReward.vehicleBlueprints(), vehicleName=vehicleName, fragmentsCount=fragmentsCount))

        for nationID, count in nationFragments.iteritems():
            fragmentsCount = backport.getIntegralFormat(count)
            nationName = backport.text(R.strings.nations.dyn(NAMES[nationID])())
            result.append(backport.text(R.strings.messenger.serviceChannelMessages.specialReward.nationalBlueprints(), nationName=nationName, fragmentsCount=fragmentsCount))

        if universalFragments:
            fragmentsCount = backport.getIntegralFormat(universalFragments)
            result.append(backport.text(R.strings.messenger.serviceChannelMessages.specialReward.intelligenceBlueprints(), fragmentsCount=fragmentsCount))
        return result

    def __extractExcludedItems(self, data):
        excludeFilters = (
         self.__battleMattersController.isBattleMattersQuestID,
         self.__funRandomController.progressions.isProgressionExecutor,
         self.__winbackController.isWinbackQuest)
        excludedQuests = (qID for qID in data.get(b'completedQuestIDs', set()) if any(excludeFilter(qID) for excludeFilter in excludeFilters))
        processingTypes = ('blueprints', 'items')
        resultData = {rewardType:copy(data.get(rewardType, {})) for rewardType in processingTypes}
        for rewardType in processingTypes:
            for questID in excludedQuests:
                rewards = data[b'detailedRewards'][questID].get(rewardType, {})
                for k, v in rewards.iteritems():
                    resultData[rewardType][k] -= v
                    if resultData[rewardType][k] <= 0:
                        resultData[rewardType].pop(k)

            if not resultData[rewardType]:
                resultData.pop(rewardType)

        return resultData


class Comp7BattleQuestsFormatter(object):

    def format(self, message):
        formattedSysMessages = []
        if message.data:
            for questID in self.__getComp7Quests(message.data.get(b'completedQuestIDs', set())):
                questType = getComp7QuestType(questID)
                if questType == Comp7QuestType.WEEKLY:
                    formattedMessage = self.__formatWeeklyReward(message, questID)
                elif questType == Comp7QuestType.TOKENS:
                    formattedMessage = self.__formatTokensReward(message, questID)
                else:
                    formattedMessage = None
                if formattedMessage is not None:
                    formattedSysMessages.append(formattedMessage)

        return formattedSysMessages

    def __getComp7Quests(self, questIDs):
        return set(qId for qId in questIDs if isComp7Quest(qId))

    def __formatWeeklyReward(self, message, questID):
        rewardsData = message.data.get(b'detailedRewards', {}).get(questID, {})
        if rewardsData:
            achievesFormatter = QuestAchievesFormatter()
            return g_settings.msgTemplates.format(b'comp7RegularRewardMessage', ctx={b'title': backport.text(R.strings.comp7.system_messages.weeklyReward.title()), 
               b'body': backport.text(R.strings.comp7.system_messages.weeklyReward.body(), at=TimeFormatter.getLongDatetimeFormat(time_utils.makeLocalServerTime(message.sentTime)), rewards=achievesFormatter.formatQuestAchieves(rewardsData, asBattleFormatter=False))})
        else:
            return

    def __formatTokensReward(self, message, questID):
        rewardsData = message.data.get(b'detailedRewards', {}).get(questID, {})
        dossierData = rewardsData.get(b'dossier')
        if dossierData:
            popUps = self.__getDossierPopUps(dossierData, message.data.get(b'popUpRecords', set()))
            rewardsData.update({b'popUpRecords': popUps})
        if rewardsData:
            achievesFormatter = QuestAchievesFormatter()
            return g_settings.msgTemplates.format(b'comp7RegularRewardMessage', ctx={b'title': backport.text(R.strings.comp7.system_messages.tokenWeeklyReward.title()), 
               b'body': backport.text(R.strings.comp7.system_messages.tokenWeeklyReward.body(), at=TimeFormatter.getLongDatetimeFormat(time_utils.makeLocalServerTime(message.sentTime)), rewards=achievesFormatter.formatQuestAchieves(rewardsData, asBattleFormatter=False))})
        else:
            return

    def __getDossierPopUps(self, dossierData, popUpRecords):
        popUps = set()
        for dossierRecord in chain.from_iterable(dossierData.values()):
            if dossierRecord[0] in ACHIEVEMENT_BLOCK.ALL:
                achievementID = RECORD_DB_IDS.get(dossierRecord, None)
                popUps.update(popUp for popUp in popUpRecords if popUp[0] == achievementID)

        return popUps


class BattleResultsFormatter(WaitItemsSyncFormatter):
    __rankedController = dependency.descriptor(IRankedBattlesController)
    __battleRoyaleController = dependency.descriptor(IBattleRoyaleController)
    __battleRoyaleProgressionCtrl = dependency.descriptor(IBRProgressionOnTokensController)
    __eventsCache = dependency.descriptor(IEventsCache)
    __gameEventController = dependency.descriptor(IWhiteTigerController)
    _battleResultKeys = {-1: b'battleDefeatResult', 
       0: b'battleDrawGameResult', 
       1: b'battleVictoryResult'}
    __BRResultKeys = {BattleRoyaleResult.DISQUALIFIED: b'battleRoyaleDisqualifiedResult', 
       BattleRoyaleResult.LOSE: b'battleRoyaleDefeatResult', 
       BattleRoyaleResult.DRAW: b'battleRoyaleDefeatResult', 
       BattleRoyaleResult.WIN: b'battleRoyaleVictoryResult'}
    __MTResultKeys = {SCENARIO_RESULT.LOSE: b'mapsTrainingDefeatResult', 
       SCENARIO_RESULT.WIN: b'mapsTrainingVictoryResult'}
    __COMP7SeasonResultsKeys = {SCENARIO_RESULT.LOSE: b'comp7SeasonBattleDefeatResult', 
       SCENARIO_RESULT.PARTIAL: b'comp7SeasonBattleDrawGameResult', 
       SCENARIO_RESULT.WIN: b'comp7SeasonBattleVictoryResult'}
    __COMP7QualificationResultsKeys = {SCENARIO_RESULT.LOSE: b'comp7QualificationBattleDefeatResult', 
       SCENARIO_RESULT.PARTIAL: b'comp7QualificationBattleDrawGameResult', 
       SCENARIO_RESULT.WIN: b'comp7QualificationBattleVictoryResult'}
    __goldTemplateKey = b'battleResultGold'
    __questsTemplateKey = b'battleQuests'

    def isNotify(self):
        return True

    @adisp_async
    @adisp_process
    def format(self, message, callback):
        isSynced = yield self._waitForSyncItems()
        if message.data and isSynced:
            battleResults = message.data
            arenaTypeID = battleResults.get(b'arenaTypeID', 0)
            if arenaTypeID > 0 and arenaTypeID in ArenaType.g_cache:
                arenaType = ArenaType.g_cache[arenaTypeID]
            else:
                arenaType = None
            arenaCreateTime = battleResults.get(b'arenaCreateTime', None)
            if arenaCreateTime and arenaType:
                ctx = {b'arenaName': i18n.makeString(arenaType.name), b'vehicleNames': b'N/A', 
                   b'xp': b'0', 
                   Currency.CREDITS: b'0'}
                templateName, formatData = self._prepareFormatData(message)
                ctx.update(formatData)
                bgIconSource = self._getBackgroundIconSource(battleResults)
                arenaUniqueID = battleResults.get(b'arenaUniqueID', 0)
                formatted = g_settings.msgTemplates.format(templateName, ctx=ctx, data={b'timestamp': arenaCreateTime, 
                   b'savedData': arenaUniqueID}, bgIconSource=bgIconSource)
                formattedSpecialReward = FormatSpecialReward().getString(message)
                settings = self._getGuiSettings(message, templateName)
                settings.showAt = BigWorld.time()
                messages = list()
                if formattedSpecialReward:
                    messages.append(MessageData(formattedSpecialReward, settings))
                comp7QuestsFormatter = Comp7BattleQuestsFormatter()
                for reward in comp7QuestsFormatter.format(message):
                    messages.append(MessageData(reward, settings))

                messages.append(MessageData(formatted, settings))
                callback(messages)
            else:
                callback([MessageData(None, None)])
        else:
            callback([MessageData(None, None)])
        return

    def _getBackgroundIconSource(self, battleResults):
        return

    def _prepareFormatData(self, message):
        battleResults = message.data
        ctx = {}
        vehicleNames = {intCD:self._itemsCache.items.getItemByCD(intCD) for intCD in battleResults.get(b'playerVehicles', {}).keys()}
        ctx[b'vehicleNames'] = (b', ').join(map(operator.attrgetter(b'userName'), sorted(vehicleNames.values())))
        xp = battleResults.get(b'xp')
        if xp:
            ctx[b'xp'] = backport.getIntegralFormat(xp)
        battleResKey = battleResults.get(b'isWinner', 0)
        ctx[b'xpEx'] = self.__makeXpExString(xp, battleResKey, battleResults.get(b'xpPenalty', 0), battleResults)
        ctx[Currency.GOLD] = self.__makeGoldString(battleResults.get(Currency.GOLD, 0))
        accCredits = battleResults.get(Currency.CREDITS) + battleResults.get(b'teamSubsBonusCredits', 0) - battleResults.get(b'creditsToDraw', 0)
        if accCredits:
            ctx[Currency.CREDITS] = self.__makeCurrencyString(Currency.CREDITS, accCredits)
        ctx[b'piggyBank'] = self.__makePiggyBankString(battleResults.get(b'piggyBank'))
        ctx[b'goldBankGain'] = self.__makeGoldBankGainString(battleResults.get(b'goldBankGain'))
        accCrystal = battleResults.get(Currency.CRYSTAL)
        ctx[b'crystalStr'] = b''
        if accCrystal:
            ctx[Currency.CRYSTAL] = self.__makeCurrencyString(Currency.CRYSTAL, accCrystal)
            ctx[b'crystalStr'] = g_settings.htmlTemplates.format(b'battleResultCrystal', {Currency.CRYSTAL: ctx[Currency.CRYSTAL]})
        accEventCoin = battleResults.get(Currency.EVENT_COIN)
        ctx[b'eventCoinStr'] = b''
        if accEventCoin:
            ctx[Currency.EVENT_COIN] = self.__makeCurrencyString(Currency.EVENT_COIN, accEventCoin)
            ctx[b'eventCoinStr'] = g_settings.htmlTemplates.format(b'battleResultEventCoin', {Currency.EVENT_COIN: ctx[Currency.EVENT_COIN]})
        accBpcoin = battleResults.get(Currency.BPCOIN)
        ctx[b'bpcoinStr'] = b''
        if accBpcoin:
            ctx[Currency.BPCOIN] = self.__makeCurrencyString(Currency.BPCOIN, accBpcoin)
            ctx[b'bpcoinStr'] = g_settings.htmlTemplates.format(b'battleResultBpcoin', {Currency.BPCOIN: ctx[Currency.BPCOIN]})
        accEqCoin = battleResults.get(Currency.EQUIP_COIN)
        ctx[b'equipCoinStr'] = b''
        if accEqCoin:
            ctx[Currency.EQUIP_COIN] = self.__makeCurrencyString(Currency.EQUIP_COIN, accEqCoin)
            ctx[b'equipCoinStr'] = g_settings.htmlTemplates.format(b'battleResultEquipCoin', {Currency.EQUIP_COIN: ctx[Currency.EQUIP_COIN]})
        ctx[b'creditsEx'] = self.__makeCreditsExString(accCredits, battleResults.get(b'creditsPenalty', 0), battleResults.get(b'creditsContributionIn', 0), battleResults.get(b'creditsContributionOut', 0))
        platformCurrencies = battleResults.get(b'currencies', {})
        if platformCurrencies:
            ctx[b'platformCurrencyStr'] = b'<br/>' + (b'<br/>').join(g_settings.htmlTemplates.format(b'platformCurrency', {b'msg': backport.text(R.strings.messenger.platformCurrencyMsg.received.dyn(currency)()), b'count': backport.getIntegralFormat(countDict.get(b'count', 0))}) for currency, countDict in platformCurrencies.iteritems())
        else:
            ctx[b'platformCurrencyStr'] = b''
        guiType = battleResults.get(b'guiType', 0)
        ctx[b'achieves'], ctx[b'badges'] = self.__makeAchievementsAndBadgesStrings(battleResults)
        ctx[b'rankedProgress'] = self.__makeRankedFlowStrings(battleResults)
        ctx[b'rankedBonusBattles'] = self.__makeRankedBonusString(battleResults)
        ctx[b'battlePassProgress'] = self.__makeBattlePassProgressionString(guiType, battleResults)
        ctx[b'lock'] = self.__makeVehicleLockString(vehicleNames, battleResults)
        ctx[b'quests'] = self.__makeQuestsAchieve(message)
        team = battleResults.get(b'team', 0)
        if guiType == ARENA_GUI_TYPE.FORT_BATTLE_2 or guiType == ARENA_GUI_TYPE.SORTIE_2:
            if battleResKey == 0:
                winnerIfDraw = battleResults.get(b'winnerIfDraw')
                if winnerIfDraw:
                    battleResKey = 1 if winnerIfDraw == team else -1
        if guiType == ARENA_GUI_TYPE.BATTLE_ROYALE:
            ctx[b'brcoin'] = self.__makeBRCoinString(battleResults)
            ctx[b'brAwardTokens'] = self.__makeBRProgressionTokenString(battleResults)
            battleResultKeys = self.__BRResultKeys
            if self.__isBRDisqualified(battleResults):
                battleResKey = BattleRoyaleResult.DISQUALIFIED
        elif guiType == ARENA_GUI_TYPE.MAPS_TRAINING:
            ctx = self.__makeMapsTrainingMsgCtx(battleResults, ctx)
            battleResKey = battleResults.get(b'mtScenarioResult')
            battleResultKeys = self.__MTResultKeys
        elif guiType == ARENA_GUI_TYPE.COMP7:
            isQualificationBattle = battleResults.get(b'comp7QualActive', False)
            if isQualificationBattle:
                battleResultKeys = self.__COMP7QualificationResultsKeys
            else:
                battleResultKeys = self.__COMP7SeasonResultsKeys
                ctx = self.__makeComp7SeasonMsgCtx(battleResults, ctx)
        else:
            battleResultKeys = self._battleResultKeys
        templateName = battleResultKeys[battleResKey]
        return (
         templateName, ctx)

    def __makeMapsTrainingMsgCtx(self, battleResults, ctx):
        vehTypeCompDescr = next(battleResults[b'playerVehicles'].iterkeys())
        vType = vehicles_core.getVehicleType(vehTypeCompDescr)
        vehicleClass = vehicles_core.getVehicleClassFromVehicleType(vType)
        team = battleResults[b'team']
        vehTypeStr = backport.text(R.strings.maps_training.vehicleType.dyn(vehicleClass)())
        ctx[b'baseStr'] = backport.text(R.strings.maps_training.baseNum()).format(base=team)
        ctx[b'mtRewards'] = self.__makeMapsTrainingRewardsMsg(battleResults)
        ctx[b'scenario'] = backport.text(R.strings.maps_training.scenarioTooltip.scenario.title()).format(num=SCENARIO_INDEXES[(team, vehicleClass)], vehicleType=vehTypeStr)
        return ctx

    def __makeMapsTrainingRewardsMsg(self, battleResults):
        if not battleResults.get(b'mtCanGetRewards'):
            return g_settings.htmlTemplates.format(b'mtRewardGot')
        rewards = []
        creditsReward = battleResults.get(b'credits', 0)
        creditsXMLString = b'mtCreditsHighlight' if creditsReward else b'mtCredits'
        rewards.append(g_settings.htmlTemplates.format(creditsXMLString, ctx={b'credits': self.__makeCurrencyString(Currency.CREDITS, creditsReward)}))
        freeXP = battleResults.get(b'freeXP', 0)
        if freeXP:
            rewards.append(g_settings.htmlTemplates.format(b'mtFreeXP', ctx={b'freeXP': backport.getIntegralFormat(freeXP)}))
        questResults = QuestAchievesFormatter.formatQuestAchieves(battleResults, asBattleFormatter=True)
        if questResults:
            rewards.append(g_settings.htmlTemplates.format(b'mtQuests', ctx={b'quests': questResults}))
        return (b'<br/>').join(rewards)

    def __makeComp7SeasonMsgCtx(self, battleResults, ctx):
        ctx[b'ratingPointsStr'] = g_settings.htmlTemplates.format(b'battleResultRatingPoints', {b'ratingPoints': (b'{:+}').format(battleResults[b'comp7RatingDelta'])})
        return ctx

    def __makeQuestsAchieve(self, message):
        fmtMsg = QuestAchievesFormatter.formatQuestAchieves(message.data, asBattleFormatter=True)
        if fmtMsg is not None:
            return g_settings.htmlTemplates.format(b'battleQuests', {b'achieves': fmtMsg})
        else:
            return b''

    def __makeVehicleLockString(self, vehicleNames, battleResults):
        locks = []
        for vehIntCD, battleResult in battleResults.get(b'playerVehicles', {}).iteritems():
            expireTime = battleResult.get(b'vehTypeUnlockTime', 0)
            if not expireTime:
                continue
            vehicleName = vehicleNames.get(vehIntCD)
            if vehicleName is None:
                continue
            locks.append(g_settings.htmlTemplates.format(b'battleResultLocks', ctx={b'vehicleName': vehicleName, 
               b'expireTime': TimeFormatter.getLongDatetimeFormat(expireTime)}))

        return (b', ').join(locks)

    def __makeXpExString(self, xp, battleResKey, xpPenalty, battleResults):
        if not xp:
            return b''
        exStrings = []
        if xpPenalty > 0:
            exStrings.append(backport.text(R.strings.messenger.serviceChannelMessages.battleResults.penaltyForDamageAllies(), backport.getIntegralFormat(xpPenalty)))
        if battleResKey == 1:
            xpFactorStrings = []
            xpFactor = battleResults.get(b'dailyXPFactor', 1)
            if xpFactor > 1:
                xpFactorStrings.append(backport.text(R.strings.messenger.serviceChannelMessages.battleResults.doubleXpFactor()) % xpFactor)
            if xpFactorStrings:
                exStrings.append((b', ').join(xpFactorStrings))
        if exStrings:
            return (b' ({0:s})').format((b'; ').join(exStrings))
        return b''

    def __makeCreditsExString(self, accCredits, creditsPenalty, creditsContributionIn, creditsContributionOut):
        if not accCredits:
            return b''
        formatter = getBWFormatter(Currency.CREDITS)
        exStrings = []
        penalty = sum([
         creditsPenalty,
         creditsContributionOut])
        if penalty > 0:
            exStrings.append(backport.text(R.strings.messenger.serviceChannelMessages.battleResults.penaltyForDamageAllies(), formatter(penalty)))
        if creditsContributionIn > 0:
            exStrings.append(backport.text(R.strings.messenger.serviceChannelMessages.battleResults.contributionForDamageAllies(), formatter(creditsContributionIn)))
        if exStrings:
            return (b' ({0:s})').format((b'; ').join(exStrings))
        return b''

    def __makeGoldString(self, gold):
        if not gold:
            return b''
        formatter = getBWFormatter(Currency.GOLD)
        return g_settings.htmlTemplates.format(self.__goldTemplateKey, {Currency.GOLD: formatter(gold)})

    def __makeCurrencyString(self, currency, credit):
        formatter = getBWFormatter(currency)
        return formatter(credit)

    def __makeAchievementsAndBadgesStrings(self, battleResults):
        popUpRecords = []
        badges = []
        for _, vehBattleResults in battleResults.get(b'playerVehicles', {}).iteritems():
            for recordIdx, value in vehBattleResults.get(b'popUpRecords', []):
                recordName = DB_ID_TO_RECORD[recordIdx]
                if recordName in IGNORED_BY_BATTLE_RESULTS:
                    continue
                block, name = recordName
                if block == BADGES_BLOCK:
                    badges.append(name)
                else:
                    achieve = getAchievementFactory(recordName).create(value=value)
                    if achieve is not None and achieve not in popUpRecords:
                        popUpRecords.append(achieve)

            if b'markOfMastery' in vehBattleResults and vehBattleResults[b'markOfMastery'] > 0:
                popUpRecords.append(getAchievementFactory((ACHIEVEMENT_BLOCK.TOTAL, b'markOfMastery')).create(value=vehBattleResults[b'markOfMastery']))

        achievementsStrings = [ a.getUserName() for a in sorted(popUpRecords) ]
        raresStrings = _getRaresAchievementsStrings(battleResults)
        if raresStrings:
            achievementsStrings.extend(raresStrings)
        achievementsBlock = b''
        if achievementsStrings:
            achievementsBlock = g_settings.htmlTemplates.format(b'battleResultAchieves', {b'achieves': (b', ').join(achievementsStrings)})
        badgesBlock = b''
        if badges:
            badgesStr = (b', ').join([ backport.text(R.strings.badge.dyn((b'badge_{}').format(badgeID))()) for badgeID in badges ])
            badgesBlock = b'<br/>' + g_settings.htmlTemplates.format(b'badgeAchievement', {b'badges': badgesStr})
        return (achievementsBlock, badgesBlock)

    def __makeRankedFlowStrings(self, battleResults):
        rankedProgressStrings = []
        if battleResults.get(b'guiType', 0) == ARENA_GUI_TYPE.RANKED:
            rankInfo = PostBattleRankInfo.fromDict(battleResults)
            stateChange = self.__rankedController.getRankChangeStatus(rankInfo)
            if stateChange in (RankChangeStates.QUAL_EARNED, RankChangeStates.QUAL_UNBURN_EARNED):
                stateChange = RankChangeStates.DIVISION_EARNED
            shortcut = R.strings.messenger.serviceChannelMessages.battleResults
            stateChangeResID = shortcut.rankedState.dyn(stateChange)()
            if stateChange == RankChangeStates.DIVISION_EARNED:
                divisionNumber = backport.text(shortcut.divisions.dyn(self.__rankedController.getDivision(rankInfo.accRank + 1).getUserID())())
                stateChangeStr = backport.text(stateChangeResID, divisionNumber=divisionNumber)
            elif stateChange in (RankChangeStates.RANK_LOST, RankChangeStates.RANK_EARNED):
                rankID = rankInfo.prevAccRank
                if stateChange == RankChangeStates.RANK_EARNED:
                    rankID = rankInfo.accRank
                division = self.__rankedController.getDivision(rankID)
                rankName = division.getRankUserName(rankID)
                divisionName = division.getUserName()
                stateChangeStr = backport.text(stateChangeResID, rankName=rankName, divisionName=divisionName)
            else:
                stateChangeStr = backport.text(stateChangeResID)
                isWin = True if battleResults.get(b'isWinner', 0) > 0 else False
                if stateChange == RankChangeStates.NOTHING_CHANGED and isWin:
                    stateChangeStr = backport.text(shortcut.rankedState.stageNotEarned())
                shieldState = rankInfo.shieldState
                if shieldState == RANKEDBATTLES_ALIASES.SHIELD_LOSE:
                    stateChangeStr = backport.text(shortcut.rankedState.shieldLose())
            rankedProgressStrings.append(stateChangeStr)
        rankedProgressBlock = b''
        if rankedProgressStrings:
            rankedProgressBlock = g_settings.htmlTemplates.format(b'battleResultRankedProgress', {b'rankedProgress': (b', ').join(rankedProgressStrings)})
        return rankedProgressBlock

    def __makeRankedBonusString(self, battleResults):
        bonusBattlesString = b''
        persistBattles = battleResults.get(b'rankedBonusBattles', 0)
        if persistBattles:
            questsStrRes = R.strings.messenger.serviceChannelMessages.battleResults.quests.rankedBonusBattles()
            bonusBattlesString = backport.text(questsStrRes, bonusBattles=persistBattles)
        rankedBonusBattlesBlock = b''
        if bonusBattlesString:
            rankedBonusBattlesBlock = g_settings.htmlTemplates.format(b'battleResultRankedBonusBattles', {b'rankedBonusBattles': bonusBattlesString})
        return rankedBonusBattlesBlock

    def __makeBattlePassProgressionString(self, guiType, battleResults):
        battlePassString = b''
        value = sum(points for points in battleResults.get(b'battlePassPoints', {}).get(b'vehicles', {}).itervalues())
        value += battleResults.get(b'bpTopPoints', 0)
        if value > 0:
            if guiType == ARENA_GUI_TYPE.BATTLE_ROYALE:
                bonusType = battleResults.get(b'bonusType', 0)
                if self.__battleRoyaleController.isBattlePassAvailable(bonusType):
                    battlePassString = backport.text(R.strings.messenger.serviceChannelMessages.BRbattleResults.battlePass(), pointsDiff=text_styles.neutral(value))
            else:
                battlePassString = backport.text(R.strings.messenger.serviceChannelMessages.battleResults.battlePass(), pointsDiff=text_styles.neutral(value))
        if not battlePassString:
            return b''
        return g_settings.htmlTemplates.format(b'battlePass', ctx={b'battlePassProgression': battlePassString})

    def __makePiggyBankString(self, credits_):
        if not credits_:
            return b''
        return g_settings.htmlTemplates.format(b'piggyBank', ctx={b'credits': self.__makeCurrencyString(Currency.CREDITS, credits_)})

    def __makeGoldBankGainString(self, gold_):
        if not gold_:
            return b''
        return g_settings.htmlTemplates.format(b'goldBankGain', ctx={b'gold': self.__makeCurrencyString(Currency.GOLD, gold_)})

    def __makeBRCoinString(self, battleResults):
        value = battleResults.get(b'brcoin', 0) + self.__getBrCoinsQuestBonus(battleResults)
        if value:
            text = backport.text(R.strings.messenger.serviceChannelMessages.BRbattleResults.battleRoyaleBrCoin(), value=text_styles.neutral(value))
            return g_settings.htmlTemplates.format(b'battleResultBrcoin', ctx={b'brcoin': text})
        return b''

    @staticmethod
    def __isBRDisqualified(battleResults):
        fairplayViolations = battleResults.get(b'fairplayViolations', None)
        if fairplayViolations is None:
            return False
        else:
            violation = fairplayViolations[1]
            violationName = getFairPlayViolationName(violation)
            return violationName in _BR_VIOLATIONS

    def __getBrCoinsQuestBonus(self, battleResults):
        questBonus = 0
        allQuests = self.__eventsCache.getAllQuests()
        for qID in battleResults.get(b'completedQuestIDs', []):
            quest = allQuests.get(qID)
            if quest is None:
                continue
            for bonus in quest.getBonuses(b'currencies'):
                if bonus.getCode() == b'brcoin':
                    questBonus += bonus.getCount()

        return questBonus

    def __makeBRProgressionTokenString(self, battleResults):
        progressionTokenName = b''
        if self.__battleRoyaleProgressionCtrl.isEnabled:
            progressionTokenName = self.__battleRoyaleProgressionCtrl.progressionToken
        value = battleResults.get(b'brAwardTokens', {}).get(progressionTokenName, {}).get(b'count', 0) + self.__getBrProgressionTokenQuestBonus(battleResults.get(b'completedQuestIDs', []))
        if value:
            text = b'<br/>' + backport.text(R.strings.messenger.serviceChannelMessages.BRbattleResults.BRProgressionTitle(), value=text_styles.brProgressionToken(value))
            return text
        return b''

    def __getBrProgressionTokenQuestBonus(self, completedQuestIDs):
        if not self.__battleRoyaleProgressionCtrl.isEnabled:
            return 0
        else:
            progressionTokenName = self.__battleRoyaleProgressionCtrl.progressionToken
            questBonus = 0
            allQuests = self.__eventsCache.getAllQuests()
            for qID in completedQuestIDs:
                quest = allQuests.get(qID)
                if quest is None:
                    continue
                for tokenBonus in quest.getBonuses(b'tokens'):
                    questBonus += parseTokenBonusCount(tokenBonus, progressionTokenName)

            return questBonus


class AutoMaintenanceFormatter(WaitItemsSyncFormatter):
    itemsCache = dependency.descriptor(IItemsCache)
    __serviceChannelMessages = R.strings.messenger.serviceChannelMessages
    __messages = {AUTO_MAINTENANCE_RESULT.NOT_ENOUGH_ASSETS: {AUTO_MAINTENANCE_TYPE.REPAIR: R.strings.messenger.serviceChannelMessages.autoRepairError(), 
                                                   AUTO_MAINTENANCE_TYPE.LOAD_AMMO: R.strings.messenger.serviceChannelMessages.autoLoadError(), 
                                                   AUTO_MAINTENANCE_TYPE.EQUIP: R.strings.messenger.serviceChannelMessages.autoEquipError(), 
                                                   AUTO_MAINTENANCE_TYPE.EQUIP_BOOSTER: R.strings.messenger.serviceChannelMessages.autoEquipBoosterError(), 
                                                   AUTO_MAINTENANCE_TYPE.CUSTOMIZATION: R.strings.messenger.serviceChannelMessages.autoRentStyleError()}, 
       AUTO_MAINTENANCE_RESULT.OK: {AUTO_MAINTENANCE_TYPE.REPAIR: R.strings.messenger.serviceChannelMessages.autoRepairSuccess(), 
                                    AUTO_MAINTENANCE_TYPE.LOAD_AMMO: R.strings.messenger.serviceChannelMessages.autoLoadSuccess(), 
                                    AUTO_MAINTENANCE_TYPE.EQUIP: R.strings.messenger.serviceChannelMessages.autoEquipSuccess(), 
                                    AUTO_MAINTENANCE_TYPE.EQUIP_BOOSTER: R.strings.messenger.serviceChannelMessages.autoEquipBoosterSuccess(), 
                                    AUTO_MAINTENANCE_TYPE.CUSTOMIZATION: R.strings.messenger.serviceChannelMessages.autoRentStyleSuccess()}, 
       AUTO_MAINTENANCE_RESULT.NOT_PERFORMED: {AUTO_MAINTENANCE_TYPE.REPAIR: R.strings.messenger.serviceChannelMessages.autoRepairSkipped(), 
                                               AUTO_MAINTENANCE_TYPE.LOAD_AMMO: R.strings.messenger.serviceChannelMessages.autoLoadSkipped(), 
                                               AUTO_MAINTENANCE_TYPE.EQUIP: R.strings.messenger.serviceChannelMessages.autoEquipSkipped(), 
                                               AUTO_MAINTENANCE_TYPE.EQUIP_BOOSTER: R.strings.messenger.serviceChannelMessages.autoEquipBoosterSkipped(), 
                                               AUTO_MAINTENANCE_TYPE.CUSTOMIZATION: R.strings.messenger.serviceChannelMessages.autoRentStyleSkipped()}, 
       AUTO_MAINTENANCE_RESULT.DISABLED_OPTION: {AUTO_MAINTENANCE_TYPE.REPAIR: R.strings.messenger.serviceChannelMessages.autoRepairDisabledOption(), 
                                                 AUTO_MAINTENANCE_TYPE.LOAD_AMMO: R.strings.messenger.serviceChannelMessages.autoLoadDisabledOption(), 
                                                 AUTO_MAINTENANCE_TYPE.EQUIP: R.strings.messenger.serviceChannelMessages.autoEquipDisabledOption(), 
                                                 AUTO_MAINTENANCE_TYPE.EQUIP_BOOSTER: R.strings.messenger.serviceChannelMessages.autoEquipBoosterDisabledOption(), 
                                                 AUTO_MAINTENANCE_TYPE.CUSTOMIZATION: R.strings.messenger.serviceChannelMessages.autoRentStyleDisabledOption()}, 
       AUTO_MAINTENANCE_RESULT.NO_WALLET_SESSION: {AUTO_MAINTENANCE_TYPE.REPAIR: R.strings.messenger.serviceChannelMessages.autoRepairErrorNoWallet(), 
                                                   AUTO_MAINTENANCE_TYPE.LOAD_AMMO: R.strings.messenger.serviceChannelMessages.autoLoadErrorNoWallet(), 
                                                   AUTO_MAINTENANCE_TYPE.EQUIP: R.strings.messenger.serviceChannelMessages.autoEquipErrorNoWallet(), 
                                                   AUTO_MAINTENANCE_TYPE.EQUIP_BOOSTER: R.strings.messenger.serviceChannelMessages.autoBoosterErrorNoWallet(), 
                                                   AUTO_MAINTENANCE_TYPE.CUSTOMIZATION: R.strings.messenger.serviceChannelMessages.autoRentStyleErrorNoWallet()}, 
       AUTO_MAINTENANCE_RESULT.RENT_IS_OVER: {AUTO_MAINTENANCE_TYPE.CUSTOMIZATION: R.strings.messenger.serviceChannelMessages.autoRentStyleRentIsOver.text()}, 
       AUTO_MAINTENANCE_RESULT.RENT_IS_ALMOST_OVER: {AUTO_MAINTENANCE_TYPE.CUSTOMIZATION: R.strings.messenger.serviceChannelMessages.autoRentStyleRentIsAlmostOverAutoprolongationOFF.text()}}
    __currencyTemplates = {Currency.CREDITS: b'PurchaseForCreditsSysMessage', 
       Currency.GOLD: b'PurchaseForGoldSysMessage', 
       Currency.CRYSTAL: b'PurchaseForCrystalSysMessage', 
       Currency.EVENT_COIN: b'PurchaseForEventCoinSysMessage', 
       Currency.BPCOIN: b'PurchaseForBpcoinSysMessage'}

    def isNotify(self):
        return True

    @adisp_async
    @adisp_process
    def format(self, message, callback):
        isSynced = yield self._waitForSyncItems()
        if message.data and isSynced:
            vehicleCompDescr = message.data.get(b'vehTypeCD', None)
            styleId = message.data.get(b'styleID', None)
            result = message.data.get(b'result', None)
            typeID = message.data.get(b'typeID', None)
            cost = Money(*message.data.get(b'cost', ()))
            if vehicleCompDescr is not None and result is not None and typeID is not None:
                vehicle = self.itemsCache.items.getItemByCD(vehicleCompDescr)
                if typeID == AUTO_MAINTENANCE_TYPE.REPAIR:
                    formatMsgType = b'RepairSysMessage'
                else:
                    formatMsgType = self._getTemplateByCurrency(cost.getCurrency(byWeight=False))
                msgTmplKey = self.__messages[result].get(typeID, None)
                msgArgs = None
                data = None
                if result in (AUTO_MAINTENANCE_RESULT.RENT_IS_OVER, AUTO_MAINTENANCE_RESULT.RENT_IS_ALMOST_OVER):
                    cc = vehicles_core.g_cache.customization20()
                    style = cc.styles.get(styleId, None)
                    if style:
                        styleName = style.userString
                        vehName = vehicle.shortUserName
                        data = {b'savedData': {b'styleIntCD': style.compactDescr, 
                                          b'vehicleIntCD': vehicleCompDescr, 
                                          b'toStyle': True}}
                        if result == AUTO_MAINTENANCE_RESULT.RENT_IS_ALMOST_OVER and vehicle.isAutoRentStyle:
                            msgTmplKey = R.strings.messenger.serviceChannelMessages.autoRentStyleRentIsAlmostOverAutoprolongationON.text()
                            msgArgs = (
                             vehName, styleName, style.rentCount)
                        else:
                            msgArgs = (
                             styleName, vehName)
                else:
                    vehName = vehicle.userName
                    msgArgs = (vehName,)
                if msgArgs is not None:
                    msgTmpl = backport.text(msgTmplKey)
                    if not msgTmpl:
                        _logger.warning(b'Invalid typeID field in message: %s', message)
                        callback([MessageData(None, None)])
                    else:
                        msg = msgTmpl % msgArgs
                else:
                    msg = b''
                priorityLevel = NotificationPriorityLevel.MEDIUM
                if result == AUTO_MAINTENANCE_RESULT.OK:
                    priorityLevel = NotificationPriorityLevel.LOW
                    templateName = formatMsgType
                elif result == AUTO_MAINTENANCE_RESULT.NOT_ENOUGH_ASSETS:
                    templateName = b'ErrorSysMessage'
                elif result == AUTO_MAINTENANCE_RESULT.RENT_IS_OVER:
                    templateName = b'RentOfStyleIsExpiredSysMessage'
                elif result == AUTO_MAINTENANCE_RESULT.RENT_IS_ALMOST_OVER:
                    if vehicle.isAutoRentStyle:
                        templateName = b'RentOfStyleIsAlmostExpiredAutoprolongationONSysMessage'
                    else:
                        templateName = b'RentOfStyleIsAlmostExpiredAutoprolongationOFFSysMessage'
                elif result == AUTO_MAINTENANCE_RESULT.DISABLED_OPTION:
                    templateName = b'ErrorSysMessage'
                else:
                    templateName = b'WarningSysMessage'
                if result == AUTO_MAINTENANCE_RESULT.OK:
                    msg += shared_fmts.formatPrice(cost.toAbs(), ignoreZeros=True) + b'.'
                formatted = g_settings.msgTemplates.format(templateName, {b'text': msg}, data=data)
                settings = self._getGuiSettings(message, priorityLevel=priorityLevel, messageType=message.type, messageSubtype=result)
                callback([MessageData(formatted, settings)])
            else:
                callback([MessageData(None, None)])
        else:
            callback([MessageData(None, None)])
        return

    def _getTemplateByCurrency(self, currency):
        return self.__currencyTemplates.get(currency, b'PurchaseForCreditsSysMessage')


class AchievementFormatter(ServiceChannelFormatter):

    def isNotify(self):
        return True

    def isAsync(self):
        return True

    @adisp_async
    @adisp_process
    def format(self, message, callback):
        yield lambda callback: callback(True)
        achievesList, badgesList = [], []
        achieves = message.data.get(b'popUpRecords')
        if achieves is not None:
            for (block, name), value in achieves.iteritems():
                if block == BADGES_BLOCK:
                    badgesList.append(backport.text(R.strings.badge.dyn((b'badge_{}').format(name))()))
                else:
                    achieve = getAchievementFactory((block, name)).create(value)
                    if achieve is not None:
                        achievesList.append(achieve.getUserName())
                    else:
                        achievesList.append(backport.text(R.strings.achievements.dyn(name)()))

        rares = [ rareID for rareID in message.data.get(b'rareAchievements', []) if rareID > 0 ]
        raresList = _processRareAchievements(rares)
        achievesList.extend(raresList)
        if not achievesList:
            callback([MessageData(None, None)])
            return
        else:
            formatted = g_settings.msgTemplates.format(b'achievementReceived', {b'achieves': (b', ').join(achievesList)})
            if badgesList:
                badgesBlock = g_settings.htmlTemplates.format(b'badgeAchievement', {b'badges': (b', ').join(badgesList)})
                formatted = EOL.join([formatted, badgesBlock])
            callback([MessageData(formatted, self._getGuiSettings(message, b'achievementReceived'))])
            return


class CurrencyUpdateFormatter(ServiceChannelFormatter):
    WOTRP_EMITTER_ID = 1033
    _EMITTER_ID_TO_TITLE = {2525: R.strings.messenger.serviceChannelMessages.currencyUpdate.integratedAuction(), 
       2524: R.strings.messenger.serviceChannelMessages.currencyUpdate.battlepass()}
    _DEFAULT_TITLE = R.strings.messenger.serviceChannelMessages.currencyUpdate.financial_transaction()
    __FREE_XP_ICON = b'freeXPSmallIcon'
    __CURRENCY_ICONS = {CURRENCIES_CONSTANTS.FREE_XP: __FREE_XP_ICON}
    _CURRENCY_TO_STYLE = {CURRENCIES_CONSTANTS.FREE_XP: text_styles.expText}

    def format(self, message, *args):
        data = message.data
        currencyCode = data[b'currency_name']
        amountDelta = data[b'amount_delta']
        transactionTime = data[b'date']
        emitterID = data.get(b'emitterID')
        if currencyCode and amountDelta and transactionTime:
            formatter = self._getFormatter(emitterID)
            messages = formatter(message, currencyCode, amountDelta, transactionTime, emitterID)
            return messages
        else:
            return [
             MessageData(None, None)]

    def _getFormatter(self, emitterID):
        formatters = {self.WOTRP_EMITTER_ID: self._wotrpFormatter}
        return formatters.get(emitterID, self._defaultFormatter)

    def _defaultFormatter(self, message, currencyCode, amountDelta, transactionTime, emitterID):
        formatted = g_settings.msgTemplates.format(b'currencyUpdate', ctx={b'title': backport.text(self._EMITTER_ID_TO_TITLE.get(emitterID, self._DEFAULT_TITLE)), 
           b'date': TimeFormatter.getLongDatetimeFormat(transactionTime), 
           b'currency': self.__getCurrencyString(currencyCode, amountDelta), 
           b'amount': self.__getCurrencyStyle(currencyCode)(getBWFormatter(currencyCode)(abs(amountDelta)))}, data={b'icon': self.__CURRENCY_ICONS.get(currencyCode, currencyCode.title() + b'Icon')})
        return [
         MessageData(formatted, self._getGuiSettings(message, b'currencyUpdate'))]

    def _wotrpFormatter(self, message, currencyCode, amountDelta, transactionTime, emitterID):
        if currencyCode == Currency.GOLD:
            formatted = g_settings.msgTemplates.format(b'WOTRPCachbackInvoiceReceived', ctx={b'amount': amountDelta})
            return [
             MessageData(formatted, self._getGuiSettings(message, b'WOTRPCachbackInvoiceReceived'))]
        return self._defaultFormatter(message, currencyCode, amountDelta, transactionTime, emitterID)

    def __ifPlatformCurrency(self, currencyCode):
        return currencyCode not in Currency.ALL + (CURRENCIES_CONSTANTS.FREE_XP,)

    def __getCurrencyString(self, currencyCode, amountDelta):
        if self.__ifPlatformCurrency(currencyCode):
            return backport.text(R.strings.messenger.platformCurrencyMsg.dyn(b'debited' if amountDelta < 0 else b'received').dyn(currencyCode)())
        return backport.text(R.strings.messenger.serviceChannelMessages.currencyUpdate.dyn(b'debited' if amountDelta < 0 else b'received').dyn(currencyCode)())

    def __getCurrencyStyle(self, currencyCode):
        return self._CURRENCY_TO_STYLE.get(currencyCode, getStyle(currencyCode))


class WTEventTicketTokenWithdrawnFormatter(WaitItemsSyncFormatter):
    __gameEventCtrl = dependency.descriptor(IWhiteTigerController)

    @adisp_async
    @adisp_process
    def format(self, message, callback):
        data = message.data
        isSynced = yield self._waitForSyncItems()
        if isSynced and data:
            token = data[b'token']
            amountDelta = data[b'amount_delta']
            if amountDelta >= 0:
                raise SoftException(b'Unexpected ticket amount to withdraw')
            strRes = R.strings.event.notifications
            config = self.__gameEventCtrl.getConfig()
            if token == config.ticketToken:
                text = backport.text(strRes.ticketToken.withdrawn.body(), ticketsCount=str(self.__gameEventCtrl.getTicketCount()))
            elif token == config.quickBossTicketToken:
                text = backport.text(strRes.quickBossTicketToken.withdrawn.body())
            else:
                raise SoftException(b'Unexpected ticket token')
            xmlKey = b'WTEventTicketTokenWithdrawn'
            formatted = g_settings.msgTemplates.format(xmlKey, ctx={b'text': text})
            callback([MessageData(formatted, self._getGuiSettings(message, xmlKey))])
        else:
            callback([MessageData(None, None)])
        return


class GiftReceivedFormatter(ServiceChannelFormatter):
    __handlers = {b'money': (
                b'_GiftReceivedFormatter__formatMoneyGiftMsg',
                {1: b'creditsReceivedAsGift', 
                   2: b'goldReceivedAsGift', 
                   3: b'creditsAndGoldReceivedAsGift', 
                   8: b'eventCoinReceivedAsGift'}), 
       b'xp': ('_GiftReceivedFormatter__formatXPGiftMsg', 'xpReceivedAsGift'), 
       b'premium': ('_GiftReceivedFormatter__formatPremiumGiftMsg', 'premiumReceivedAsGift'), 
       b'premium_plus': ('_GiftReceivedFormatter__formatPremiumGiftMsg', 'tankPremiumReceivedAsGift'), 
       b'item': ('_GiftReceivedFormatter__formatItemGiftMsg', 'itemReceivedAsGift'), 
       b'vehicle': ('_GiftReceivedFormatter__formatVehicleGiftMsg', 'vehicleReceivedAsGift')}

    def format(self, message, *args):
        data = message.data
        giftType = data.get(b'type')
        if giftType is not None:
            handlerName, templateKey = self.__handlers.get(giftType, (None, None))
            if handlerName is not None:
                formatted, templateKey = getattr(self, handlerName)(templateKey, data)
                return [
                 MessageData(formatted, self._getGuiSettings(message, templateKey))]
        return [
         MessageData(None, None)]

    def __formatMoneyGiftMsg(self, keys, data):
        result = (None, '')
        ctx = {}
        idx = 0
        for i, currency in enumerate(Currency.ALL):
            value = data.get(currency, 0)
            if value > 0:
                formatter = getBWFormatter(currency)
                idx |= 1 << i
                ctx[currency] = formatter(value)

        if idx in keys:
            key = keys[idx]
            result = (
             g_settings.msgTemplates.format(keys[idx], ctx), key)
        return result

    def __formatXPGiftMsg(self, key, data):
        xp = data.get(b'amount', 0)
        result = None
        if xp > 0:
            result = g_settings.msgTemplates.format(key, ctx={b'freeXP': backport.getIntegralFormat(xp)})
        return (
         result, key)

    def __formatPremiumGiftMsg(self, key, data):
        days = data.get(b'amount', 0)
        result = None
        if days > 0:
            result = g_settings.msgTemplates.format(key, ctx={b'days': days})
        return (
         result, key)

    def __formatItemGiftMsg(self, key, data):
        amount = data.get(b'amount', 0)
        result = None
        itemTypeIdx = data.get(b'itemTypeIdx')
        itemCompactDesc = data.get(b'itemCD')
        if amount > 0 and itemTypeIdx is not None and itemCompactDesc is not None:
            result = g_settings.msgTemplates.format(key, ctx={b'typeName': getTypeInfoByIndex(itemTypeIdx)[b'userString'], 
               b'itemName': vehicles_core.getItemByCompactDescr(itemCompactDesc).i18n.userString, 
               b'amount': amount})
        return (
         result, key)

    def __formatVehicleGiftMsg(self, key, data):
        vCompDesc = data.get(b'typeCD', None)
        result = None
        if vCompDesc is not None:
            result = g_settings.msgTemplates.format(key, ctx={b'vehicleName': getUserName(vehicles_core.getVehicleType(vCompDesc))})
        return (
         result, key)


class InvoiceReceivedFormatter(WaitItemsSyncFormatter):
    __purchaseCache = dependency.descriptor(IPurchaseCache)
    __emitterAssetHandlers = {}
    __assetHandlers = {INVOICE_ASSET.GOLD: b'_formatAmount', 
       INVOICE_ASSET.CREDITS: b'_formatAmount', 
       INVOICE_ASSET.CRYSTAL: b'_formatAmount', 
       INVOICE_ASSET.EVENT_COIN: b'_formatAmount', 
       INVOICE_ASSET.BPCOIN: b'_formatAmount', 
       INVOICE_ASSET.PREMIUM: b'_formatAmount', 
       INVOICE_ASSET.FREE_XP: b'_formatAmount', 
       INVOICE_ASSET.DATA: b'_formatData', 
       INVOICE_ASSET.PURCHASE: b'_formatPurchase'}
    __currencyToInvoiceAsset = {Currency.GOLD: INVOICE_ASSET.GOLD, 
       Currency.CREDITS: INVOICE_ASSET.CREDITS, 
       Currency.CRYSTAL: INVOICE_ASSET.CRYSTAL, 
       Currency.EVENT_COIN: INVOICE_ASSET.EVENT_COIN, 
       Currency.BPCOIN: INVOICE_ASSET.BPCOIN, 
       Currency.EQUIP_COIN: INVOICE_ASSET.EQUIP_COIN}
    __operationTemplateKeys = {INVOICE_ASSET.GOLD: b'goldAccruedInvoiceReceived', 
       INVOICE_ASSET.CREDITS: b'creditsAccruedInvoiceReceived', 
       INVOICE_ASSET.CRYSTAL: b'crystalAccruedInvoiceReceived', 
       INVOICE_ASSET.EVENT_COIN: b'eventCoinAccruedInvoiceReceived', 
       INVOICE_ASSET.BPCOIN: b'bpcoinAccruedInvoiceReceived', 
       INVOICE_ASSET.PREMIUM: b'premiumAccruedInvoiceReceived', 
       INVOICE_ASSET.FREE_XP: b'freeXpAccruedInvoiceReceived', 
       INVOICE_ASSET.EQUIP_COIN: b'equipCoinAccruedInvoiceReceived', 
       INVOICE_ASSET.GOLD | 16: b'goldDebitedInvoiceReceived', 
       INVOICE_ASSET.CREDITS | 16: b'creditsDebitedInvoiceReceived', 
       INVOICE_ASSET.CRYSTAL | 16: b'crystalDebitedInvoiceReceived', 
       INVOICE_ASSET.EVENT_COIN | 16: b'eventCoinDebitedInvoiceReceived', 
       INVOICE_ASSET.BPCOIN | 16: b'bpcoinDebitedInvoiceReceived', 
       INVOICE_ASSET.PREMIUM | 16: b'premiumDebitedInvoiceReceived', 
       INVOICE_ASSET.FREE_XP | 16: b'freeXpDebitedInvoiceReceived', 
       INVOICE_ASSET.EQUIP_COIN | 16: b'equipCoinDebitedInvoiceReceived'}
    __blueprintsTemplateKeys = {BlueprintTypes.VEHICLE: ('vehicleBlueprintsAccruedInvoiceReceived', 'vehicleBlueprintsDebitedInvoiceReceived'), 
       BlueprintTypes.NATIONAL: ('nationalBlueprintsAccruedInvoiceReceived', 'nationalBlueprintsDebitedInvoiceReceived'), 
       BlueprintTypes.INTELLIGENCE_DATA: ('intelligenceBlueprintsAccruedInvoiceReceived', 'intelligenceBlueprintsDebitedInvoiceReceived')}
    __emitterMessageTemplateKeys = {}
    __messageTemplateKeys = {INVOICE_ASSET.GOLD: b'goldInvoiceReceived', 
       INVOICE_ASSET.CREDITS: b'creditsInvoiceReceived', 
       INVOICE_ASSET.CRYSTAL: b'crystalInvoiceReceived', 
       INVOICE_ASSET.EVENT_COIN: b'eventCoinInvoiceReceived', 
       INVOICE_ASSET.BPCOIN: b'bpcoinInvoiceReceived', 
       INVOICE_ASSET.PREMIUM: b'premiumInvoiceReceived', 
       INVOICE_ASSET.FREE_XP: b'freeXpInvoiceReceived', 
       INVOICE_ASSET.DATA: b'dataInvoiceReceived', 
       INVOICE_ASSET.PURCHASE: b'purchaseInvoiceReceived'}
    __INVALID_TYPE_ASSET = -1
    __auxMessagesHandlers = {INVOICE_ASSET.DATA: b'getInvoiceDataAuxMessages', 
       INVOICE_ASSET.PURCHASE: b'getPurchaseDataAuxMessages'}
    __DESTROY_PAIR_MODIFICATIONS_MSG_TEMPLATE = b'DestroyAllPairsModifications'
    __goodiesCache = dependency.descriptor(IGoodiesCache)
    __eventsCache = dependency.descriptor(IEventsCache)
    __gameEventCtrl = dependency.descriptor(IWhiteTigerController)

    @adisp_async
    @adisp_process
    def format(self, message, callback):
        isSynced = yield self._waitForSyncItems()
        formatted, settings = (None, None)
        mainMassage = MessageData(None, None)
        auxMassages = []
        if isSynced:
            data = message.data
            isDataSynced = yield self.__waitForSyncData(data)
            if isDataSynced:
                self.__prerocessRareAchievements(data)
                emitterID = data.get(b'emitterID')
                assetType = data.get(b'assetType', self.__INVALID_TYPE_ASSET)
                handler = self._getMessageHandler(emitterID, assetType)
                if handler is not None:
                    formatted = getattr(self, handler)(emitterID, assetType, data)
                if formatted is not None:
                    settings = self._getGuiSettings(message, self._getMessageTemplateKey(emitterID, assetType))
            else:
                assetType = self.__INVALID_TYPE_ASSET
                _logger.debug(b'Message will not be shown!')
            mainMassage = MessageData(formatted, settings)
            auxMessagesHandler = self.__auxMessagesHandlers.get(assetType, None)
            if auxMessagesHandler is not None:
                auxMassages = getattr(self, auxMessagesHandler)(data)
        result = [
         mainMassage]
        result.extend(auxMassages)
        callback(result)
        return

    def _getMessageHandler(self, emitterId, assetType):
        return self.__emitterAssetHandlers.get(emitterId, {}).get(assetType, None) or self.__assetHandlers.get(assetType)

    @classmethod
    def getBlueprintString(cls, blueprints):
        vehicleFragments, nationFragments, universalFragments = getUniqueBlueprints(blueprints)
        blueprintsString = []
        for fragmentCD, count in vehicleFragments.iteritems():
            ctx = cls.__getBlueprintContext(count)
            vehicleName = cls.__getVehicleName(fragmentCD)
            ctx[b'vehicleName'] = vehicleName
            blueprintsString.append(cls.__formatBlueprintsString(BlueprintTypes.VEHICLE, count, ctx))

        for nationID, count in nationFragments.iteritems():
            ctx = cls.__getBlueprintContext(count)
            localizedNationName = backport.text(R.strings.nations.dyn(NAMES[nationID]).genetiveCase())
            ctx[b'nationName'] = localizedNationName
            blueprintsString.append(cls.__formatBlueprintsString(BlueprintTypes.NATIONAL, count, ctx))

        if universalFragments:
            blueprintsString.append(cls.__formatBlueprintsString(BlueprintTypes.INTELLIGENCE_DATA, universalFragments, cls.__getBlueprintContext(universalFragments)))
        return (b'<br>').join(blueprintsString)

    @classmethod
    def getVehiclesString(cls, vehicles, htmlTplPostfix=b'InvoiceReceived'):
        addVehNames, removeVehNames, rentedVehNames = cls._getVehicleNames(vehicles)
        result = []
        if addVehNames:
            result.append(g_settings.htmlTemplates.format(b'vehiclesAccrued' + htmlTplPostfix, ctx={b'vehicles': (b', ').join(addVehNames)}))
        if removeVehNames:
            result.append(g_settings.htmlTemplates.format(b'vehiclesDebited' + htmlTplPostfix, ctx={b'vehicles': (b', ').join(removeVehNames)}))
        if rentedVehNames:
            result.append(g_settings.htmlTemplates.format(b'vehiclesRented' + htmlTplPostfix, ctx={b'vehicles': (b', ').join(rentedVehNames)}))
        return (b'<br/>').join(result)

    def canBeEmpty(self):
        return True

    @classmethod
    def _getCustomizationCompensationString(cls, compensationMoney, strItemType, strItemName, amount, htmlTplPostfix):
        htmlTemplates = g_settings.htmlTemplates
        values = []
        result = b''
        currencies = compensationMoney.getSetCurrencies(byWeight=True)
        for currency in currencies:
            key = (b'{}Compensation').format(currency)
            values.append(htmlTemplates.format(key + htmlTplPostfix, ctx={b'amount': applyAll(currency, compensationMoney.get(currency))}))

        if values:
            result = htmlTemplates.format(b'customizationCompensation' + htmlTplPostfix, ctx={b'type': strItemType, 
               b'name': strItemName, 
               b'amount': str(amount), 
               b'compensation': (b', ').join(values)})
        return result

    @classmethod
    def getVehiclesCompensationString(cls, vehicles, htmlTplPostfix=b'InvoiceReceived'):
        htmlTemplates = g_settings.htmlTemplates
        result = []
        for vehicleDict in vehicles:
            for vehCompDescr, vehData in vehicleDict.iteritems():
                vehicleName = cls.__getVehicleName(vehCompDescr)
                if vehicleName is None:
                    continue
                if b'rentCompensation' in vehData:
                    comp = Money.makeFromMoneyTuple(vehData[b'rentCompensation'])
                    currency = comp.getCurrency(byWeight=True)
                    formatter = getBWFormatter(currency)
                    key = (b'{}RentCompensationReceived').format(currency)
                    ctx = {currency: formatter(comp.get(currency)), b'vehicleName': vehicleName}
                    result.append(htmlTemplates.format(key, ctx=ctx))
                if b'customCompensation' in vehData:
                    itemNames = (
                     vehicleName,)
                    comp = Money.makeFromMoneyTuple(vehData[b'customCompensation'])
                    result.append(cls._getCompensationString(comp, itemNames, htmlTplPostfix))

        if any(result):
            return (b'<br/>').join(result)
        else:
            return b''

    @classmethod
    def getCustomizationCompensationString(cls, customizationItem, htmlTplPostfix=b'InvoiceReceived'):
        result = b''
        if b'customCompensation' not in customizationItem:
            return result
        customItemData = getCustomizationItemData(customizationItem[b'id'], customizationItem[b'custType'])
        strItemType = backport.text(R.strings.messenger.serviceChannelMessages.invoiceReceived.compensation.dyn(customItemData.guiItemType)())
        comp = Money.makeFromMoneyTuple(customizationItem[b'customCompensation'])
        result = cls._getCustomizationCompensationString(comp, strItemType, customItemData.userName, customizationItem[b'compensatedNumber'], htmlTplPostfix)
        return result

    @classmethod
    def getTankmenString(cls, tmen, dismiss=False):
        tmanUserStrings = []
        for tmanData in tmen:
            try:
                if isinstance(tmanData, dict):
                    tankman = Tankman(tmanData[b'tmanCompDescr'])
                elif isinstance(tmanData, Tankman):
                    tankman = tmanData
                else:
                    tankman = Tankman(tmanData)
                tmanUserStrings.append((b'{0:s} {1:s} ({2:s}, {3:s}, {4:d}%)').format(tankman.rankUserName, tankman.lastUserName, tankman.roleUserName, getUserName(tankman.vehicleNativeDescr.type), tankman.roleLevel))
            except Exception:
                _logger.error(b'Wrong tankman data: %s', tmanData)
                _logger.exception(b'getTankmenString catch exception')

        result = b''
        if dismiss:
            invoiceStr = b'tankmenInvoiceDismiss'
            tankmanStr = b'tankmenToRemove'
        else:
            invoiceStr = b'tankmenInvoiceReceived'
            tankmanStr = b'tankman'
        if tmanUserStrings:
            result = g_settings.htmlTemplates.format(invoiceStr, ctx={tankmanStr: (b', ').join(tmanUserStrings)})
        return result

    @classmethod
    def getGoodiesString(cls, goodies, exclude=None):
        result = []
        boostersStrings = []
        discountsStrings = []
        equipStrings = []
        for goodieID, ginfo in goodies.iteritems():
            if exclude is not None and goodieID in exclude:
                continue
            if goodieID in cls._itemsCache.items.shop.boosters:
                booster = cls.__goodiesCache.getBooster(goodieID)
                if booster is not None and booster.enabled:
                    if ginfo.get(b'count'):
                        boostersStrings.append(backport.text(R.strings.system_messages.bonuses.booster.value(), name=booster.userName, count=ginfo.get(b'count')))
                    else:
                        boostersStrings.append(booster.userName)
            elif goodieID in cls._itemsCache.items.shop.discounts:
                discount = cls.__goodiesCache.getDiscount(goodieID)
                if discount is not None and discount.enabled:
                    discountsStrings.append(discount.description)
            elif goodieID in cls._itemsCache.items.shop.demountKits:
                dk = cls.__goodiesCache.getDemountKit(goodieID)
                if dk and dk.enabled:
                    if ginfo.get(b'count'):
                        equipStrings.append(backport.text(R.strings.system_messages.bonuses.booster.value(), name=dk.userName, count=ginfo.get(b'count')))
                    else:
                        equipStrings.append(dk.userName)
            elif goodieID in cls._itemsCache.items.shop.recertificationForms:
                rf = cls.__goodiesCache.getRecertificationForm(goodieID)
                if rf and rf.enabled:
                    if ginfo.get(b'count'):
                        equipStrings.append(backport.text(R.strings.system_messages.bonuses.booster.value(), name=rf.userName, count=ginfo.get(b'count')))
                    else:
                        equipStrings.append(rf.userName)

        if boostersStrings:
            result.append(g_settings.htmlTemplates.format(b'boostersInvoiceReceived', ctx={b'boosters': (b', ').join(boostersStrings)}))
        if discountsStrings:
            result.append(g_settings.htmlTemplates.format(b'discountsInvoiceReceived', ctx={b'discounts': (b', ').join(discountsStrings)}))
        if equipStrings:
            result.append(g_settings.htmlTemplates.format(b'equipmentInvoiceReceived', ctx={b'equipment': (b', ').join(equipStrings)}))
        return (b'; ').join(result)

    @classmethod
    def getEnhancementsString(cls, enhancements):
        added = 0
        removed = 0
        result = []
        for extra in enhancements.itervalues():
            count = extra.get(b'count', 0)
            if count > 0:
                added += count
            else:
                removed += -count

        if added:
            result.append(g_settings.htmlTemplates.format(b'enhancementsAccruedInvoiceReceived', ctx={b'count': added}))
        if removed:
            result.append(g_settings.htmlTemplates.format(b'enhancementsDebitedInvoiceReceived', ctx={b'count': removed}))
        if not result:
            return None
        else:
            return (b'; ').join(result)

    @staticmethod
    def getEntitlementsString(entitlements):
        result = [ EntitlementBonus.getUserNameWithCount(entitlementID, count) for entitlementID, count in entitlements ]
        return (b', ').join(filter(None, result))

    @staticmethod
    def getRankedBonusBattlesString(persistentBattles, _):
        result = []
        if persistentBattles > 0:
            count = text_styles.neutral(backport.getIntegralFormat(persistentBattles))
            result.append(backport.text(R.strings.messenger.serviceChannelMessages.battleResults.quests.rankedBonusBattles(), bonusBattles=count))
        return (b', ').join(result)

    def getInvoiceDataAuxMessages(self, data):
        result = []
        result.extend(self.__getDiscardPairModificationsMsg(data))
        return result

    def getPurchaseDataAuxMessages(self, data):
        result = []
        result.extend(self.__getReferralProgramMsg(data))
        return result

    def _composeOperations(self, data):
        dataEx = data.get(b'data', {})
        if not dataEx:
            return
        else:
            operations = []
            self._processCompensations(dataEx)
            for currency, invAsset in self.__currencyToInvoiceAsset.iteritems():
                if currency in dataEx:
                    operations.append(self.__getFinOperationString(invAsset, dataEx[currency], formatter=getBWFormatter(currency)))

            freeXp = dataEx.get(b'freeXP')
            if freeXp is not None:
                operations.append(self.__getFinOperationString(INVOICE_ASSET.FREE_XP, freeXp))
            premium = dataEx.get(PREMIUM_ENTITLEMENTS.BASIC)
            if premium is not None:
                operations.append(self.__getFinOperationString(INVOICE_ASSET.PREMIUM, premium))
            tankPremium = dataEx.get(PREMIUM_ENTITLEMENTS.PLUS)
            if tankPremium is not None:
                operations.append(self.__getTankPremiumString(tankPremium))
            items = dataEx.get(b'items', {})
            items = self.__composeItems(items)
            if items:
                operations.append(self.__getItemsString(items))
            tmen = dataEx.get(b'tankmen', [])
            tmenToRemove = dataEx.get(b'tmenToRemove', [])
            vehicles = dataEx.get(b'vehicles', {})
            vehicleItems = {}
            if vehicles:
                if isinstance(vehicles, dict):
                    vehicles = [
                     vehicles]
                result = self.getVehiclesString(vehicles)
                if result:
                    operations.append(result)
                comptnStr = self.getVehiclesCompensationString(vehicles)
                if comptnStr:
                    operations.append(comptnStr)
                for vehicleDict in vehicles:
                    for v in vehicleDict.itervalues():
                        tmen.extend(v.get(b'tankmen', []))
                        items = v.get(b'items', {})
                        for intCD, count in items.iteritems():
                            if intCD in vehicleItems:
                                vehicleItems[intCD] += count
                            else:
                                vehicleItems[intCD] = count

            if vehicleItems:
                operations.append(self.__getItemsString(vehicleItems, installed=True))
            if tmen:
                operations.append(self.getTankmenString(tmen))
            if tmenToRemove:
                tankmanCache = self._itemsCache.items.getTankmen()
                tmen = [ tankmanCache[tankman] for tankman in tmenToRemove.get(b'ids', []) ]
                operations.append(self.getTankmenString(tmen, True))
            blueprints = dataEx.get(b'blueprints')
            if blueprints:
                operations.append(self.getBlueprintString(blueprints))
            slots = dataEx.get(b'slots')
            if slots:
                operations.append(self.__getSlotsString(slots))
            berths = dataEx.get(b'berths')
            if berths:
                operations.append(self.__getBerthsString(berths))
            goodies = dataEx.get(b'goodies', {})
            if goodies:
                strGoodies = self.getGoodiesString(goodies)
                if strGoodies:
                    operations.append(strGoodies)
            enhancements = dataEx.get(b'enhancements', {})
            if enhancements:
                operations.append(self.getEnhancementsString(enhancements))
            dossier = dataEx.get(b'dossier', {})
            if dossier:
                operations.append(self.__getDossierString())
            _extendCustomizationData(dataEx, operations, htmlTplPostfix=b'InvoiceReceived')
            _extendCrewSkinsData(dataEx, operations)
            tankmenFreeXP = dataEx.get(b'tankmenFreeXP', {})
            if tankmenFreeXP:
                operations.append(self.__getTankmenFreeXPString(tankmenFreeXP))
            tokensStr = self.__getTokensString(dataEx.get(b'tokens', {}))
            if tokensStr:
                operations.extend(tokensStr)
            entitlementsStr = self.__getEntitlementsString(dataEx.get(b'entitlements', {}))
            if entitlementsStr:
                operations.append(entitlementsStr)
            lootBoxStr = self.__getLootBoxString(dataEx.get(b'tokens', {}), data.get(b'assetType', self.__INVALID_TYPE_ASSET))
            if lootBoxStr:
                operations.append(lootBoxStr)
            rankedDailyBattles = dataEx.get(b'rankedDailyBattles', 0)
            rankedPersistentBattles = dataEx.get(b'rankedBonusBattles', 0)
            rankedBonusBattlesStr = self.__getRankedBonusBattlesString(rankedPersistentBattles, rankedDailyBattles)
            if rankedBonusBattlesStr:
                operations.append(rankedBonusBattlesStr)
            platformCurrenciesStr = self.__getPlatformCurrenciesString(dataEx.get(b'currencies', {}))
            if platformCurrenciesStr:
                operations.append(platformCurrenciesStr)
            return operations

    def _formatData(self, emitterID, assetType, data):
        operations = self._composeOperations(data)
        icon = b'InformationIcon'
        if not operations:
            return None
        else:
            return g_settings.msgTemplates.format(self._getMessageTemplateKey(emitterID, assetType), ctx={b'at': self._getOperationTimeString(data), 
               b'desc': self.__getL10nDescription(data), 
               b'op': (b'<br/>').join(operations)}, data={b'icon': icon})

    def _formatAmount(self, emitterID, assetType, data):
        amount = data.get(b'amount', None)
        if amount is None:
            return
        else:
            return g_settings.msgTemplates.format(self._getMessageTemplateKey(emitterID, assetType), ctx={b'at': self._getOperationTimeString(data), 
               b'desc': self.__getL10nDescription(data), 
               b'op': self.__getFinOperationString(assetType, amount)})

    def _formatPurchase(self, emitterID, assetType, data):
        if b'customFormatting' in data.get(b'tags', ()):
            return None
        else:
            operations = self._composeOperations(data)
            if not operations:
                return None
            ctx = {b'at': self._getOperationTimeString(data), 
               b'desc': self.__getL10nDescription(data), 
               b'op': (b'<br/>').join(operations)}
            templateData = {}
            metadata = data.get(b'meta')
            title = backport.text(R.strings.messenger.serviceChannelMessages.invoiceReceived.invoice())
            subtitle = b''
            if metadata:
                purchase = self.__purchaseCache.getCachedPurchase(self.__purchaseCache.getProductCode(metadata))
                titleID = purchase.getTitleID()
                if titleID:
                    title = backport.text(R.strings.messenger.serviceChannelMessages.invoiceReceived.purchase.title.dyn(titleID)())
                else:
                    _logger.info(b'Could not find title in the purchase descriptor!')
                purchaseName = purchase.getProductName()
                if purchaseName:
                    subtitle = g_settings.htmlTemplates.format(b'purchaseSubtitle', {b'text': purchaseName})
                else:
                    _logger.info(b'Could not find name in the purchase descriptor!')
                iconID = purchase.getIconID()
                if iconID:
                    templateData[b'icon'] = iconID
                else:
                    _logger.info(b'Could not find icon in the purchase descriptor!')
            ctx[b'title'] = title
            ctx[b'subtitle'] = subtitle
            return g_settings.msgTemplates.format(self._getMessageTemplateKey(emitterID, assetType), ctx=ctx, data=templateData)

    def _getMessageTemplateKey(self, emitterID, assetType):
        return self.__emitterMessageTemplateKeys.get(emitterID, {}).get(assetType) or self.__messageTemplateKeys[assetType]

    @classmethod
    def _getOperationTimeString(cls, data):
        operationTime = data.get(b'at', None)
        if operationTime:
            fDatetime = TimeFormatter.getLongDatetimeFormat(time_utils.makeLocalServerTime(operationTime))
        else:
            fDatetime = b'N/A'
        return fDatetime

    @classmethod
    def _getVehicleNames(cls, vehicles):
        addVehNames = []
        removeVehNames = []
        rentedVehNames = []
        for vehicleDict in vehicles:
            for vehCompDescr, vehData in vehicleDict.iteritems():
                if b'customCompensation' in vehData:
                    continue
                isNegative = False
                if isinstance(vehCompDescr, types.IntType):
                    isNegative = vehCompDescr < 0
                isRented = b'rent' in vehData
                vehicleName = cls.__getVehicleName(vehCompDescr)
                if vehicleName is None:
                    continue
                vehicleInfo = cls.__getVehicleInfo(vehData, isNegative)
                vehicleInfoString = (b' ({0:s})').format(vehicleInfo) if vehicleInfo else b''
                vehUserString = (b'{0:s}{1:s}').format(vehicleName, vehicleInfoString)
                if isNegative:
                    removeVehNames.append(vehUserString)
                elif isRented:
                    rentedVehNames.append(vehUserString)
                else:
                    addVehNames.append(vehUserString)

        return (
         addVehNames, removeVehNames, rentedVehNames)

    @classmethod
    def _getCompensationString(cls, compensationMoney, strItemNames, htmlTplPostfix):
        htmlTemplates = g_settings.htmlTemplates
        values = []
        result = b''
        currencies = compensationMoney.getSetCurrencies(byWeight=True)
        for currency in currencies:
            key = (b'{}Compensation').format(currency)
            values.append(htmlTemplates.format(key + htmlTplPostfix, ctx={b'amount': applyAll(currency, compensationMoney.get(currency))}))

        if values:
            result = htmlTemplates.format(b'compensationFor' + htmlTplPostfix, ctx={b'items': (b', ').join(strItemNames), 
               b'compensation': (b', ').join(values)})
        return result

    @classmethod
    def _processCompensations(cls, data):

        def __compensationCalc(calc, vehicleDictionary):
            for value in vehicleDictionary.itervalues():
                if b'rentCompensation' in value:
                    calc += Money.makeFromMoneyTuple(value[b'rentCompensation'])
                if b'customCompensation' in value:
                    calc += Money.makeFromMoneyTuple(value[b'customCompensation'])

        vehicles = data.get(b'vehicles')
        comp = MONEY_UNDEFINED
        if vehicles is not None:
            if isinstance(vehicles, dict):
                __compensationCalc(comp, vehicles)
            else:
                for vehicle in vehicles:
                    __compensationCalc(comp, vehicle)

        for currency in cls.__currencyToInvoiceAsset:
            if currency in data and comp.isSet(currency):
                data[currency] -= comp.get(currency)
                if data[currency] == 0:
                    del data[currency]

        return

    @classmethod
    def __getBlueprintContext(cls, count):
        return {b'amount': backport.getIntegralFormat(abs(count))}

    @classmethod
    def __formatBlueprintsString(cls, fragmentType, count, ctx):
        if count > 0:
            template = cls.__blueprintsTemplateKeys[fragmentType][0]
        else:
            template = cls.__blueprintsTemplateKeys[fragmentType][1]
        return g_settings.htmlTemplates.format(template, ctx)

    def __prerocessRareAchievements(self, data):
        dossiers = data.get(b'data', {}).get(b'dossier', {})
        if dossiers:
            self.__dossierResult = []
            rares = _getRareAchievements(dossiers)
            uniqueAchieves = _composeAchievements(dossiers)
            addDossierStrings, delDossierStrings, addBadgesStrings, removedBadgesStrings = ([], [], [], [])
            for rec in uniqueAchieves.itervalues():
                for (block, name), recData in rec:
                    if name != b'':
                        isRemoving = recData[b'value'] < 0
                        if block == BADGES_BLOCK:
                            if isRemoving:
                                removedBadgesStrings.append(backport.text(R.strings.badge.dyn((b'badge_{}').format(name))()))
                            else:
                                addBadgesStrings.append(backport.text(R.strings.badge.dyn((b'badge_{}').format(name))()))
                        elif block != ACHIEVEMENT_BLOCK.RARE:
                            achieveStr = _getFormatAchieveString(name, block, recData)
                            if isRemoving:
                                delDossierStrings.append(achieveStr)
                            else:
                                addDossierStrings.append(achieveStr)

            addDossiers = [ rare for rare in rares if rare > 0 ]
            if addDossiers:
                addDossierStrings += _processRareAchievements(addDossiers)
            if addDossierStrings:
                self.__dossierResult.append(g_settings.htmlTemplates.format(b'dossiersAccruedInvoiceReceived', ctx={b'dossiers': (b', ').join(addDossierStrings)}))
            delDossiers = [ abs(rare) for rare in rares if rare < 0 ]
            if delDossiers:
                delDossierStrings += _processRareAchievements(delDossiers)
            if delDossierStrings:
                self.__dossierResult.append(g_settings.htmlTemplates.format(b'dossiersDebitedInvoiceReceived', ctx={b'dossiers': (b', ').join(delDossierStrings)}))
            if addBadgesStrings:
                self.__dossierResult.append(g_settings.htmlTemplates.format(b'badgeAchievement', ctx={b'badges': (b', ').join(addBadgesStrings)}))
            if removedBadgesStrings:
                self.__dossierResult.append(g_settings.htmlTemplates.format(b'removedBadgeAchievement', ctx={b'badges': (b', ').join(removedBadgesStrings)}))

    def __getDossierString(self):
        return (b'<br/>').join(self.__dossierResult)

    def __getFinOperationString(self, assetType, amount, formatter=None):
        templateKey = 0 if amount > 0 else 16
        templateKey |= assetType
        ctx = {}
        if formatter is not None:
            ctx[b'amount'] = formatter(abs(amount))
        else:
            ctx[b'amount'] = backport.getIntegralFormat(abs(amount))
        return g_settings.htmlTemplates.format(self.__operationTemplateKeys[templateKey], ctx=ctx)

    def __composeItems(self, items):

        def validateItem(item):
            itemCompactDescr, _ = item
            itemTypeID, _, _ = vehicles_core.parseIntCompactDescr(itemCompactDescr)
            if itemTypeID == I_T.crewBook:
                lobbyContext = dependency.instance(ILobbyContext)
                if not lobbyContext.getServerSettings().isCrewBooksEnabled():
                    return False
            return True

        return dict(filter(validateItem, items.iteritems()))

    def __getItemsString(self, items, installed=False):
        accrued = []
        debited = []
        for itemCompactDescr, count in items.iteritems():
            if count:
                try:
                    itemTypeID, _, _ = vehicles_core.parseIntCompactDescr(itemCompactDescr)
                    if itemTypeID == I_T.crewBook:
                        item = tankmen.getItemByCompactDescr(itemCompactDescr)
                        userString = _getCrewBookUserString(item)
                    else:
                        item = vehicles_core.getItemByCompactDescr(itemCompactDescr)
                        userString = item.i18n.userString
                    itemString = (b'{0:s} "{1:s}" - {2:d} {3:s}').format(getTypeInfoByName(item.itemTypeName)[b'userString'], userString, abs(count), backport.text(R.strings.messenger.serviceChannelMessages.invoiceReceived.pieces()))
                    if count > 0:
                        accrued.append(itemString)
                    else:
                        debited.append(itemString)
                except Exception:
                    _logger.error(b'itemCompactDescr can not parse: %s ', itemCompactDescr)
                    _logger.exception(b'getItemsString catch exception')

        result = b''
        if accrued:
            if installed:
                templateId = b'itemsInstalledInvoiceReceived'
            else:
                templateId = b'itemsAccruedInvoiceReceived'
            result = g_settings.htmlTemplates.format(templateId, ctx={b'items': (b', ').join(accrued)})
        if debited:
            if result:
                result += b'<br/>'
            result += g_settings.htmlTemplates.format(b'itemsDebitedInvoiceReceived', ctx={b'items': (b', ').join(debited)})
        return result

    @classmethod
    def __getSlotsString(cls, slots):
        if slots > 0:
            template = b'slotsAccruedInvoiceReceived'
        else:
            template = b'slotsDebitedInvoiceReceived'
        return g_settings.htmlTemplates.format(template, {b'amount': backport.getIntegralFormat(abs(slots))})

    @classmethod
    def __getTankPremiumString(cls, expireTime):
        if expireTime > 0:
            template = b'tankPremiumAccruedInvoiceReceived'
        else:
            template = b'tankPremiumDebitedInvoiceReceived'
        return g_settings.htmlTemplates.format(template, {b'amount': backport.getIntegralFormat(abs(expireTime))})

    @classmethod
    def __getBerthsString(cls, berths):
        if berths > 0:
            template = b'berthsAccruedInvoiceReceived'
        else:
            template = b'berthsDebitedInvoiceReceived'
        return g_settings.htmlTemplates.format(template, {b'amount': backport.getIntegralFormat(abs(berths))})

    @classmethod
    def __getTankmenFreeXPString(cls, data):
        freeXP = set()
        spec = []
        for tankmenDescr, xp in data.iteritems():
            freeXP.add(xp)
            tankman = Tankman(tankmenDescr)
            spec.append((b'{} {} {}').format(tankman.fullUserName, tankman.roleUserName, getShortUserName(tankman.vehicleNativeDescr.type)))

        specStr = (b' ({})').format((b', ').join(spec)) if spec else b''
        freeXP = freeXP.pop()
        if freeXP > 0:
            template = b'tankmenFreeXpAccruedInvoiceReceived'
        else:
            template = b'tankmenFreeXpDebitedInvoiceReceived'
        return g_settings.htmlTemplates.format(template, {b'tankmenFreeXp': backport.getIntegralFormat(abs(freeXP)), 
           b'spec': specStr})

    @classmethod
    def __getL10nDescription(cls, data):
        descr = b''
        lData = getLocalizedData(data.get(b'data', {}), b'localized_description', defVal=None)
        if lData:
            descr = html.escape(lData.get(b'description', b''))
            if descr:
                descr = b'<br/>' + descr
        return descr

    @classmethod
    def __getVehicleInfo(cls, vehData, isWithdrawn):
        vInfo = []
        if isWithdrawn:
            toBarracks = not vehData.get(b'dismissCrew', False)
            action = backport.text(R.strings.messenger.serviceChannelMessages.invoiceReceived.crewWithdrawn())
            if toBarracks:
                action = backport.text(R.strings.messenger.serviceChannelMessages.invoiceReceived.crewDroppedToBarracks())
            vInfo.append(i18n.makeString(action))
        else:
            if b'rent' in vehData:
                rentTypeName, rentLeftCount = cls.__processRentVehicleData(vehData[b'rent'])
                if rentTypeName is not None and rentLeftCount > 0:
                    rentLeftStr = backport.text(R.strings.tooltips.quests.awards.vehicleRent.rentLeft.dyn(rentTypeName)(), count=rentLeftCount)
                    vInfo.append(rentLeftStr)
            crewLevel = VehiclesBonus.getTmanRoleLevel(vehData)
            if crewLevel is not None and crewLevel > DEFAULT_CREW_LVL:
                if b'crewInBarracks' in vehData and vehData[b'crewInBarracks']:
                    crewWithLevelString = backport.text(R.strings.messenger.serviceChannelMessages.invoiceReceived.crewWithLvlDroppedToBarracks(), crewLevel)
                else:
                    crewWithLevelString = backport.text(R.strings.messenger.serviceChannelMessages.invoiceReceived.crewOnVehicle(), crewLevel)
                vInfo.append(crewWithLevelString)
            if b'unlockModules' in vehData:
                vInfo.append(backport.text(R.strings.messenger.serviceChannelMessages.invoiceReceived.unlockedModules()))
        return (b'; ').join(vInfo)

    @staticmethod
    def __processRentVehicleData(rentData):
        timeLeft = rentData.get(RentDurationKeys.TIME, 0)
        if timeLeft:
            rentInfo = RentalInfoProvider(time=timeLeft)
            timeKey, rentLeftCount = getTimeLeftInfo(rentInfo.getTimeLeft())
            return (
             _RENT_TYPE_NAMES.get(timeKey, None), rentLeftCount)
        else:
            for rentType in [RentDurationKeys.WINS, RentDurationKeys.BATTLES, RentDurationKeys.DAYS]:
                rentTypeValue = rentData.get(rentType, 0)
                if rentTypeValue > 0 and rentType != float(b'inf'):
                    return (_RENT_TYPE_NAMES.get(rentType, None), int(rentTypeValue))

            return (None, 0)

    @classmethod
    def __getVehicleName(cls, vehCompDescr):
        vehicleName = None
        try:
            if vehCompDescr < 0:
                vehCompDescr = abs(vehCompDescr)
            vehicleName = getUserName(vehicles_core.getVehicleType(vehCompDescr))
        except Exception:
            _logger.error(b'Wrong vehicle compact descriptor: %s', vehCompDescr)
            _logger.exception(b'getVehicleName catch exception')

        return vehicleName

    def __getTokensString(self, data):
        awardListcount = 0
        tokenStrings = []
        for tokenName, tokenData in data.iteritems():
            count = tokenData.get(b'count', 0)
            tankmanTokenResult = _processTankmanToken(tokenName)
            if tankmanTokenResult:
                tokenStrings.append(tankmanTokenResult)
            else:
                offerTokenResult = _processOfferToken(tokenName, count)
                if offerTokenResult:
                    tokenStrings.append(offerTokenResult)
                lbTokenResult = _processLootBoxKeyToken(tokenName, count)
                if lbTokenResult:
                    tokenStrings.append(lbTokenResult)
                if tokenName == constants.PERSONAL_MISSION_FREE_TOKEN_NAME:
                    awardListcount += count
                else:
                    quests = self.__eventsCache.getQuestsByTokenRequirement(tokenName)
                    for quest in quests:
                        text = quest.getNotificationText().format(count=count)
                        if text:
                            tokenStrings.append(g_settings.htmlTemplates.format(b'questTokenInvoiceReceived', {b'text': text}))

            if tokenName.startswith(LOOTBOX_TOKEN_PREFIX):
                lootBox = self._itemsCache.items.tokens.getLootBoxByTokenID(tokenName)
                if lootBox is not None and lootBox.getType() in EventLootBoxes.ALL() and tokenData.get(b'count', 0) > 0:
                    tokenStrings.append(g_settings.htmlTemplates.format(b'lootboxesReceived', {b'amount': tokenData[b'count']}))
            if tokenName == self.__gameEventCtrl.getConfig().ticketToken:
                tokenStrings.append(g_settings.htmlTemplates.format(b'ticketsReceived', {b'amount': tokenData[b'count']}))

        if awardListcount != 0:
            template = b'awardListAccruedInvoiceReceived' if awardListcount > 0 else b'awardListDebitedInvoiceReceived'
            tokenStrings.append(g_settings.htmlTemplates.format(template, {b'count': awardListcount}))
        return tokenStrings

    def __getLootBoxString(self, data, assetType):
        boxesList = []
        for tokenName, tokenData in data.iteritems():
            if constants.LOOTBOX_TOKEN_PREFIX in tokenName:
                lootBox = self._itemsCache.items.tokens.getLootBoxByTokenID(tokenName)
                if lootBox is not None and (lootBox.getCategory() not in (REFERRAL_PROGRAM_CATEGORY,) or assetType != INVOICE_ASSET.PURCHASE):
                    boxesList.append(backport.text(R.strings.lootboxes.notification.lootBoxesAutoOpen.counter(), boxName=lootBox.getUserName(), count=tokenData.get(b'count', 0)))

        if boxesList:
            return g_settings.htmlTemplates.format(b'eventLootBoxesInvoiceReceived', {b'boxes': (b', ').join(boxesList)})
        else:
            return b''

    def __getEntitlementsString(self, data):
        accrued = []
        debited = []
        for entitlementID, entitlementData in data.iteritems():
            count = entitlementData.get(b'count', 0)
            accrued.append((entitlementID, max(count, 0)))
            debited.append((entitlementID, max(-count, 0)))

        result = b''
        accruedStr = self.getEntitlementsString(accrued)
        debitedStr = self.getEntitlementsString(debited)
        if accruedStr:
            templateId = b'entitlementsAccruedInvoiceReceived'
            result = g_settings.htmlTemplates.format(templateId, ctx={b'entitlements': accruedStr})
        if debitedStr:
            templateId = b'entitlementsDebitedInvoiceReceived'
            debitedFormatted = g_settings.htmlTemplates.format(templateId, ctx={b'entitlements': debitedStr})
            result = text_styles.concatStylesToMultiLine(result, debitedFormatted) if result else debitedFormatted
        return result

    def __getRankedBonusBattlesString(self, persistentBattles, dailyBattles):
        result = b''
        accruedStr = self.getRankedBonusBattlesString(max(persistentBattles, 0), max(dailyBattles, 0))
        debitedStr = self.getRankedBonusBattlesString(max(-persistentBattles, 0), max(-dailyBattles, 0))
        if accruedStr:
            templateId = b'rankedBonusBattlesAccruedInvoiceReceived'
            result = g_settings.htmlTemplates.format(templateId, ctx={b'bonusBattles': accruedStr})
        if debitedStr:
            templateId = b'rankedBonusBattlesDebitedInvoiceReceived'
            debitedFormatted = g_settings.htmlTemplates.format(templateId, ctx={b'bonusBattles': debitedStr})
            result = text_styles.concatStylesToMultiLine(result, debitedFormatted) if result else debitedFormatted
        return result

    def __getPlatformCurrenciesString(self, data):
        msgs = []
        for currencyName, countData in data.iteritems():
            count = countData.get(b'count', 0)
            if count == 0:
                continue
            elif count > 0:
                op = b'received'
            else:
                op = b'debited'
            msg = backport.text(R.strings.messenger.platformCurrencyMsg.dyn(op).dyn(currencyName)())
            msgs.append(g_settings.htmlTemplates.format(b'platformCurrency', {b'msg': msg, 
               b'count': backport.getIntegralFormat(abs(count))}))

        return (b'<br/>').join(msgs)

    def __getDiscardPairModificationsMsg(self, data):
        dataEx = data.get(b'data', {})
        result = []
        if not dataEx:
            return result
        else:
            vehicles = dataEx.get(b'vehicles', [])
            if vehicles:
                if isinstance(vehicles, dict):
                    vehicles = [
                     vehicles]
            for vehicleDict in vehicles:
                for vehCompDescr, vehData in vehicleDict.iteritems():
                    isNegative = False
                    if isinstance(vehCompDescr, types.IntType):
                        isNegative = vehCompDescr < 0
                    if b'customCompensation' not in vehData and isNegative and vehData.get(b'destroyPairModifications', False):
                        vehicleName = self.__getVehicleName(vehCompDescr)
                        if vehicleName is not None:
                            rMessage = R.strings.messenger.serviceChannelMessages
                            template = self.__DESTROY_PAIR_MODIFICATIONS_MSG_TEMPLATE
                            formatted = g_settings.msgTemplates.format(template, ctx={b'text': backport.text(rMessage.vehiclePostProgression.discardAllPairsModification.body(), vehicle=vehicleName)})
                            result.append(MessageData(formatted, self._getGuiSettings(formatted, template)))

            return result

    def __getReferralProgramMsg(self, data):
        dataEx = data.get(b'data', {})
        price = data.get(b'meta', {}).get(b'price', {})
        referralLootBoxCount = 0
        result = []
        if price.get(b'currency_code') == constants.RP_POINT:
            template = b'ReferralProgramFinanceOperationSysMessage'
            atStr = g_settings.htmlTemplates.format(b'transactionTime', ctx={b'at': self._getOperationTimeString(data)})
            debitedStr = g_settings.htmlTemplates.format(b'rpPointsDebited', ctx={b'points': price.get(b'amount', 0)})
            formatted = g_settings.msgTemplates.format(template, ctx={b'text': (b'<br/>').join((atStr, debitedStr)), 
               b'header': backport.text(R.strings.messenger.serviceChannelMessages.referralTransaction.header())})
            result.append(MessageData(formatted, self._getGuiSettings(formatted, template)))
        for tokenName, tokenData in dataEx.get(b'tokens', {}).iteritems():
            if constants.LOOTBOX_TOKEN_PREFIX in tokenName:
                lootBox = self._itemsCache.items.tokens.getLootBoxByTokenID(tokenName)
                if lootBox is not None and lootBox.getCategory() == REFERRAL_PROGRAM_CATEGORY:
                    referralLootBoxCount += tokenData.get(b'count', 0)

        if referralLootBoxCount:
            template = b'rpLootBoxesInvoiceReceived'
            formatted = g_settings.msgTemplates.format(template, ctx={b'count': referralLootBoxCount, 
               b'at': self._getOperationTimeString(data)})
            result.append(MessageData(formatted, self._getGuiSettings(formatted, template)))
        return result

    @adisp_async
    @adisp_process
    def __waitForSyncData(self, data, callback):
        yield lambda callback: callback(True)
        assetType = data.get(b'assetType', self.__INVALID_TYPE_ASSET)
        if assetType == INVOICE_ASSET.PURCHASE:
            if self.__purchaseCache.canBeRequestedFromProduct(data):
                purchaseDescrUrl = self.__purchaseCache.getProductCode(data.get(b'meta'))
                pD = yield self.__purchaseCache.requestPurchaseByID(purchaseDescrUrl)
                callback(pD.getDisplayWays().showNotification)
            else:
                _logger.debug(b'Data can not be requested from the product! System message will be shown without product data!')
                callback(True)
        else:
            callback(True)

    def __getMetaUrlData(self, data):
        meta = data.get(b'meta')
        if meta:
            productUrl = meta.get(b'product_id')
            if productUrl:
                return productUrl
            _logger.error(b'Could not find product_code in meta section of invoice!')
        else:
            _logger.error(b'Could not find meta section in purchase invoice!')
        return


class AdminMessageFormatter(ServiceChannelFormatter):

    def format(self, message, *args):
        data = decompressSysMessage(message.data)
        if data:
            dataType = type(data)
            text = b''
            if dataType in types.StringTypes:
                text = data
            else:
                if dataType is types.DictType:
                    text = getLocalizedData({b'value': data}, b'value')
                if not text:
                    _logger.error(b'Text of message not found: %s', message)
                    return (None, None)
            formatted = g_settings.msgTemplates.format(b'adminMessage', {b'text': text})
            return [
             MessageData(formatted, self._getGuiSettings(message, b'adminMessage'))]
        else:
            return [
             MessageData(None, None)]
            return


class AccountTypeChangedFormatter(ServiceChannelFormatter):

    def format(self, message, *args):
        data = message.data
        isPremium = data.get(b'isPremium', None)
        expiryTime = data.get(b'expiryTime', None)
        result = [MessageData(None, None)]
        if isPremium is not None:
            accountTypeName = backport.text(R.strings.menu.accountTypes.base())
            if isPremium:
                accountTypeName = backport.text(R.strings.menu.accountTypes.premium())
            expiryDatetime = TimeFormatter.getLongDatetimeFormat(expiryTime) if expiryTime else None
            if expiryDatetime:
                templateKey = b'accountTypeChangedWithExpiration'
                ctx = {b'accType': accountTypeName, 
                   b'expiryTime': expiryDatetime}
            else:
                templateKey = b'accountTypeChanged'
                ctx = {b'accType': accountTypeName}
            formatted = g_settings.msgTemplates.format(templateKey, ctx=ctx)
            result = [MessageData(formatted, self._getGuiSettings(message, templateKey))]
        return result


class _PremiumActionFormatter(ServiceChannelFormatter):
    _templateKey = None
    _msgTemplateKey = None

    def _getMessage(self, isPremium, premiumType, expiryTime):
        return

    def format(self, message, *args):
        data = message.data
        isPremium = data.get(b'isPremium')
        expiryTime = data.get(b'expiryTime', 0)
        premiumType = data.get(b'premType')
        if isPremium is not None and premiumType is not None:
            return [
             MessageData(self._getMessage(isPremium, premiumType, expiryTime), self._getGuiSettings(message, self._templateKey))]
        else:
            return [
             MessageData(None, None)]


class PremiumBoughtFormatter(_PremiumActionFormatter):
    _templateKey = str(SYS_MESSAGE_TYPE.premiumBought)
    _msgTemplateKey = str(SYS_MESSAGE_TYPE.premiumChanged)

    def _getMessage(self, isPremium, premiumType, expiryTime):
        result = None
        if isPremium is True and expiryTime > 0:
            formattedText = backport.text(_PREMIUM_MESSAGES[premiumType][self._templateKey], expiryTime=text_styles.titleFont(TimeFormatter.getLongDatetimeFormat(expiryTime)))
            result = g_settings.msgTemplates.format(self._msgTemplateKey, ctx={b'text': formattedText})
        return result


class PremiumExtendedFormatter(PremiumBoughtFormatter):
    _templateKey = str(SYS_MESSAGE_TYPE.premiumExtended)


class PremiumChangedFormatter(PremiumBoughtFormatter):
    _templateKey = str(SYS_MESSAGE_TYPE.premiumChanged)


class PremiumExpiredFormatter(_PremiumActionFormatter):
    _templateKey = str(SYS_MESSAGE_TYPE.premiumExpired)
    _msgTemplateKey = str(SYS_MESSAGE_TYPE.premiumExpired)

    def _getMessage(self, isPremium, premiumType, expiryTime):
        result = None
        if isPremium is False:
            result = g_settings.msgTemplates.format(self._msgTemplateKey, ctx={b'text': backport.text(_PREMIUM_MESSAGES[premiumType][self._templateKey])})
        return result


class PrebattleFormatter(ServiceChannelFormatter):
    __battleTypeByPrebattleType = {PREBATTLE_TYPE.TOURNAMENT: b'tournament', 
       PREBATTLE_TYPE.CLAN: b'clan'}
    _battleFinishReasonKeys = {}
    _defaultBattleFinishReasonKey = (
     b'base', True)

    def isNotify(self):
        return True

    def _getIconId(self, prbType):
        iconId = b'BattleResultIcon'
        if prbType == PREBATTLE_TYPE.CLAN:
            iconId = b'ClanBattleResultIcon'
        elif prbType == PREBATTLE_TYPE.TOURNAMENT:
            iconId = b'TournamentBattleResultIcon'
        return iconId

    def _makeBattleTypeString(self, prbType):
        typeString = self.__battleTypeByPrebattleType.get(prbType, b'prebattle')
        return backport.text(R.strings.messenger.serviceChannelMessages.prebattle.battleType.dyn(typeString)())

    def _makeDescriptionString(self, data, showBattlesCount=True):
        if b'localized_data' in data and data[b'localized_data']:
            description = getPrebattleFullDescription(data, escapeHtml=True)
        else:
            prbType = data.get(b'type')
            description = self._makeBattleTypeString(prbType)
        battlesLimit = data.get(b'battlesLimit', 0)
        if showBattlesCount and battlesLimit > 1:
            battlesCount = data.get(b'battlesCount')
            if battlesCount > 0:
                numberOfBattleString = backport.text(R.strings.messenger.serviceChannelMessages.prebattle.numberOfBattle(), battlesCount)
                description = (b'{0:s} {1:s}').format(description, numberOfBattleString)
            else:
                _logger.warning(b'Invalid value of battlesCount: %s', battlesCount)
        return description

    def _getOpponentsString(self, opponents):
        firstOp = opponents.get(b'1', {}).get(b'name', b'')
        secondOp = opponents.get(b'2', {}).get(b'name', b'')
        result = b''
        if firstOp and secondOp:
            result = g_settings.htmlTemplates.format(b'prebattleOpponents', ctx={b'first': html.escape(firstOp), 
               b'second': html.escape(secondOp)})
        return result

    def _getBattleResultString(self, winner, team):
        result = b'undefined'
        if 3 > winner > -1 and team in (1, 2):
            if not winner:
                result = b'draftGame'
            else:
                result = b'defeat' if team != winner else b'win'
        return result

    def _makeBattleResultString(self, finishReason, winner, team):
        finishString, showResult = self._battleFinishReasonKeys.get(finishReason, self._defaultBattleFinishReasonKey)
        if showResult:
            resultString = self._getBattleResultString(winner, team)
            resID = R.strings.messenger.serviceChannelMessages.prebattle.finish.dyn(finishString).dyn(resultString)()
        else:
            resID = R.strings.messenger.serviceChannelMessages.prebattle.finish.dyn(finishString)()
        return backport.text(resID)


class PrebattleArenaFinishFormatter(PrebattleFormatter):
    _battleFinishReasonKeys = {FINISH_REASON.TECHNICAL: (
                               b'technical', True), 
       FINISH_REASON.FAILURE: (
                             b'failure', False), 
       FINISH_REASON.UNKNOWN: (
                             b'failure', False)}

    def format(self, message, *args):
        _logger.debug(b'prbArenaFinish %s', message)
        data = message.data
        prbType = data.get(b'type')
        winner = data.get(b'winner')
        team = data.get(b'team')
        wins = data.get(b'wins')
        finishReason = data.get(b'finishReason')
        if None in [prbType, winner, team, wins, finishReason]:
            return []
        else:
            battleResult = self._makeBattleResultString(finishReason, winner, team)
            subtotal = b''
            battlesLimit = data.get(b'battlesLimit', 0)
            if battlesLimit > 1:
                battlesCount = data.get(b'battlesCount', -1)
                winsLimit = data.get(b'winsLimit', -1)
                if battlesCount == battlesLimit or winsLimit == wins[1] or winsLimit == wins[2]:
                    playerTeamWins = wins[team]
                    otherTeamWins = wins[(2 if team == 1 else 1)]
                    if winsLimit > 0 and playerTeamWins < winsLimit and otherTeamWins < winsLimit:
                        winner = None
                    elif playerTeamWins == otherTeamWins:
                        winner = 0
                    else:
                        winner = 1 if wins[1] > wins[2] else 2
                    sessionResult = self._makeBattleResultString(-1, winner, team)
                    subtotal = g_settings.htmlTemplates.format(b'prebattleTotal', ctx={b'result': sessionResult, 
                       b'first': wins[1], 
                       b'second': wins[2]})
                else:
                    subtotal = g_settings.htmlTemplates.format(b'prebattleSubtotal', ctx={b'first': wins[1], 
                       b'second': wins[2]})
            formatted = g_settings.msgTemplates.format(b'prebattleArenaFinish', ctx={b'desc': self._makeDescriptionString(data), 
               b'opponents': self._getOpponentsString(data.get(b'opponents', {})), 
               b'result': battleResult, 
               b'subtotal': subtotal}, data={b'timestamp': _getTimeStamp(message), 
               b'icon': self._getIconId(prbType)})
            return [
             MessageData(formatted, self._getGuiSettings(message, b'prebattleArenaFinish'))]


class PrebattleKickFormatter(PrebattleFormatter):

    def format(self, message, *args):
        data = message.data
        result = []
        prbType = data.get(b'type')
        kickReason = data.get(b'kickReason')
        if prbType > 0 and kickReason > 0:
            ctx = {}
            resID = R.strings.system_messages.prebattle.kick.type.unknown()
            if prbType in PREBATTLE_TYPE.SQUAD_PREBATTLES:
                resID = R.strings.system_messages.prebattle.kick.type.squad()
            ctx[b'type'] = backport.text(resID)
            kickName = KICK_REASON_NAMES[kickReason]
            resID = R.strings.system_messages.prebattle.kick.reason.dyn(kickName)()
            ctx[b'reason'] = backport.text(resID)
            formatted = g_settings.msgTemplates.format(b'prebattleKick', ctx=ctx)
            result = [
             MessageData(formatted, self._getGuiSettings(message, b'prebattleKick'))]
        return result


class PrebattleDestructionFormatter(PrebattleFormatter):
    _battleFinishReasonKeys = {KICK_REASON.ARENA_CREATION_FAILURE: (
                                          b'failure', False), 
       KICK_REASON.AVATAR_CREATION_FAILURE: (
                                           b'failure', False), 
       KICK_REASON.VEHICLE_CREATION_FAILURE: (
                                            b'failure', False), 
       KICK_REASON.PREBATTLE_CREATION_FAILURE: (
                                              b'failure', False), 
       KICK_REASON.BASEAPP_CRASH: (
                                 b'failure', False), 
       KICK_REASON.CELLAPP_CRASH: (
                                 b'failure', False), 
       KICK_REASON.UNKNOWN_FAILURE: (
                                   b'failure', False), 
       KICK_REASON.CREATOR_LEFT: (
                                b'creatorLeft', False), 
       KICK_REASON.PLAYERKICK: (
                              b'playerKick', False), 
       KICK_REASON.TIMEOUT: (
                           b'timeout', False)}

    def format(self, message, *args):
        _logger.debug(b'prbDestruction %s', message)
        data = message.data
        prbType = data.get(b'type')
        team = data.get(b'team')
        wins = data.get(b'wins')
        kickReason = data.get(b'kickReason')
        if None in [prbType, team, wins, kickReason]:
            return []
        else:
            playerTeamWins = wins[team]
            otherTeamWins = wins[(2 if team == 1 else 1)]
            winsLimit = data.get(b'winsLimit')
            if winsLimit > 0 and playerTeamWins < winsLimit and otherTeamWins < winsLimit:
                winner = None
            elif playerTeamWins == otherTeamWins:
                winner = 0
            else:
                winner = 1 if wins[1] > wins[2] else 2
            battleResult = self._makeBattleResultString(kickReason, winner, team)
            total = b''
            if data.get(b'battlesLimit', 0) > 1:
                total = (b'({0:d}:{1:d})').format(wins[1], wins[2])
            formatted = g_settings.msgTemplates.format(b'prebattleDestruction', ctx={b'desc': self._makeDescriptionString(data, showBattlesCount=False), 
               b'opponents': self._getOpponentsString(data.get(b'opponents', {})), 
               b'result': battleResult, 
               b'total': total}, data={b'timestamp': _getTimeStamp(message), 
               b'icon': self._getIconId(prbType)})
            return [
             MessageData(formatted, self._getGuiSettings(message, b'prebattleDestruction'))]


class VehCamouflageTimedOutFormatter(ServiceChannelFormatter):

    def isNotify(self):
        return True

    def format(self, message, *args):
        data = message.data
        formatted = None
        vehTypeCompDescr = data.get(b'vehTypeCompDescr')
        if vehTypeCompDescr is not None:
            vType = vehicles_core.getVehicleType(vehTypeCompDescr)
            if vType is not None:
                formatted = g_settings.msgTemplates.format(b'vehCamouflageTimedOut', ctx={b'vehicleName': getUserName(vType)})
        return [
         MessageData(formatted, self._getGuiSettings(message, b'vehCamouflageTimedOut'))]


class VehEmblemTimedOutFormatter(ServiceChannelFormatter):

    def isNotify(self):
        return True

    def format(self, message, *args):
        data = message.data
        formatted = None
        vehTypeCompDescr = data.get(b'vehTypeCompDescr')
        if vehTypeCompDescr is not None:
            vType = vehicles_core.getVehicleType(vehTypeCompDescr)
            if vType is not None:
                formatted = g_settings.msgTemplates.format(b'vehEmblemTimedOut', ctx={b'vehicleName': getUserName(vType)})
        return [
         MessageData(formatted, self._getGuiSettings(message, b'vehEmblemTimedOut'))]


class VehInscriptionTimedOutFormatter(ServiceChannelFormatter):

    def isNotify(self):
        return True

    def format(self, message, *args):
        data = message.data
        formatted = None
        vehTypeCompDescr = data.get(b'vehTypeCompDescr')
        if vehTypeCompDescr is not None:
            vType = vehicles_core.getVehicleType(vehTypeCompDescr)
            if vType is not None:
                formatted = g_settings.msgTemplates.format(b'vehInscriptionTimedOut', ctx={b'vehicleName': getUserName(vType)})
        return [
         MessageData(formatted, self._getGuiSettings(message, b'vehInscriptionTimedOut'))]


class ConverterFormatter(ServiceChannelFormatter):
    __itemsCache = dependency.descriptor(IItemsCache)
    __CONVERTER_BLUEPRINTS_TEMPLATE = b'ConverterBlueprintsNotify'

    def __i18nValue(self, key, isReceived, **kwargs):
        key = (b'%sReceived' if isReceived else b'%sWithdrawn') % key
        resID = R.strings.messenger.serviceChannelMessages.sysMsg.converter.dyn(key)()
        return backport.text(resID) % kwargs

    def __vehName(self, vehCompDescr):
        return getUserName(vehicles_core.getVehicleType(abs(vehCompDescr)))

    def format(self, message, *args):
        data = message.data
        text = []
        if data.get(b'inscriptions'):
            text.append(backport.text(R.strings.messenger.serviceChannelMessages.sysMsg.converter.inscriptions()))
        if data.get(b'emblems'):
            text.append(backport.text(R.strings.messenger.serviceChannelMessages.sysMsg.converter.emblems()))
        if data.get(b'camouflages'):
            text.append(backport.text(R.strings.messenger.serviceChannelMessages.sysMsg.converter.camouflages()))
        if data.get(b'customizations'):
            text.append(backport.text(R.strings.messenger.serviceChannelMessages.sysMsg.converter.customizations()))
        vehicles = data.get(b'vehicles')
        if vehicles:
            vehiclesReceived = [ self.__vehName(cd) for cd in vehicles if cd > 0 and self.__itemsCache.items.doesVehicleExist(cd) ]
            if vehiclesReceived:
                text.append(self.__i18nValue(b'vehicles', True, vehicles=(b', ').join(vehiclesReceived)))
            vehiclesWithdrawn = [ self.__vehName(cd) for cd in vehicles if cd < 0 and self.__itemsCache.items.doesVehicleExist(abs(cd))
                                ]
            if vehiclesWithdrawn:
                text.append(self.__i18nValue(b'vehicles', False, vehicles=(b', ').join(vehiclesWithdrawn)))
        slots = data.get(b'slots')
        if slots:
            text.append(self.__i18nValue(b'slots', slots > 0, slots=backport.getIntegralFormat(abs(slots))))
        for currency in Currency.ALL:
            value = data.get(currency)
            if value:
                formatter = getBWFormatter(currency)
                kwargs = {currency: formatter(abs(value))}
                text.append(self.__i18nValue(currency, (value > 0), **kwargs))

        freeXP = data.get(b'freeXP')
        if freeXP:
            text.append(self.__i18nValue(b'freeXP', freeXP > 0, freeXP=backport.getIntegralFormat(abs(freeXP))))
        messagesListData = []
        if text:
            formatted = g_settings.msgTemplates.format(b'ConverterNotify', {b'text': (b'<br/>').join(text)})
            messagesListData.append(MessageData(formatted, self._getGuiSettings(message, b'ConverterNotify')))
        if data.get(b'projectionDecalsDemounted'):
            messageKey = R.strings.messenger.serviceChannelMessages.sysMsg.converter.projectionDecalsDemounted()
            messageText = backport.text(messageKey)
            templateName = b'ProjectionDecalsDemountedSysMessage'
            formatted = g_settings.msgTemplates.format(templateName, {b'text': messageText})
            messagesListData.append(MessageData(formatted, self._getGuiSettings(message, b'ProjectionDecalsDemountedSysMessage')))
        blueprints = data.get(b'blueprints')
        if blueprints:
            blueprintsText = self.__getBlueprintsMessageText(blueprints)
            if blueprintsText is not None:
                messagesListData.append(MessageData(blueprintsText, self._getGuiSettings(message, self.__CONVERTER_BLUEPRINTS_TEMPLATE)))
        return messagesListData

    def __getBlueprintsMessageText(self, blueprints):
        universal = 0
        national = defaultdict(int)
        text = []
        for blueprintCD in blueprints:
            fragmentType = getFragmentType(blueprintCD)
            if fragmentType == BlueprintTypes.INTELLIGENCE_DATA:
                universal += blueprints[blueprintCD]
            elif fragmentType == BlueprintTypes.NATIONAL:
                nationID = getFragmentNationID(blueprintCD)
                nationName = nations.MAP.get(nationID, nations.NONE_INDEX)
                national[nationName] += blueprints[blueprintCD]

        if universal > 0:
            text.append(g_settings.htmlTemplates.format(b'intelligenceBlueprintReceived', {b'count': backport.getIntegralFormat(universal)}))
        for nation in GUI_NATIONS:
            if national[nation] > 0:
                text.append(g_settings.htmlTemplates.format(b'nationalBlueprintReceived', {b'count': backport.getIntegralFormat(national[nation]), 
                   b'nationName': backport.text(R.strings.nations.dyn(nation).genetiveCase())}))

        if text:
            return g_settings.msgTemplates.format(self.__CONVERTER_BLUEPRINTS_TEMPLATE, {b'text': (b'<br/>').join(text)})
        else:
            return


class ClientSysMessageFormatter(ServiceChannelFormatter):
    __templateKey = b'%sSysMessage'

    def format(self, data, *args):
        if args:
            msgType, _, messageData, savedData = args[0]
        else:
            msgType = b'Error'
            messageData = None
            savedData = None
        templateKey = self.__templateKey % msgType
        ctx = {b'text': data}
        if messageData:
            ctx.update(messageData)
        formatted = g_settings.msgTemplates.format(templateKey, ctx=ctx, data={b'savedData': savedData})
        return [
         MessageData(formatted, self._getGuiSettings(args, templateKey))]

    def _getGuiSettings(self, data, key=None, priorityLevel=None, groupID=None):
        if isinstance(data, types.TupleType) and data:
            auxData = data[0][:]
            if len(data[0]) > 1 and priorityLevel is None:
                priorityLevel = data[0][1]
        else:
            auxData = []
        if priorityLevel is None:
            priorityLevel = g_settings.msgTemplates.priority(key)
        if groupID is None:
            groupID = g_settings.msgTemplates.groupID(key)
        lifeTime = g_settings.msgTemplates.lifeTime(key)
        return NotificationGuiSettings(self.isNotify(), priorityLevel=priorityLevel, auxData=auxData, groupID=groupID, lifeTime=lifeTime)


class PremiumAccountExpiryFormatter(ClientSysMessageFormatter):

    def format(self, data, *args):
        formatted = g_settings.msgTemplates.format(b'durationOfPremiumAccountExpires', ctx={b'expiryTime': text_styles.titleFont(TimeFormatter.getLongDatetimeFormat(data))})
        return [
         MessageData(formatted, self._getGuiSettings(args, b'durationOfPremiumAccountExpires'))]


class SessionControlFormatter(ServiceChannelFormatter):

    def _doFormat(self, text, key, auxData):
        formatted = g_settings.msgTemplates.format(key, {b'text': text})
        priorityLevel = g_settings.msgTemplates.priority(key)
        return [
         MessageData(formatted, NotificationGuiSettings(self.isNotify(), priorityLevel=priorityLevel, auxData=auxData))]


class AOGASNotifyFormatter(SessionControlFormatter):

    def format(self, data, *args):
        return self._doFormat(backport.text(R.strings.aogas.dyn(data.name())()), b'AOGASNotify', *args)


class KoreaParentalControlFormatter(SessionControlFormatter):

    def format(self, data, *args):
        return self._doFormat(data, (b'%sSysMessage' % SM_TYPE.Warning), *args)


class VehicleTypeLockExpired(ServiceChannelFormatter):

    def format(self, message, *args):
        result = []
        if message.data:
            ctx = {}
            vehTypeCompDescr = message.data.get(b'vehTypeCompDescr')
            if vehTypeCompDescr is None:
                templateKey = b'vehiclesAllLockExpired'
            else:
                templateKey = b'vehicleLockExpired'
                ctx[b'vehicleName'] = getUserName(vehicles_core.getVehicleType(vehTypeCompDescr))
            formatted = g_settings.msgTemplates.format(templateKey, ctx=ctx)
            result = [MessageData(formatted, self._getGuiSettings(message, b'vehicleLockExpired'))]
        return result


class ServerDowntimeCompensation(ServiceChannelFormatter):
    __templateKey = b'serverDowntimeCompensation'

    def format(self, message, *args):
        result = []
        subjects = b''
        data = message.data
        if data is not None:
            for key, value in data.items():
                if value:
                    if subjects:
                        subjects += b', '
                    subjects += backport.text(R.strings.messenger.serviceChannelMessages.serverDowntimeCompensation.dyn(key)())

            if subjects:
                formatted = g_settings.msgTemplates.format(self.__templateKey, ctx={b'text': backport.text(R.strings.messenger.serviceChannelMessages.serverDowntimeCompensation.message()) % subjects})
                result = [
                 MessageData(formatted, self._getGuiSettings(message, self.__templateKey))]
        return result


class ActionNotificationFormatter(ClientSysMessageFormatter):
    __templateKey = b'action%s'

    def format(self, message, *args):
        result = []
        data = message.get(b'data')
        if data:
            templateKey = self.__templateKey % message.get(b'state', b'')
            formatted = g_settings.msgTemplates.format(templateKey, ctx={b'text': data}, data={b'icon': message.get(b'type', b'')})
            result = [
             MessageData(formatted, self._getGuiSettings(args, templateKey))]
        return result


class BootcampResultsFormatter(WaitItemsSyncFormatter):

    def isNotify(self):
        return True

    @adisp_async
    @adisp_process
    def format(self, message, callback):
        _logger.debug(b'message data: %s', message)
        isSynced = yield self._waitForSyncItems()
        formatted, settings = (None, None)
        if isSynced:
            text = []
            results = message.data
            if results:
                text.append(self.__formatAwards(results))
            else:
                text.append(backport.text(R.strings.messenger.serviceChannelMessages.bootcamp.no_awards()))
            settings = self._getGuiSettings(message, b'bootcampResults')
            formatted = g_settings.msgTemplates.format(b'bootcampResults', {b'text': (b'<br/>').join(text)}, data={b'timestamp': _getTimeStamp(message)})
        callback([MessageData(formatted, settings)])
        return

    def __formatAwards(self, results):
        awards = backport.text(R.strings.messenger.serviceChannelMessages.bootcamp.awards()) + b'<br/>'
        awards += self.__getAssetString(results, INVOICE_ASSET.GOLD, b'gold')
        awards += self.__getAssetString(results, INVOICE_ASSET.PREMIUM, b'premium')
        awards += self.__getAssetString(results, INVOICE_ASSET.CREDITS, b'credits')
        awards += self.__getAssetString(results, INVOICE_ASSET.FREE_XP, b'freeXP')
        tankPremiumDays = results.get(PREMIUM_ENTITLEMENTS.PLUS, 0)
        if tankPremiumDays:
            awards += b'<br/>' + g_settings.htmlTemplates.format(b'tankPremiumAccruedInvoiceReceived', {b'amount': backport.getIntegralFormat(abs(tankPremiumDays))})

        def sortVehsByLvl(vehCD):
            veh = self._itemsCache.items.getItemByCD(vehCD)
            return veh.level

        vehicles = results.get(b'vehicles', {})
        vehicleCDs = sorted(vehicles.keys(), key=sortVehsByLvl)
        vehiclesNames = []
        devicesAndCrew = b''
        for vehCD in vehicleCDs:
            vehData = vehicles[vehCD]
            vehicle = self._itemsCache.items.getItemByCD(vehCD)
            if vehicle:
                if vehData.get(b'devices', None):
                    devicesAndCrew += self.__formatDevicesAndCrew(vehicle.userName, vehData)
                else:
                    vehiclesNames.append(vehicle.userName)

        awards += b'<br/>'
        if vehiclesNames:
            awards += g_settings.htmlTemplates.format(b'vehiclesAccruedInvoiceReceived', ctx={b'vehicles': (b', ').join(vehiclesNames)}) + b'<br/>'
        slots = results.get(b'slots', 0)
        if slots:
            awards += b'<br/>' + g_settings.htmlTemplates.format(b'slotsAccruedInvoiceReceived', {b'amount': backport.getIntegralFormat(abs(slots))})
        if devicesAndCrew:
            awards += devicesAndCrew
        return awards

    @staticmethod
    def __formatDevicesAndCrew(vehName, vehData):
        devices = vehData.get(b'devices', [])
        name = b'<br/><br/><b>' + vehName + b'</b>: <br/>'
        message = b''
        if devices:
            message += name
            message += backport.text(R.strings.messenger.serviceChannelMessages.bootcamp.devices())
            itemsNames = []
            for intCD, count in devices:
                itemDescr = vehicles_core.getItemByCompactDescr(intCD)
                if itemDescr.i18n.userString != b'':
                    itemsNames.append(backport.text(R.strings.messenger.serviceChannelMessages.battleResults.quests.items.name(), name=itemDescr.i18n.userString, count=backport.getIntegralFormat(count)))

            if itemsNames:
                message += b'<br/>' + (b', ').join(itemsNames) + b'<br/>'
        crewInBarracks = vehData.get(b'crewInBarracks', False)
        if crewInBarracks:
            message += backport.text(R.strings.messenger.serviceChannelMessages.bootcamp.crew())
        return message

    @staticmethod
    def __getAssetString(results, assetType, amountType):
        amount = results.get(amountType, 0)
        if amount:
            templateKeys = {INVOICE_ASSET.GOLD: b'goldAccruedInvoiceReceived', INVOICE_ASSET.CREDITS: b'creditsAccruedInvoiceReceived', 
               INVOICE_ASSET.PREMIUM: b'premiumAccruedInvoiceReceived', 
               INVOICE_ASSET.FREE_XP: b'freeXpAccruedInvoiceReceived'}
            return b'<br/>' + g_settings.htmlTemplates.format(templateKeys[assetType], ctx={b'amount': backport.getIntegralFormat(abs(amount))})
        return b''


class QuestAchievesFormatter(object):
    _SEPARATOR = b'<br/>'
    __lobbyContext = dependency.descriptor(ILobbyContext)
    __goodiesCache = dependency.descriptor(IGoodiesCache)
    __itemsCache = dependency.descriptor(IItemsCache)
    __guiLootbox = dependency.descriptor(IGuiLootBoxesController)

    @classmethod
    def formatQuestAchieves(cls, data, asBattleFormatter, processCustomizations=True, processTokens=True):
        result = cls.getFormattedAchieves(data, asBattleFormatter, processCustomizations, processTokens)
        if result:
            return cls._SEPARATOR.join(result)
        else:
            return

    @classmethod
    def getFormattedAchieves(cls, data, asBattleFormatter, processCustomizations=True, processTokens=True):
        result = []
        tokenResult = cls._processTokens(data)
        if tokenResult and processTokens:
            result.append(tokenResult)
        if not asBattleFormatter:
            crystal = data.get(Currency.CRYSTAL, 0)
            if crystal:
                fomatter = getBWFormatter(Currency.CRYSTAL)
                result.append(cls.__makeQuestsAchieve(b'battleQuestsCrystal', crystal=fomatter(crystal)))
            eventCoin = data.get(Currency.EVENT_COIN, 0)
            if eventCoin:
                fomatter = getBWFormatter(Currency.EVENT_COIN)
                result.append(cls.__makeQuestsAchieve(b'battleQuestsEventCoin', eventCoin=fomatter(eventCoin)))
            equipCoin = data.get(Currency.EQUIP_COIN, 0)
            if equipCoin:
                fomatter = getBWFormatter(Currency.EQUIP_COIN)
                result.append(cls.__makeQuestsAchieve(b'battleQuestsEquipCoin', equipCoin=fomatter(equipCoin)))
            gold = data.get(Currency.GOLD, 0)
            if gold:
                fomatter = getBWFormatter(Currency.GOLD)
                result.append(cls.__makeQuestsAchieve(b'battleQuestsGold', gold=fomatter(gold)))
            bpcoin = data.get(Currency.BPCOIN, 0)
            if bpcoin:
                fomatter = getBWFormatter(Currency.BPCOIN)
                result.append(cls.__makeQuestsAchieve(b'battleQuestsBpcoin', bpcoin=fomatter(bpcoin)))
            platformCurrencies = data.get(b'currencies', {})
            for currency, countDict in platformCurrencies.iteritems():
                result.append(cls.__makeQuestsAchieve(b'platformCurrency', msg=backport.text(R.strings.messenger.platformCurrencyMsg.received.dyn(currency)()), count=backport.getIntegralFormat(countDict.get(b'count', 0))))

        for premiumType in PREMIUM_ENTITLEMENTS.ALL_TYPES:
            premium = data.get(premiumType, 0)
            if premium:
                result.append(cls.__makeQuestsAchieve(_PREMIUM_TEMPLATES[premiumType], days=premium))

        if not asBattleFormatter:
            freeXP = data.get(b'freeXP', 0)
            if freeXP:
                result.append(cls.__makeQuestsAchieve(b'battleQuestsFreeXP', freeXP=backport.getIntegralFormat(freeXP)))
        vehiclesList = data.get(b'vehicles', [])
        msg = InvoiceReceivedFormatter.getVehiclesString(vehiclesList, htmlTplPostfix=b'QuestsReceived')
        if msg:
            result.append(msg)
        comptnStr = InvoiceReceivedFormatter.getVehiclesCompensationString(vehiclesList, htmlTplPostfix=b'QuestsReceived')
        if comptnStr:
            result.append(cls._SEPARATOR + comptnStr if result else comptnStr)
        if not asBattleFormatter:
            creditsVal = data.get(Currency.CREDITS, 0)
            if creditsVal:
                fomatter = getBWFormatter(Currency.CREDITS)
                result.append(cls.__makeQuestsAchieve(b'battleQuestsCredits', credits=fomatter(creditsVal)))
        slots = data.get(b'slots', 0)
        if slots:
            result.append(cls.__makeQuestsAchieve(b'battleQuestsSlots', slots=backport.getIntegralFormat(slots)))
        if not asBattleFormatter:
            persistBattles = data.get(b'rankedBonusBattles', 0)
            if persistBattles:
                mainStrRes = R.strings.messenger.serviceChannelMessages.battleResults.quests.rankedBonusBattles()
                result.append(backport.text(mainStrRes, bonusBattles=persistBattles))
        items = data.get(b'items', {})
        itemsNames = []
        for intCD, count in items.iteritems():
            itemTypeID, _, _ = vehicles_core.parseIntCompactDescr(intCD)
            if itemTypeID == I_T.crewBook:
                if asBattleFormatter:
                    continue
                itemDescr = tankmen.getItemByCompactDescr(intCD)
                name = _getCrewBookUserString(itemDescr)
            else:
                itemDescr = vehicles_core.getItemByCompactDescr(intCD)
                name = itemDescr.i18n.userString
            itemsNames.append(backport.text(R.strings.messenger.serviceChannelMessages.battleResults.quests.items.name(), name=name, count=backport.getIntegralFormat(count)))

        goodies = data.get(b'goodies', {})
        excludeGoodies = set()
        for goodieID, ginfo in goodies.iteritems():
            if goodieID in cls.__itemsCache.items.shop.demountKits:
                excludeGoodies.add(goodieID)
                demountKit = cls.__goodiesCache.getDemountKit(goodieID)
                if demountKit is not None and demountKit.enabled:
                    itemsNames.append(backport.text(R.strings.demount_kit.demountKit.gained.count(), count=ginfo.get(b'count')))
            elif goodieID in cls.__itemsCache.items.shop.recertificationForms:
                excludeGoodies.add(goodieID)
                rf = cls.__goodiesCache.getRecertificationForm(goodieID)
                if rf is not None and rf.enabled:
                    itemsNames.append(backport.text(R.strings.system_messages.bonuses.booster.value(), count=ginfo.get(b'count'), name=rf.userName))

        abilityPts = data.get(constants.EPIC_ABILITY_PTS_NAME)
        if abilityPts:
            name = backport.text(R.strings.messenger.serviceChannelMessages.battleResults.epicAbilityPoints())
            itemsNames.append(backport.text(R.strings.messenger.serviceChannelMessages.battleResults.quests.items.name(), name=name, count=backport.getIntegralFormat(abilityPts)))
        tokens = data.get(b'tokens')
        if tokens:
            for tokenID, tokenData in tokens.iteritems():
                count = backport.getIntegralFormat(tokenData.get(b'count', 1))
                if tokenID.startswith(BATTLE_BONUS_X5_TOKEN):
                    itemsNames.append(backport.text(R.strings.messenger.serviceChannelMessages.battleResults.quests.items.name(), name=backport.text(R.strings.quests.bonusName.battle_bonus_x5()), count=count))
                elif tokenID.startswith(CREW_BONUS_X3_TOKEN):
                    itemsNames.append(backport.text(R.strings.messenger.serviceChannelMessages.battleResults.quests.items.name(), name=backport.text(R.strings.quests.bonusName.crew_bonus_x3()), count=count))
                elif tokenID == COMP7_TOKEN_WEEKLY_REWARD_ID:
                    itemsNames.append(backport.text(R.strings.messenger.serviceChannelMessages.battleResults.quests.items.name(), name=backport.text(R.strings.comp7.system_messages.weeklyReward.tokens()), count=count))
                elif tokenID.startswith(constants.LOOTBOX_TOKEN_PREFIX) and int(count) > 0:
                    lootBox = cls.__itemsCache.items.tokens.getLootBoxByTokenID(tokenID)
                    if lootBox:
                        itemsNames.append(makeHtmlString(b'html_templates:lobby/quests/bonuses', b'rawLootBox', {b'name': lootBox.getUserName(), b'count': int(count)}))
                elif tokenID.startswith(EARLY_ACCESS_PREFIX):
                    itemsNames.append(EarlyAccessQuestsTokensFormatter.format(data))
                elif tokenID.startswith(constants.LOOTBOX_KEY_PREFIX) and int(count) > 0:
                    key = cls.__guiLootbox.getKeyByTokenID(tokenID)
                    text = backport.text(R.strings.lootboxes.userName.dyn(key.userName)())
                    if key:
                        itemsNames.append(makeHtmlString(b'html_templates:lobby/quests/bonuses', b'lootBoxKey', {b'name': text, b'count': int(count)}))

        entitlementsList = [ (eID, eData.get(b'count', 0)) for eID, eData in data.get(b'entitlements', {}).iteritems() ]
        entitlementsStr = InvoiceReceivedFormatter.getEntitlementsString(entitlementsList)
        if entitlementsStr:
            itemsNames.append(entitlementsStr)
        if itemsNames:
            result.append(cls.__makeQuestsAchieve(b'battleQuestsItems', names=(b', ').join(itemsNames)))
        _extendCrewSkinsData(data, result)
        if processCustomizations:
            _extendCustomizationData(data, result, htmlTplPostfix=b'QuestsReceived')
        berths = data.get(b'berths', 0)
        if berths:
            result.append(cls.__makeQuestsAchieve(b'battleQuestsBerths', berths=backport.getIntegralFormat(berths)))
        tmen = data.get(b'tankmen', {})
        if tmen:
            result.append(InvoiceReceivedFormatter.getTankmenString(tmen))
        goodies = data.get(b'goodies', {})
        if goodies:
            strGoodies = InvoiceReceivedFormatter.getGoodiesString(goodies, exclude=excludeGoodies)
            if strGoodies:
                result.append(strGoodies)
        enhancements = data.get(b'enhancements', {})
        if enhancements:
            strEnhancements = InvoiceReceivedFormatter.getEnhancementsString(enhancements)
            if strEnhancements:
                result.append(strEnhancements)
        if not asBattleFormatter:
            blueprints = data.get(b'blueprints', {})
            if blueprints:
                strBlueprints = InvoiceReceivedFormatter.getBlueprintString(blueprints)
                if strBlueprints:
                    result.append(strBlueprints)
        if not asBattleFormatter:
            achievementsNames = cls._extractAchievements(data)
            if achievementsNames:
                result.append(cls.__makeQuestsAchieve(b'battleQuestsPopUps', achievements=(b', ').join(achievementsNames)))
            addBadgesStrings, removedBadgesStrings = cls.__extractBadges(data)
            if addBadgesStrings:
                result.append(cls.__makeQuestsAchieve(b'badgeAchievement', badges=(b', ').join(addBadgesStrings)))
            if removedBadgesStrings:
                result.append(cls.__makeQuestsAchieve(b'removedBadgeAchievement', badges=(b', ').join(removedBadgesStrings)))
        if not asBattleFormatter:
            for crewbookName in data.get(b'selectableCrewbook', {}):
                result.append(backport.text(R.strings.messenger.serviceChannelMessages.selectableCrewbook.dyn(crewbookName)()))

        if not asBattleFormatter:
            strDogTags = cls._processDogTags(data.get(b'dogTagComponents', {}))
            if strDogTags:
                result.append(strDogTags)
        return result

    @classmethod
    def _processTokens(cls, tokens):
        return b''

    @classmethod
    def _processDogTags(cls, dogTags):
        result = []
        for dogTag in dogTags:
            componentID = dogTag.get(b'id')
            component = componentConfigAdapter.getComponentById(componentID)
            if component is None:
                _logger.error(b'Wrong DogTag componentID: %s', componentID)
                continue
            result.append(backport.text(R.strings.messenger.serviceChannelMessages.dogTags.bonus.dyn(component.viewType.value)(), name=dogTagComposer.getComponentTitle(componentID)))

        return cls._SEPARATOR.join(result)

    @classmethod
    def _extractAchievements(cls, data):
        achieves = data.get(b'popUpRecords', [])
        result = set()
        for recordIdx, value in achieves:
            record = DB_ID_TO_RECORD[recordIdx]
            if record[0] == BADGES_BLOCK:
                continue
            factory = getAchievementFactory(record)
            if factory is not None:
                a = factory.create(value=int(value))
                if a is not None:
                    result.add(a.getUserName())

        return result

    @staticmethod
    def __extractBadges(data):
        addBadgesStrings, removedBadgesStrings = [], []
        for rec in data.get(b'dossier', {}).values():
            it = rec if not isinstance(rec, dict) else rec.iteritems()
            for (block, name), recData in it:
                if name != b'':
                    isRemoving = recData[b'value'] < 0
                    if block == BADGES_BLOCK:
                        if isRemoving:
                            removedBadgesStrings.append(backport.text(R.strings.badge.dyn((b'badge_{}').format(name))()))
                        else:
                            addBadgesStrings.append(backport.text(R.strings.badge.dyn((b'badge_{}').format(name))()))

        return (
         addBadgesStrings, removedBadgesStrings)

    @classmethod
    def __makeQuestsAchieve(cls, key, **kwargs):
        return g_settings.htmlTemplates.format(key, kwargs)


class TokenQuestsFormatter(WaitItemsSyncFormatter):
    __eventsCache = dependency.descriptor(IEventsCache)
    __MESSAGE_TEMPLATE = b'tokenQuests'

    def __init__(self, subFormatters=()):
        super(TokenQuestsFormatter, self).__init__()
        self._achievesFormatter = QuestAchievesFormatter()
        self.__subFormatters = subFormatters

    @adisp_async
    @adisp_process
    def format(self, message, callback):
        isSynced = yield self._waitForSyncItems()
        messageDataList = []
        if isSynced:
            data = message.data or {}
            completedQuestIDs = set(data.get(b'completedQuestIDs', set()))
            completedQuestIDs.update(data.get(b'rewardsGottenQuestIDs', set()))
            popUps = set(data.get(b'popUpRecords', set()))
            for qID in completedQuestIDs:
                self.__processMetaActions(qID)

            for subFormatter in self.__collectSubFormatters():
                subTokenQuestIDs = subFormatter.getQuestOfThisGroup(completedQuestIDs)
                if subTokenQuestIDs:
                    if subFormatter.isAsync():
                        result = yield subFormatter.format(message)
                    else:
                        result = subFormatter.format(message)
                    if result:
                        messageDataList.extend(result)
                    completedQuestIDs.difference_update(subTokenQuestIDs)
                    popUps.difference_update(subFormatter.getPopUps(message))

            if completedQuestIDs or popUps:
                messageData = self.__formatSimpleTokenQuests(message, completedQuestIDs, popUps)
                if messageData is not None:
                    messageDataList.append(messageData)
        if messageDataList:
            callback(messageDataList)
            return
        else:
            callback([MessageData(None, None)])
            return

    def canBeEmpty(self):
        return True

    @classmethod
    def __processMetaActions(cls, questID):
        quest = cls.__eventsCache.getAllQuests().get(questID)
        if quest is None:
            _logger.debug(b'Could not find quest with ID: %s', questID)
            return
        else:
            for bonus in quest.getBonuses():
                if not isinstance(bonus, MetaBonus):
                    continue
                for action, params in bonus.getActions():
                    bonus.handleAction(action, params)

            return

    def __collectSubFormatters(self):
        self.__subFormatters = self.__subFormatters or collectTokenQuestsSubFormatters()
        return self.__subFormatters

    def __formatSimpleTokenQuests(self, message, questIDs, popUps):
        rewards = getRewardsForQuests(message, questIDs)
        rewards[b'popUpRecords'] = popUps
        fmt = self._achievesFormatter.formatQuestAchieves(rewards, asBattleFormatter=False, processCustomizations=True)
        if fmt is not None:
            templateParams = {b'achieves': fmt}
            settings = self._getGuiSettings(message, self.__MESSAGE_TEMPLATE)
            formatted = g_settings.msgTemplates.format(self.__MESSAGE_TEMPLATE, templateParams)
            return MessageData(formatted, settings)
        else:
            return


class NCMessageFormatter(ServiceChannelFormatter):
    __templateKeyFormat = b'notificationsCenterMessage_{0}'

    def format(self, message, *args):
        _logger.debug(b'Message has received from notification center %s', message)
        data = z_loads(message.data)
        if not data:
            return []
        if b'body' not in data or not data[b'body']:
            return []
        templateKey = self.__getTemplateKey(data)
        priority = self.__getGuiPriority(data)
        topic = self.__getTopic(data)
        body = self.__getBody(data)
        settings = self._getGuiSettings(message, templateKey, priority)
        msgType = data[b'type']
        if msgType == NC_MESSAGE_TYPE.POLL:
            if not GUI_SETTINGS.isPollEnabled:
                return []
            if not self.__fetchPollData(data, settings):
                return []
        formatted = g_settings.msgTemplates.format(templateKey, ctx={b'topic': topic, b'body': body})
        return [
         MessageData(formatted, settings)]

    def __getTemplateKey(self, data):
        if b'type' in data:
            msgType = data[b'type']
            if msgType not in NC_MESSAGE_TYPE.RANGE:
                _logger.warning(b'Type of message is not valid, uses default type %s', msgType)
                msgType = NC_MESSAGE_TYPE.INFO
        else:
            msgType = NC_MESSAGE_TYPE.INFO
        return self.__templateKeyFormat.format(msgType)

    def __getGuiPriority(self, data):
        priority = NC_MESSAGE_PRIORITY.DEFAULT
        if b'priority' in data:
            priority = data[b'priority']
            if priority not in NC_MESSAGE_PRIORITY.ORDER:
                _logger.warning(b'Priority of message is not valid, uses default priority %s', priority)
                priority = NC_MESSAGE_PRIORITY.DEFAULT
        return NotificationPriorityLevel.convertFromNC(priority)

    def __getTopic(self, data):
        topic = b''
        if b'topic' in data:
            topic = data[b'topic']
        if topic:
            topic = g_settings.htmlTemplates.format(b'notificationsCenterTopic', ctx={b'topic': topic})
        return topic

    def __getBody(self, data):
        body = data[b'body']
        if b'context' in data:
            body = body % self.__formatContext(data[b'context'])
        return body

    def __fetchPollData(self, data, settings):
        result = False
        if b'link' in data and data[b'link']:
            if b'topic' in data:
                topic = data[b'topic']
            else:
                topic = b''
            settings.auxData = [data[b'link'], topic]
            result = True
        return result

    def __formatContext(self, ctx):
        result = {}
        if not isinstance(ctx, types.DictType):
            _logger.error(b'Context is invalid %s', ctx)
            return result
        getItemFormat = NCContextItemFormatter.getItemFormat
        for key, item in ctx.iteritems():
            if len(item) > 1:
                itemType, itemValue = item[0:2]
                result[key] = getItemFormat(itemType, itemValue)
            else:
                _logger.error(b'Context item is invalid %s', item)
                result[key] = str(item)

        return result


class ClanMessageFormatter(ServiceChannelFormatter):
    __templates = {SYS_MESSAGE_CLAN_EVENT.LEFT_CLAN: b'clanMessageWarning'}

    def format(self, message, *args):
        _logger.debug(b'Message has received from clan %s', message)
        data = message.data
        if data and b'event' in data:
            event = data[b'event']
            templateKey = self.__templates.get(event)
            fullName = getClanFullName(passCensor(data[b'clanName']), passCensor(data[b'clanAbbrev']))
            message = backport.text(R.strings.messenger.serviceChannelMessages.clan.dyn(SYS_MESSAGE_CLAN_EVENT_NAMES[event])())
            formatted = g_settings.msgTemplates.format(templateKey, ctx={b'message': message, b'fullClanName': fullName})
            settings = self._getGuiSettings(message, templateKey)
            return [
             MessageData(formatted, settings)]
        return []


class StrongholdMessageFormatter(ServiceChannelFormatter):
    __templates = {constants.SYS_MESSAGE_FORT_EVENT.RESERVE_ACTIVATED: b'fortReserveActivatedMessage'}
    DEFAULT_WARNING = b'fortMessageWarning'

    def __init__(self):
        super(StrongholdMessageFormatter, self).__init__()
        self.__messagesFormatters = {constants.SYS_MESSAGE_FORT_EVENT.RESERVE_ACTIVATED: BoundMethodWeakref(self._reserveActivatedMessage), 
           constants.SYS_MESSAGE_FORT_EVENT.RESERVE_EXPIRED: BoundMethodWeakref(self._reserveExpiredMessage)}

    def format(self, message, *args):
        _logger.debug(b'Message has received from fort %s', message)
        data = message.data
        if data and b'event' in data:
            event = data[b'event']
            templateKey = self.__templates.get(event, self.DEFAULT_WARNING)
            formatter = self.__messagesFormatters.get(event)
            if formatter is not None:
                messageSting = formatter(data)
                formatted = g_settings.msgTemplates.format(templateKey, ctx={b'message': messageSting})
                settings = self._getGuiSettings(message, templateKey)
                return [
                 MessageData(formatted, settings)]
            _logger.warning(b'StrongholdMessageFormatter has no available formatters for given message type: %s', event)
        return []

    def _buildMessage(self, event, ctx=None):
        if ctx is None:
            ctx = {}
        return backport.text(R.strings.messenger.serviceChannelMessages.fort.dyn(SYS_MESSAGE_FORT_EVENT_NAMES[event])(), **ctx)

    def getOrderUserString(self, orderTypeID):
        return backport.text(R.strings.fortifications.orders.dyn(constants.FORT_ORDER_TYPE_NAMES[orderTypeID])())

    def _reserveActivatedMessage(self, data):
        event = data[b'event']
        orderTypeID = data[b'orderTypeID']
        expirationTime = data[b'timeExpiration']
        order = text_styles.neutral(self.getOrderUserString(orderTypeID))
        return self._buildMessage(event, {b'order': order, 
           b'timeLeft': backport.getTillTimeStringByRClass(time_utils.getTimeDeltaFromNow(expirationTime), R.strings.menu.Time.timeValueWithSecs, removeLeadingZeros=False)})

    def _reserveExpiredMessage(self, data):
        return self._buildMessage(data[b'event'], {b'order': self.getOrderUserString(data[b'orderTypeID'])})


class VehicleRentedFormatter(ServiceChannelFormatter):
    _templateKey = b'vehicleRented'

    def format(self, message, *args):
        data = message.data
        vehTypeCD = data.get(b'vehTypeCD', None)
        expiryTime = data.get(b'time', None)
        if vehTypeCD is not None:
            return [
             MessageData(self._getMessage(vehTypeCD, expiryTime), self._getGuiSettings(message, self._templateKey))]
        else:
            return []

    def _getMessage(self, vehTypeCD, expiryTime):
        vehicleName = getUserName(vehicles_core.getVehicleType(vehTypeCD))
        ctx = {b'vehicleName': vehicleName, 
           b'expiryTime': text_styles.titleFont(TimeFormatter.getLongDatetimeFormat(expiryTime))}
        return g_settings.msgTemplates.format(self._templateKey, ctx=ctx)


class RentalsExpiredFormatter(ServiceChannelFormatter):
    _templateKey = b'rentalsExpired'

    def format(self, message, *args):
        vehTypeCD = message.data.get(b'vehTypeCD', None)
        if vehTypeCD is not None:
            return [
             MessageData(self._getMessage(vehTypeCD), self._getGuiSettings(message, self._templateKey))]
        else:
            return (None, None)

    def _getMessage(self, vehTypeCD):
        vehicleName = getUserName(vehicles_core.getVehicleType(vehTypeCD))
        ctx = {b'vehicleName': vehicleName}
        return g_settings.msgTemplates.format(self._templateKey, ctx=ctx)


class PersonalMissionsQuestAchievesFormatter(QuestAchievesFormatter):
    __eventsCache = dependency.descriptor(IEventsCache)

    @classmethod
    def _processTokens(cls, data):
        quest = cls.__eventsCache.getPersonalMissions().getAllQuests().get(data.get(b'potapovQuestID'))
        if quest:
            result = []
            completionToken = PERSONAL_MISSION_TOKEN % (quest.getCampaignID(), quest.getOperationID())
            if completionToken in data.get(b'tokens', {}):
                bonuses = quest.getBonuses(b'tokens')
                if bonuses:
                    for b in bonuses:
                        if b.getName() == b'completionTokens' and completionToken in b.getTokens().keys():
                            tUserName = first(CompletionTokensBonusFormatter().format(b)).userName
                            result.append(g_settings.htmlTemplates.format(b'completionTokens', {b'completionToken': tUserName}))

            return (b', ').join(result)
        return b''


class LootBoxAchievesFormatter(QuestAchievesFormatter):

    @classmethod
    def _processTokens(cls, data):
        result = []
        for token in data.get(b'tokens', {}).iterkeys():
            tankmanTokenResult = _processTankmanToken(token)
            if tankmanTokenResult:
                result.append(tankmanTokenResult)

        return (b'\n').join(result)

    @classmethod
    def _extractAchievements(cls, data):
        return _getAchievementsFromQuestData(data)


class BattlePassQuestAchievesFormatter(QuestAchievesFormatter):
    __offersProvider = dependency.descriptor(IOffersDataProvider)
    _BULLET = b'• '
    _SEPARATOR = b'<br/>' + _BULLET

    @classmethod
    def formatQuestAchieves(cls, data, asBattleFormatter, processCustomizations=True, processTokens=True):
        result = super(BattlePassQuestAchievesFormatter, cls).formatQuestAchieves(data, asBattleFormatter, processCustomizations, processTokens)
        if result:
            return cls._BULLET + result
        return result

    @classmethod
    def _processTokens(cls, data):
        from gui.battle_pass.battle_pass_helpers import getOfferTokenByGift
        result = []
        styleTokens = []
        rewardChoiceTokens = {}
        for token, tokenData in data.get(b'tokens', {}).iteritems():
            if token.startswith(BATTLE_PASS_CHOICE_REWARD_OFFER_GIFT_TOKENS):
                offer = cls.__offersProvider.getOfferByToken(getOfferTokenByGift(token))
                if offer is not None:
                    gift = first(offer.getAllGifts())
                    giftType = token.split(b':')[2]
                    rewardChoiceTokens.setdefault(giftType, 0)
                    rewardChoiceTokens[giftType] += gift.giftCount * tokenData.get(b'count', 1)
            elif token.startswith(BATTLE_PASS_TOKEN_3D_STYLE):
                styleTokens.append(token)
            else:
                tankmanTokenResult = _processTankmanToken(token)
                if tankmanTokenResult:
                    result.append(tankmanTokenResult)

        result.extend(cls.__processStyleTokens(styleTokens))
        result.extend(cls.__processRewardChoiceTokens(rewardChoiceTokens))
        return cls._SEPARATOR.join(result)

    @classmethod
    def _extractAchievements(cls, data):
        return _getAchievementsFromQuestData(data)

    @classmethod
    def __processStyleTokens(cls, tokens):
        tokens.sort(key=lambda x: (int(x.split(b':')[(-2)]), int(x.split(b':')[(-1)])))
        return [ cls.__getFormattedStyleProgress(token) for token in tokens ]

    @classmethod
    def __processRewardChoiceTokens(cls, tokens):
        result = []
        rewardSelectTemplate = b'battlePassRewardSelectToken'
        rChosenBonuses = R.strings.battle_pass.chosenBonuses.bonus
        for rewardType, count in tokens.iteritems():
            result.append(g_settings.htmlTemplates.format(rewardSelectTemplate, {b'text': backport.text(rChosenBonuses.dyn(rewardType)()), b'count': count}))

        return result

    @classmethod
    def __getFormattedStyleProgress(cls, token):
        from gui.battle_pass.battle_pass_helpers import getStyleForChapter
        chapter = int(token.split(b':')[3])
        level = int(token.split(b':')[4])
        style = getStyleForChapter(chapter)
        text = backport.text(R.strings.battle_pass.styleProgressBonus(), styleName=style.userName, level=int2roman(level))
        return g_settings.htmlTemplates.format(b'battlePassStyleProgressToken', {b'text': text})


class CollectionsFormatter(QuestAchievesFormatter):
    __BULLET = b'• '

    @classmethod
    def formatQuestAchieves(cls, rewards, asBattleFormatter, processCustomizations=True, processTokens=True):
        collectionEntitlements = popCollectionEntitlements(rewards)
        collectionItems = cls.__formatItems(_getCollectionItemName(entitlementName) for entitlementName in collectionEntitlements.iterkeys() if entitlementName.startswith(COLLECTION_ITEM_PREFIX_NAME))
        ordinaryItems = super(CollectionsFormatter, cls).formatQuestAchieves(rewards, asBattleFormatter, processCustomizations, processTokens)
        if ordinaryItems is not None:
            ordinaryItemsNames = ordinaryItems.split(cls._SEPARATOR)
            ordinaryItems = cls.__formatItems(ordinaryItemsNames)
        return cls._SEPARATOR.join((collectionItems or b'', ordinaryItems or b''))

    @classmethod
    def __formatItems(cls, items):
        if items:
            return cls._SEPARATOR.join((b'{} {}').format(cls.__BULLET, itemName) for itemName in items)
        return b''


class BattleMattersQuestAchievesFormatter(QuestAchievesFormatter):
    __battleMattersController = dependency.descriptor(IBattleMattersController)

    @classmethod
    def _processTokens(cls, tokens):
        if cls.isWithSelectableReward(tokens):
            return text_styles.stats(backport.text(R.strings.messenger.serviceChannelMessages.battleMatters.token()))
        return b''

    @classmethod
    def isWithSelectableReward(cls, awardsDict):
        if b'tokens' not in awardsDict:
            return False
        else:
            mainTokenID = cls.__battleMattersController.getDelayedRewardToken()
            isWithSelectableReward = awardsDict[b'tokens'].pop(mainTokenID, None) is not None
            if not awardsDict[b'tokens']:
                awardsDict.pop(b'tokens')
            return isWithSelectableReward


class Comp7QualificationRewardsFormatter(QuestAchievesFormatter):
    _BULLET = b'• '
    _SEPARATOR = b'<br/>' + _BULLET

    @classmethod
    def formatQuestAchieves(cls, data, asBattleFormatter, processCustomizations=True, processTokens=True):
        result = super(Comp7QualificationRewardsFormatter, cls).formatQuestAchieves(data, asBattleFormatter, processCustomizations, processTokens)
        if result:
            return cls._BULLET + result
        return result


class _GoodyFormatter(WaitItemsSyncFormatter):
    __goodiesCache = dependency.descriptor(IGoodiesCache)
    _VARIETY_TO_TEMPLATE = {}

    @staticmethod
    def getBoosterAdditionalParams(message):
        obtainedValue = message.data.get(b'obtainedValues', {})
        resourceRows = []
        for bonusTypeName, value in obtainedValue.iteritems():
            resourceRows.append(g_settings.htmlTemplates.format(b'boosterExpiredRow', ctx={b'resourceName': html.escape(backport.text(R.strings.messenger.serviceChannelMessages.boosterExpiredResourceName.dyn(bonusTypeName)())), 
               b'value': html.escape(str(value))}))

        if resourceRows:
            resourceRows.append(g_settings.htmlTemplates.format(b'boosterExpiredAdditionalRow'))
        return {b'boostersInformation': (b'').join(resourceRows)}

    @adisp_async
    @adisp_process
    def format(self, message, callback):
        yield lambda callback: callback(True)
        isSynced = yield self._waitForSyncItems()
        if message.data and isSynced:
            gid = message.data.get(b'gid')
            additionalParams = {}
            goodieDescr = self.__goodiesCache.getGoodieByID(gid)
            if goodieDescr.variety == GOODIE_VARIETY.DISCOUNT:
                goodie = self.__goodiesCache.getDiscount(gid)
            elif goodieDescr.variety == GOODIE_VARIETY.BOOSTER:
                goodie = self.__goodiesCache.getBooster(gid)
                additionalParams = self.getBoosterAdditionalParams(message)
            elif goodieDescr.variety == GOODIE_VARIETY.RECERTIFICATION_FORM:
                goodie = self.__goodiesCache.getRecertificationForm(gid)
            else:
                goodie = self.__goodiesCache.getDemountKit(gid)
            if goodie:
                templateName = self._getTemplateName(goodieDescr.variety)
                if templateName:
                    ctx = {b'boosterName': goodie.userName}
                    if additionalParams:
                        ctx.update(additionalParams)
                    formatted = g_settings.msgTemplates.format(templateName, ctx=ctx)
                    callback([MessageData(formatted, self._getGuiSettings(message, templateName))])
                    return
            callback([MessageData(None, None)])
        else:
            callback([MessageData(None, None)])
        return

    def canBeEmpty(self):
        return True

    def _getTemplateName(self, goodieType):
        return self._VARIETY_TO_TEMPLATE.get(goodieType)


class GoodyRemovedFormatter(_GoodyFormatter):
    _VARIETY_TO_TEMPLATE = {GOODIE_VARIETY.BOOSTER: b'boosterExpired'}


class GoodyDisabledFormatter(_GoodyFormatter):
    _VARIETY_TO_TEMPLATE = {GOODIE_VARIETY.DEMOUNT_KIT: b'demountKitDisabled', 
       GOODIE_VARIETY.BOOSTER: b'boosterDisabled'}


class GoodieEnabledFormatter(_GoodyFormatter):
    _VARIETY_TO_TEMPLATE = {GOODIE_VARIETY.DEMOUNT_KIT: b'demountKitEnabled'}


class TelecomStatusFormatter(WaitItemsSyncFormatter):
    __itemsCache = dependency.descriptor(IItemsCache)
    __lobbyContext = dependency.descriptor(ILobbyContext)

    @adisp_async
    @adisp_process
    def format(self, message, callback):
        isSynced = yield self._waitForSyncItems()
        formatted, settings = (None, None)
        if isSynced:
            try:
                template = b'telecomVehicleStatus'
                ctx = self.__getMessageContext(message.data)
                settings = self._getGuiSettings(message, template)
                formatted = g_settings.msgTemplates.format(template, ctx, data={b'timestamp': time.time()})
            except Exception:
                _logger.error(b"Can't format telecom status message %s", message)
                _logger.exception(b'TelecomStatusFormatter catches exception')

        messageData = MessageData(formatted, settings)
        callback([messageData])
        return

    @staticmethod
    def __addProviderToRes(res, provider):
        return res.dyn(provider, res.default)

    def __getMessageContext(self, data):
        key = b'vehicleUnblocked' if data[b'orderStatus'] else b'vehicleBlocked'
        vehTypeDescrs = data[b'vehTypeCompDescrs']
        provider = b''
        if vehTypeDescrs:
            bundleId = data[b'bundleID']
            telecomConfig = self.__lobbyContext.getServerSettings().telecomConfig
            provider = telecomConfig.getInternetProvider(bundleId)
        providerLocName = b''
        if provider:
            providerLocRes = R.strings.menu.internet_provider.dyn(provider)
            providerLocName = backport.text(providerLocRes.name()) if providerLocRes else b''
        msgctx = {b'vehicles': self.__getVehicleUserNames(vehTypeDescrs), b'provider': providerLocName}
        ctx = {}
        resShortcut = R.strings.system_messages.telecom
        for txtBlock in ('title', 'comment', 'subcomment'):
            ctx[txtBlock] = backport.text(self.__addProviderToRes(resShortcut.notifications.dyn(key).dyn(txtBlock), provider)(), **msgctx)

        return ctx

    @classmethod
    def __getVehicleUserNames(cls, vehTypeCompDescrs):
        itemGetter = cls._itemsCache.items.getItemByCD
        return (b', ').join(itemGetter(vehicleCD).userName for vehicleCD in vehTypeCompDescrs)


class TelecomReceivedInvoiceFormatter(InvoiceReceivedFormatter):
    __itemsCache = dependency.descriptor(IItemsCache)
    __lobbyContext = dependency.descriptor(ILobbyContext)

    @staticmethod
    def invoiceHasCrew(data):
        dataEx = data.get(b'data', {})
        hasCrew = False
        vehicles = dataEx.get(b'vehicles', {})
        for vehicle in vehicles:
            if vehicles[vehicle].get(b'tankmen', None):
                hasCrew = True

        return hasCrew

    @staticmethod
    def invoiceHasBrotherhood(data):
        dataEx = data.get(b'data', {})
        hasBrotherhood = False
        vehicles = dataEx.get(b'vehicles', {})
        for vehicle in vehicles:
            tankmens = vehicles[vehicle].get(b'tankmen', [])
            for tman in tankmens:
                if isinstance(tman, str):
                    tankmanDecsr = tankmen.TankmanDescr(compactDescr=tman)
                    if b'brotherhood' in tankmanDecsr.freeSkills:
                        hasBrotherhood = True
                        break
                elif b'brotherhood' in tman.get(b'freeSkills', []):
                    hasBrotherhood = True
                    break

        return hasBrotherhood

    @staticmethod
    def _addProviderToRes(res, provider):
        return res.dyn(provider, res.default)

    def _getProvider(self, data):
        telecomConfig = self.__lobbyContext.getServerSettings().telecomConfig
        return telecomConfig.getInternetProvider(data[b'bundleID'])

    @classmethod
    def _isValidCD(cls, vehCompDescr):
        return vehCompDescr > 0

    def _getVehicles(self, data):
        dataEx = data.get(b'data', {})
        if not dataEx:
            return
        else:
            vehicles = [
             dataEx.get(b'vehicles', {})]
            rentedVehNames = None
            if vehicles:
                _, _, rentedVehNames = self._getVehicleNames(vehicles)
            return rentedVehNames

    def _getMessageTemplateKey(self, emitterID, assetType):
        return b'telecomVehicleReceived'

    def _getMessageContext(self, data, vehicleNames):
        msgctx = {}
        hasCrew = self.invoiceHasCrew(data)
        if hasCrew:
            if self.invoiceHasBrotherhood(data):
                skills = b' (%s)' % backport.text(R.strings.crew_perks.brotherhood.name())
            else:
                skills = b''
            msgctx[b'crew'] = backport.text(self._addProviderToRes(R.strings.system_messages.telecom.notifications.vehicleReceived.crew, self._getProvider(data)), skills=skills)
        else:
            msgctx[b'crew'] = b''
        msgctx[b'vehicles'] = (b', ').join(vehicleNames)
        msgctx[b'datetime'] = self._getOperationTimeString(data)
        ctx = {}
        resShortcut = R.strings.system_messages.telecom.notifications.vehicleReceived
        for txtBlock in ('title', 'comment', 'subcomment'):
            ctx[txtBlock] = backport.text(self._addProviderToRes(resShortcut.dyn(txtBlock), self._getProvider(data))(), **msgctx)

        return ctx

    def _formatData(self, emitterID, assetType, data):
        vehicleNames = self._getVehicles(data)
        if not vehicleNames:
            return None
        else:
            return g_settings.msgTemplates.format(self._getMessageTemplateKey(emitterID, assetType), ctx=self._getMessageContext(data, vehicleNames), data={b'timestamp': time.time()})


class TelecomRemovedInvoiceFormatter(TelecomReceivedInvoiceFormatter):

    @classmethod
    def _isValidCD(cls, vehCompDescr):
        return vehCompDescr < 0

    def _getMessageTemplateKey(self, emitterID, assetType):
        return b'telecomVehicleRemoved'

    def _getVehicles(self, data):
        dataEx = data.get(b'data', {})
        if not dataEx:
            return
        else:
            vehicles = [
             dataEx.get(b'vehicles', {})]
            removedVehNames = None
            if vehicles:
                _, removedVehNames, _ = self._getVehicleNames(vehicles)
            return removedVehNames

    def _getMessageContext(self, data, vehicleNames):
        provider = self._getProvider(data)
        providerLocTariff = b''
        if provider != b'':
            providerLocRes = R.strings.menu.internet_provider.dyn(provider)
            providerLocTariff = backport.text(providerLocRes.tariff()) if providerLocRes else b''
        msgctx = {b'vehicles': (b', ').join(vehicleNames), b'datetime': self._getOperationTimeString(data), 
           b'tariff': providerLocTariff}
        ctx = {}
        resShortcut = R.strings.system_messages.telecom.notifications.vehicleRemoved
        for txtBlock in ('title', 'comment', 'subcomment'):
            ctx[txtBlock] = backport.text(self._addProviderToRes(resShortcut.dyn(txtBlock), provider)(), **msgctx)

        return ctx


class PrbVehicleKickFormatter(ServiceChannelFormatter):
    __itemsCache = dependency.descriptor(IItemsCache)
    typeKick = b'prbVehicleKick'

    def format(self, message, *args):
        formatted = None
        data = message.data
        vehInvID = data.get(b'vehInvID', None)
        self.__itemsCache.items.getVehicle(vehInvID)
        if vehInvID:
            vehicle = self.__itemsCache.items.getVehicle(vehInvID)
            if vehicle:
                formatted = g_settings.msgTemplates.format(self.typeKick, ctx={b'vehName': vehicle.userName})
        return [MessageData(formatted, self._getGuiSettings(message, self.typeKick))]


class PrbVehicleKickFilterFormatter(PrbVehicleKickFormatter):
    typeKick = b'prbVehicleKickFilter'


class PrbVehicleMaxSpgKickFormatter(ServiceChannelFormatter):
    __itemsCache = dependency.descriptor(IItemsCache)

    def format(self, message, *args):
        formatted = None
        data = message.data
        vehInvID = data.get(b'vehInvID', None)
        if vehInvID:
            vehicle = self.__itemsCache.items.getVehicle(vehInvID)
            if vehicle:
                formatted = g_settings.msgTemplates.format(b'prbVehicleMaxSpgKick', ctx={b'vehName': vehicle.userName})
        return [MessageData(formatted, self._getGuiSettings(message, b'prbVehicleMaxSpgKick'))]


class PrbVehicleMaxScoutKickFormatter(ServiceChannelFormatter):
    __itemsCache = dependency.descriptor(IItemsCache)

    def format(self, message, *args):
        formatted = None
        data = message.data
        vehInvID = data.get(b'vehInvID', None)
        if vehInvID:
            vehicle = self.__itemsCache.items.getVehicle(vehInvID)
            if vehicle:
                formatted = g_settings.msgTemplates.format(b'prbVehicleMaxScoutKick', ctx={b'vehName': vehicle.userName})
        return [MessageData(formatted, self._getGuiSettings(message, b'prbVehicleMaxScoutKick'))]


class RotationGroupLockFormatter(ServiceChannelFormatter):

    def format(self, message, *args):
        templateKey = self._getMessageTemplateKey()
        if isinstance(message.data, list):
            groups = (b', ').join(map(str, message.data))
        else:
            groups = message.data
        formatted = g_settings.msgTemplates.format(templateKey, ctx={b'groupNum': groups})
        return [
         MessageData(formatted, self._getGuiSettings(message, templateKey))]

    def _getMessageTemplateKey(self):
        return b'RotationGroupLock'


class RotationGroupUnlockFormatter(RotationGroupLockFormatter):

    def _getMessageTemplateKey(self):
        return b'RotationGroupUnlock'


class RankedQuestAchievesFormatter(QuestAchievesFormatter):
    __rankAwardsFormatters = tuple((currency, getBWFormatter(currency)) for currency in Currency.ALL)
    __offersDP = dependency.descriptor(IOffersDataProvider)
    __awardsStyles = {Currency.CREDITS: text_styles.credits, 
       Currency.GOLD: text_styles.gold, 
       Currency.CRYSTAL: text_styles.crystal, 
       Currency.EVENT_COIN: text_styles.eventCoin, 
       Currency.BPCOIN: text_styles.bpcoin}

    def packRankAwards(self, awardsDict):
        result = [
         self._processTokens(awardsDict)]
        result.extend(self.packAwards(awardsDict, self.__rankAwardsFormatters))
        otherStr = self.formatQuestAchieves(awardsDict, asBattleFormatter=False)
        if otherStr:
            result.append(otherStr)
        return EOL.join(result)

    def packAwards(self, awardsDict, formattersList):
        result = []
        for awardName, extractor in formattersList:
            award = None
            if awardName in awardsDict:
                award = awardsDict.pop(awardName)
            if award is not None:
                value = extractor(award)
                if value and value != b'0':
                    result.append(self.__packAward(awardName, value))

        return result

    @classmethod
    def _processTokens(cls, awardsDict):
        processedTokens = []
        processedTokenIDs = []
        tokens = awardsDict.get(b'tokens', {})
        if tokens:
            for tokenID, tokenData in tokens.iteritems():
                count = backport.getIntegralFormat(tokenData.get(b'count', 1))
                if tokenID.startswith(YEAR_AWARD_SELECTABLE_OPT_DEVICE_PREFIX):
                    bonusType = tokenID.split(b':')[2]
                    processedTokens.append(backport.text(R.strings.system_messages.ranked.notifications.dyn(bonusType)(), selectableRewardCount=text_styles.stats(count)))
                    processedTokenIDs.append(tokenID)

            for tokenID in processedTokenIDs:
                awardsDict[b'tokens'].pop(tokenID, None)

        return EOL.join(processedTokens)

    @classmethod
    def __getYearPointsAmount(cls, awardsDict):
        return awardsDict.get(b'tokens', {}).get(YEAR_POINTS_TOKEN, {}).get(b'count', 0)

    @classmethod
    def __getSelectableAwardCount(cls, awardsDict):
        awardMainTokenID = YEAR_AWARD_SELECTABLE_OPT_DEVICE_PREFIX
        result = 0
        for tokenID in awardsDict.get(b'tokens', {}):
            if tokenID.startswith(awardMainTokenID):
                result += int(tokenID.split(b':')[(-1)])

        return result

    def __packAward(self, key, value):
        return (b'{} {}').format(backport.text(R.strings.system_messages.ranked.notifications.bonusName.dyn(key)()), self.__awardsStyles.get(key, text_styles.stats)(value))


class BRQuestsFormatter(TokenQuestsFormatter):
    __eventsCache = dependency.descriptor(IEventsCache)

    @adisp_async
    @adisp_process
    def format(self, message, callback):
        isSynced = yield self._waitForSyncItems()
        if isSynced:
            completedQuestIDs = message.data.get(b'completedQuestIDs', set())
            messages = self.__formatEveryLevel(completedQuestIDs, message.data.copy())
            callback([ MessageData(formattedMessage, self._getGuiSettings(message)) for formattedMessage in messages ])
        else:
            callback([MessageData(None, self._getGuiSettings(message))])
        return

    def __formatEveryLevel(self, completedQuestIDs, data):
        formattedMessage = None
        formattedLevels = {}
        quests = self.__eventsCache.getHiddenQuests()
        for questID in completedQuestIDs:
            quest = quests.get(questID)
            if quest is not None:
                levelID = self.__getLevel(quest)
                textID = R.strings.system_messages.royale.notifications.singleLevel.text()
                formattedLevels[levelID] = backport.text(textID, level=levelID)

        if formattedLevels:
            formattedMessage = g_settings.msgTemplates.format(b'BrLevelQuest', ctx={b'levelsBlock': EOL.join([ formattedLevels[key] for key in sorted(formattedLevels) ]), 
               b'awardsBlock': self._packTitleAwards(data)})
        return [
         formattedMessage]

    def _packTitleAwards(self, awardsDict):
        return self._achievesFormatter.formatQuestAchieves(awardsDict, asBattleFormatter=False) or b''

    @classmethod
    def __getLevel(cls, quest):
        return str(quest.getID().split(b':')[(-1)])


class RankedQuestFormatter(WaitItemsSyncFormatter):
    __eventsCache = dependency.descriptor(IEventsCache)
    __rankedController = dependency.descriptor(IRankedBattlesController)

    def __init__(self):
        super(RankedQuestFormatter, self).__init__()
        self.__achievesFormatter = RankedQuestAchievesFormatter()

    @adisp_async
    @adisp_process
    def format(self, message, callback=None):
        isSynced = yield self._waitForSyncItems()
        if isSynced:
            completedQuestIDs = message.data.get(b'completedQuestIDs', set())
            messages = self.__formatRankedQuests(completedQuestIDs, message.data.copy())
            callback([ MessageData(formattedMessage, self._getGuiSettings(message)) for formattedMessage in messages ])
        else:
            callback([MessageData(None, self._getGuiSettings(message))])
        return

    def __formatRankedQuests(self, completedQuestIDs, data):
        formattedMessage = None
        formattedRanks = {}
        quests = self.__eventsCache.getHiddenQuests()
        qualificationBattles = 0
        for questID in completedQuestIDs:
            quest = quests.get(questID)
            if quest is not None and quest.isForRank():
                rankID = quest.getRank()
                division = self.__rankedController.getDivision(rankID)
                textID = R.strings.system_messages.ranked.notifications.singleRank.text()
                if division.isQualification():
                    if isQualificationQuestID(questID):
                        textID = R.strings.ranked_battles.awards.gotQualificationQuest()
                        qualificationBattles = getQualificationBattlesCountFromID(questID)
                    else:
                        textID = R.strings.system_messages.ranked.notifications.qualificationFinish()
                formattedRanks[rankID] = backport.text(textID, rankName=division.getRankUserName(rankID), divisionName=division.getUserName(), count=qualificationBattles)

        if formattedRanks:
            formattedMessage = g_settings.msgTemplates.format(b'rankedRankQuest', ctx={b'ranksBlock': EOL.join([ formattedRanks[key] for key in sorted(formattedRanks) ]), 
               b'awardsBlock': self.__achievesFormatter.packRankAwards(data)})
        return [
         formattedMessage]


class PersonalMissionFailedFormatter(WaitItemsSyncFormatter):
    _eventsCache = dependency.descriptor(IEventsCache)
    _template = b'PersonalMissionFailedMessage'

    @adisp_async
    @adisp_process
    def format(self, message, callback=None):
        isSynced = yield self._waitForSyncItems()
        if message.data and isSynced:
            data = message.data
            potapovQuestIDs = data.get(b'questIDs')
            if potapovQuestIDs:
                questsDict = {}
                for questID in potapovQuestIDs:
                    if questID and personal_missions.g_cache.isPersonalMission(questID):
                        pmType = personal_missions.g_cache.questByUniqueQuestID(questID)
                        quest = self._eventsCache.getPersonalMissions().getAllQuests().get(pmType.id)
                        questsDict.setdefault(pmType.id, [])
                        questsDict[pmType.id].append(quest)

                for questID, questList in questsDict.iteritems():
                    quest = first(questList)
                    operation = self._eventsCache.getPersonalMissions().getAllOperations().get(quest.getOperationID())
                    ctx = {b'questID': questID, 
                       b'operation': operation.getShortUserName(), 
                       b'missionShortName': quest.getShortUserName(), 
                       b'missionName': quest.getUserName()}
                    formatted = g_settings.msgTemplates.format(self._template, ctx=ctx, data={b'savedData': {b'questID': questID}})
                    settings = self._getGuiSettings(message, self._template, messageType=message.type)
                    settings.showAt = BigWorld.time()
                    callback([MessageData(formatted, settings)])

            else:
                callback([MessageData(None, None)])
        else:
            callback([MessageData(None, None)])
        return


class CustomizationChangedFormatter(WaitItemsSyncFormatter):
    _template = b'CustomizationRemoved'

    @adisp_async
    @adisp_process
    def format(self, message, callback=None):
        from gui.customization.shared import SEASON_TYPE_TO_NAME, SEASONS_ORDER
        isSynced = yield self._waitForSyncItems()
        if message.data and isSynced:
            data = message.data
            vehicleIntCD = first(data)
            vehicleData = data[vehicleIntCD]
            vehicle = self._itemsCache.items.getItemByCD(vehicleIntCD)
            data = {b'savedData': {b'vehicleIntCD': vehicleIntCD}}
            text = backport.text(R.strings.messenger.serviceChannelMessages.sysMsg.removeCustomizations(), vehicle=vehicle.userName)
            seasonTexts = {}
            for season, seasonData in vehicleData.iteritems():
                items = []
                for itemIntCD, count in seasonData.iteritems():
                    item = self._itemsCache.items.getItemByCD(itemIntCD)
                    formattedItem = backport.text(R.strings.messenger.serviceChannelMessages.sysMsg.customizations.item(), itemType=item.userType, itemName=item.userName, count=count)
                    items.append(formattedItem)

                if items:
                    seasonName = SEASON_TYPE_TO_NAME.get(season)
                    formattedSeason = backport.text(R.strings.messenger.serviceChannelMessages.sysMsg.customizations.map.dyn(seasonName)()) + (b', ').join(items) + b'.'
                    seasonTexts[season] = b'\n' + formattedSeason

            for season in SEASONS_ORDER:
                if season in seasonTexts:
                    text += seasonTexts[season]

            formatted = g_settings.msgTemplates.format(self._template, {b'text': text}, data=data)
            settings = self._getGuiSettings(message, self._template, messageType=message.type)
            settings.showAt = BigWorld.time()
            callback([MessageData(formatted, settings)])
        else:
            callback([MessageData(None, None)])
        return


class LootBoxAutoOpenFormatter(WaitItemsSyncFormatter):
    __MESSAGE_TEMPLATE = b'LootBoxRewardsSysMessage'

    def __init__(self, subFormatters=()):
        super(LootBoxAutoOpenFormatter, self).__init__()
        self._achievesFormatter = LootBoxAchievesFormatter()
        self.__subFormatters = subFormatters

    @adisp_async
    @adisp_process
    def format(self, message, callback):
        isSynced = yield self._waitForSyncItems()
        messageDataList = []
        if isSynced and message.data:
            openedBoxesIDs = set(message.data.keys())
            for subFormatter in self.__subFormatters:
                subBoxesIDs = subFormatter.getBoxesOfThisGroup(openedBoxesIDs)
                if subBoxesIDs:
                    if subFormatter.isAsync():
                        result = yield subFormatter.format(message)
                    else:
                        result = subFormatter.format(message)
                    if result:
                        messageDataList.extend(result)
                    openedBoxesIDs.difference_update(subBoxesIDs)

            if openedBoxesIDs:
                messageData = self.__formatSimpleBoxes(message, openedBoxesIDs)
                if messageData is not None:
                    messageDataList.append(messageData)
        if messageDataList:
            callback(messageDataList)
            return
        else:
            callback([MessageData(None, None)])
            return

    def __formatSimpleBoxes(self, message, openedBoxesIDs):
        data = message.data
        openedBoxesIDs.difference_update({b'rewards', b'boxIDs'})
        oldRewards, _ = data.pop(b'rewards', {}), data.pop(b'boxIDs', None)
        allRewards = getMergedBonusesFromDicts([ data[bID][b'rewards'] for bID in openedBoxesIDs ] + [oldRewards])
        fmt = self._achievesFormatter.formatQuestAchieves(allRewards, asBattleFormatter=False, processTokens=False)
        formattedRewards = g_settings.msgTemplates.format(self.__MESSAGE_TEMPLATE, ctx={b'text': fmt})
        settingsRewards = self._getGuiSettings(message, self.__MESSAGE_TEMPLATE)
        settingsRewards.showAt = BigWorld.time()
        return MessageData(formattedRewards, settingsRewards)


class ProgressiveRewardFormatter(WaitItemsSyncFormatter):
    _template = b'ProgressiveRewardMessage'

    @adisp_async
    @adisp_process
    def format(self, message, callback=None):
        isSynced = yield self._waitForSyncItems()
        if message.data and isSynced:
            data = message.data
            if b'rewards' in data and b'level' in data:
                fmt = QuestAchievesFormatter.formatQuestAchieves(data[b'rewards'], False)
                if fmt:
                    formatted = g_settings.msgTemplates.format(self._template, ctx={b'text': fmt})
                    settings = self._getGuiSettings(message, self._template)
                    settings.showAt = BigWorld.time()
                    callback([MessageData(formatted, settings)])
                else:
                    callback([MessageData(None, None)])
            else:
                callback([MessageData(None, None)])
        else:
            callback([MessageData(None, None)])
        return


class PiggyBankSmashedFormatter(ServiceChannelFormatter):
    _piggyBankTemplate = b'PiggyBankSmashedMessage'
    _piggyBankWotPlusTemplate = b'PiggyBankWotPlusSmashedMessage'
    _goldReserveTemplate = b'GoldReserveSmashedMessage'
    _currenciesTemplate = b'CurrenciesReservesSmashedMessage'
    __wotPlusController = dependency.descriptor(IWotPlusController)

    def format(self, message, *args):
        if not message.data:
            return []
        credits_ = message.data.get(b'credits')
        gold = message.data.get(b'gold')
        if self.__wotPlusController.isWotPlusEnabled():
            piggyBankTemplate = self._piggyBankWotPlusTemplate
        else:
            piggyBankTemplate = self._piggyBankTemplate
        if credits_ and not gold:
            ctx = {b'credits': backport.getIntegralFormat(credits_)}
            formatted = g_settings.msgTemplates.format(piggyBankTemplate, ctx)
            return [
             MessageData(formatted, self._getGuiSettings(message, piggyBankTemplate))]
        if gold and not credits_:
            ctx = {b'gold': backport.getGoldFormat(gold)}
            formatted = g_settings.msgTemplates.format(self._goldReserveTemplate, ctx)
            return [
             MessageData(formatted, self._getGuiSettings(message, self._goldReserveTemplate))]
        if gold and credits_:
            ctx = {b'credits': backport.getIntegralFormat(credits_), b'gold': backport.getGoldFormat(gold)}
            formatted = g_settings.msgTemplates.format(self._currenciesTemplate, ctx)
            return [
             MessageData(formatted, self._getGuiSettings(message, self._currenciesTemplate))]
        return []


class BlackMapRemovedFormatter(ServiceChannelFormatter):
    __TEMPLATE = b'BlackMapRemovedMessage'
    __REASONS_SETTINGS = {MapRemovedFromBLReason.MAP_DISABLED: {b'text': R.strings.messenger.serviceChannelMessages.blackMapRemoved.mapDisabled(), 
                                             b'priority': NC_MESSAGE_PRIORITY.MEDIUM}, 
       MapRemovedFromBLReason.SLOT_DISABLED: {b'text': R.strings.messenger.serviceChannelMessages.blackMapRemoved.slotDisabled(), 
                                              b'priority': NC_MESSAGE_PRIORITY.LOW}}

    def format(self, message, *args):
        if message.data:
            mapIDs = message.data.get(b'mapIDs')
            reason = message.data.get(b'reason')
            if mapIDs is None or reason not in self.__REASONS_SETTINGS:
                return [MessageData(None, None)]
            mapNames = []
            for mapID in mapIDs:
                if mapID in ArenaType.g_cache:
                    mapNames.append(i18n.makeString(ArenaType.g_cache[mapID].name))

            settings = self.__REASONS_SETTINGS[reason]
            text = backport.text(settings[b'text'], mapNames=(b',').join(mapNames))
            formatted = g_settings.msgTemplates.format(self.__TEMPLATE, {b'text': text})
            guiSettings = self._getGuiSettings(message, self.__TEMPLATE, priorityLevel=settings[b'priority'])
            return [
             MessageData(formatted, guiSettings)]
        else:
            return [
             MessageData(None, None)]


class EnhancementRemovedFormatter(ServiceChannelFormatter):
    __TEMPLATE = b'EnhancementRemovedMessage'

    def format(self, message, *args):
        if message.data:
            text = backport.text(R.strings.messenger.serviceChannelMessages.enhancements.removed())
            formatted = g_settings.msgTemplates.format(self.__TEMPLATE, {b'text': text})
            guiSettings = self._getGuiSettings(message, self.__TEMPLATE, priorityLevel=NC_MESSAGE_PRIORITY.MEDIUM)
            return [
             MessageData(formatted, guiSettings)]
        else:
            return [
             MessageData(None, None)]


class EnhancementsWipedFormatter(ServiceChannelFormatter):
    __TEMPLATE = b'EnhancementsWipedMessage'

    def format(self, message, *args):
        if message.data:
            text = backport.text(R.strings.messenger.serviceChannelMessages.enhancements.wiped())
            formatted = g_settings.msgTemplates.format(self.__TEMPLATE, {b'text': text})
            guiSettings = self._getGuiSettings(message, self.__TEMPLATE, priorityLevel=NC_MESSAGE_PRIORITY.MEDIUM)
            return [
             MessageData(formatted, guiSettings)]
        else:
            return [
             MessageData(None, None)]


class EnhancementsWipedOnVehiclesFormatter(ServiceChannelFormatter):
    __TEMPLATE = b'EnhancementsWipedOnVehiclesMessage'

    def format(self, message, *args):
        if message.data:
            vehCompDescriptors = message.data.get(b'vehicles', set())
            vehNames = [ getUserName(vehicles_core.getVehicleType(vehCD)) for vehCD in vehCompDescriptors ]
            vehNames = (b', ').join(vehNames)
            text = backport.text(R.strings.messenger.serviceChannelMessages.enhancements.wipedOnVehicles())
            formatted = g_settings.msgTemplates.format(self.__TEMPLATE, {b'text': text, b'vehicleNames': vehNames})
            guiSettings = self._getGuiSettings(message, self.__TEMPLATE, priorityLevel=NC_MESSAGE_PRIORITY.MEDIUM)
            return [
             MessageData(formatted, guiSettings)]
        else:
            return [
             MessageData(None, None)]


class BattlePassRewardFormatter(WaitItemsSyncFormatter):
    __itemsCache = dependency.descriptor(IItemsCache)
    __battlePass = dependency.descriptor(IBattlePassController)
    __collections = dependency.descriptor(ICollectionsSystemController)
    __REWARD_TEMPLATE = b'BattlePassRewardSysMessage'
    __COLLECTION_ITEMS_TEMPLATE = b'CollectionItemsSysMessage'
    __PROGRESSION_BUTTON_TEMPLATE = b'BattlePassRewardWithProgressionButtonMessage'
    __SHOP_BUTTON_TEMPLATE = b'BattlePassRewardWithShopButtonMessage'
    __RESOURCE_AVAILABLE_TEMPLATE = b'BattlePassResourceChapterAvailableMessage'
    __CURRENCY_TEMPLATE_KEY = b'battlePassCurrency'

    @adisp_async
    @adisp_process
    def format(self, message, callback=None):
        isSynced = yield self._waitForSyncItems()
        resultMessage = MessageData(None, None)
        collectionResultMessage = MessageData(None, None)
        messageResource = MessageData(None, None)
        if message.data and isSynced:
            data = message.data
            if b'reward' in data and b'ctx' in data:
                rewards = data.get(b'reward')
                ctx = data.get(b'ctx')
                reason = ctx.get(b'reason')
                newLevel = ctx.get(b'newLevel')
                chapterID = ctx.get(b'chapter')
                collectionEntitlements = popCollectionEntitlements(rewards)
                description = b''
                additionalText = b''
                template = self.__REWARD_TEMPLATE
                header = backport.text(R.strings.messenger.serviceChannelMessages.battlePassReward.header.default())
                priorityLevel = None
                savedData = None
                if reason in (BattlePassRewardReason.PURCHASE_BATTLE_PASS, BattlePassRewardReason.GIFT_CHAPTER):
                    if not rewards:
                        callback([])
                    header, description, priorityLevel, additionalText = self.__makeAfterBattlePassPurchase(ctx)
                else:
                    if reason == BattlePassRewardReason.PURCHASE_BATTLE_PASS_MULTIPLE:
                        callback([])
                        return
                    if reason == BattlePassRewardReason.PURCHASE_BATTLE_PASS_LEVELS:
                        header, description, priorityLevel, additionalText = self.__makeAfterLevelsPurchase(ctx)
                    elif reason == BattlePassRewardReason.SELECT_CHAPTER:
                        if self.__battlePass.isCompleted() and self.__battlePass.isResourceCompleted():
                            description = backport.text(R.strings.messenger.serviceChannelMessages.battlePassReward.battle.final.text(), season=self.__battlePass.getSeasonNum())
                            template = self.__SHOP_BUTTON_TEMPLATE
                            additionalText = backport.text(R.strings.messenger.serviceChannelMessages.battlePassReward.battle.final.additionalText())
                        elif self.__battlePass.isFinalLevel(chapterID, newLevel):
                            chapterName = backport.text(R.strings.battle_pass.chapter.fullName.quoted.num(chapterID)())
                            battleText = R.strings.messenger.serviceChannelMessages.battlePassReward.battle
                            if self.__battlePass.isChapterExists(chapterID):
                                description = backport.text(battleText.chapterFinal.text(), chapter=text_styles.credits(chapterName))
                            else:
                                description = backport.text(battleText.chapterFinalNotFind.text())
                            template = self.__PROGRESSION_BUTTON_TEMPLATE
                            savedData = {b'chapterID': chapterID}
                        else:
                            description = backport.text(R.strings.messenger.serviceChannelMessages.battlePassReward.activateChapter.text())
                        priorityLevel = NotificationPriorityLevel.LOW
                    elif reason in (BattlePassRewardReason.INVOICE, BattlePassRewardReason.BATTLE):
                        description, template, priorityLevel, additionalText, savedData = self.__makeAfterBattle(ctx)
                formattedBonuses = BattlePassQuestAchievesFormatter.formatQuestAchieves(rewards, False)
                if formattedBonuses is None:
                    formattedBonuses = b''
                if formattedBonuses and additionalText:
                    additionalText = b'<br/>' + additionalText
                formatted = g_settings.msgTemplates.format(template, ctx={b'header': header, 
                   b'description': description, b'text': formattedBonuses, b'additionalText': additionalText}, data={b'savedData': savedData})
                settings = self._getGuiSettings(message, template, messageType=message.type)
                settings.showAt = BigWorld.time()
                if priorityLevel is not None:
                    settings.priorityLevel = priorityLevel
                resultMessage = MessageData(formatted, settings)
                if collectionEntitlements and self.__collections.isEnabled():
                    collectionResultMessage = self.__makeCollectionMessage(collectionEntitlements, message)
                if reason in (BattlePassRewardReason.PURCHASE_BATTLE_PASS_LEVELS, BattlePassRewardReason.INVOICE,
                 BattlePassRewardReason.BATTLE, BattlePassRewardReason.SELECT_CHAPTER) and self.__battlePass.isFinalLevel(chapterID, newLevel):
                    messageResource = self.__makeResourceChapterAvailableMessage(chapterID, message)
        callback([resultMessage, collectionResultMessage, messageResource])
        return

    def __makeAfterBattle(self, ctx):
        newLevel = ctx.get(b'newLevel')
        priorityLevel = None
        additionalText = b''
        chapterID = ctx.get(b'chapter')
        savedData = None
        if not (self.__battlePass.isCompleted() and self.__battlePass.isResourceCompleted()):
            chapterName = backport.text(R.strings.battle_pass.chapter.fullName.quoted.num(chapterID)())
            if not self.__battlePass.isFinalLevel(chapterID, newLevel):
                description = backport.text(R.strings.messenger.serviceChannelMessages.battlePassReward.battle.newLevel.text(), newLevel=text_styles.credits(newLevel), chapter=text_styles.credits(chapterName))
                priorityLevel = NotificationPriorityLevel.LOW
            elif self.__battlePass.isChapterExists(chapterID):
                description = backport.text(R.strings.messenger.serviceChannelMessages.battlePassReward.battle.chapterFinal.text(), chapter=text_styles.credits(chapterName))
            else:
                description = backport.text(R.strings.messenger.serviceChannelMessages.battlePassReward.battle.chapterFinalNotFind.text())
            template = self.__PROGRESSION_BUTTON_TEMPLATE
            savedData = {b'chapterID': chapterID}
        else:
            description = backport.text(R.strings.messenger.serviceChannelMessages.battlePassReward.battle.final.text(), season=self.__battlePass.getSeasonNum())
            priorityLevel = NotificationPriorityLevel.LOW
            template = self.__SHOP_BUTTON_TEMPLATE
            additionalText = backport.text(R.strings.messenger.serviceChannelMessages.battlePassReward.battle.final.additionalText())
        return (
         description, template, priorityLevel, additionalText, savedData)

    def __makeAfterLevelsPurchase(self, ctx):
        chapterID = ctx.get(b'chapter')
        currentLevel = ctx.get(b'newLevel')
        prevLevel = ctx.get(b'prevLevel')
        chapter = text_styles.credits(backport.text(R.strings.battle_pass.chapter.fullName.quoted.num(chapterID)()))
        header = backport.text(R.strings.messenger.serviceChannelMessages.battlePassReward.header.buyProgress())
        levelCount = currentLevel - prevLevel
        if self.__battlePass.isFinalLevel(chapterID, currentLevel):
            if self.__battlePass.isCompleted() and self.__battlePass.isResourceCompleted():
                description = backport.text(R.strings.messenger.serviceChannelMessages.battlePassReward.battle.final.text(), season=self.__battlePass.getSeasonNum())
            elif self.__battlePass.isChapterExists(chapterID):
                description = backport.text(R.strings.messenger.serviceChannelMessages.battlePassReward.battle.chapterFinal.text(), chapter=chapter)
            else:
                description = backport.text(R.strings.messenger.serviceChannelMessages.battlePassReward.battle.chapterFinalNotFind.text())
        else:
            level = currentLevel + 1
            chapter = text_styles.credits(backport.text(R.strings.battle_pass.chapter.fullName.num(chapterID)()))
            description = backport.text(R.strings.messenger.serviceChannelMessages.battlePassReward.buyProgress.text(), levelCount=text_styles.credits(levelCount), currentLevel=text_styles.credits(level), chapter=chapter)
        price = self.__itemsCache.items.shop.getBattlePassLevelCost().get(Currency.GOLD, 0) * levelCount
        additionalText = self.__makeCurrencyString(Currency.GOLD, price)
        priorityLevel = NotificationPriorityLevel.LOW
        return (
         header, description, priorityLevel, additionalText)

    def __makeAfterBattlePassPurchase(self, ctx):
        chapterID = ctx.get(b'chapter')
        priceID = ctx.get(b'priceID')
        reason = ctx.get(b'reason')
        if reason == BattlePassRewardReason.GIFT_CHAPTER:
            header = backport.text(R.strings.messenger.serviceChannelMessages.battlePassReward.header.questGiftBP())
        else:
            header = backport.text(R.strings.messenger.serviceChannelMessages.battlePassReward.header.buyBP())
        description = backport.text(R.strings.messenger.serviceChannelMessages.battlePassReward.buyWithRewards.text())
        additionalText = backport.text(R.strings.messenger.serviceChannelMessages.battlePassReward.buyWithRewards.additionalText(), chapter=text_styles.credits(backport.text(R.strings.battle_pass.chapter.fullName.quoted.num(chapterID)())))
        if reason != BattlePassRewardReason.GIFT_CHAPTER:
            additionalText += b'<br/>' + self.__makePriceString(chapterID, priceID)
        priorityLevel = NotificationPriorityLevel.LOW
        return (
         header, description, priorityLevel, additionalText)

    def __makePriceString(self, chapterID, priceID):
        return self.__makeCurrencyString(*next(self.__battlePass.getBattlePassCost(chapterID)[priceID].iteritems()))

    def __makeCurrencyString(self, currency, amount):
        if amount:
            return g_settings.htmlTemplates.format(self.__CURRENCY_TEMPLATE_KEY, {b'currency': backport.text(R.strings.messenger.serviceChannelMessages.battlePassReward.buy.dyn(currency)()), b'amount': getBWFormatter(currency)(amount)})
        return b''

    def __makeCollectionMessage(self, entitlements, message):
        from gui.collection.collections_helpers import getCollectionFullFeatureName
        messages = R.strings.collections.notifications
        collectionID = int(first(entitlements).split(b'_')[(-2)])
        collection = self.__collections.getCollection(collectionID)
        title = backport.text(messages.title.collectionName(), feature=getCollectionFullFeatureName(collection))
        text = backport.text(messages.newItemsReceived.text(), items=CollectionsFormatter.formatQuestAchieves({b'entitlements': entitlements}, False))
        formatted = g_settings.msgTemplates.format(self.__COLLECTION_ITEMS_TEMPLATE, ctx={b'title': title, b'text': text}, data={b'savedData': {b'collectionId': collectionID}})
        return MessageData(formatted, self._getGuiSettings(message, self.__COLLECTION_ITEMS_TEMPLATE, messageType=SYS_MESSAGE_TYPE.collectionsItems.index()))

    def __makeResourceChapterAvailableMessage(self, chapterID, message):
        resourceChID = self.__battlePass.getResourceChapterID()
        if not self.__battlePass.isMarathonChapter(chapterID) and self.__battlePass.isResourceChapterAvailable() and self.__battlePass.getChapterState(resourceChID) == ChapterState.NOT_STARTED:
            chapterName = backport.text(R.strings.battle_pass.chapter.fullName.quoted.num(resourceChID)())
            textRes = backport.text(R.strings.system_messages.battlePass.recourseChapterUnlock.body(), chapter=chapterName)
            header = backport.text(R.strings.system_messages.battlePass.recourseChapterUnlock.header(), chapter=chapterName)
            formatted = g_settings.msgTemplates.format(self.__RESOURCE_AVAILABLE_TEMPLATE, ctx={b'header': header, 
               b'text': textRes})
            settings = self._getGuiSettings(message, self.__RESOURCE_AVAILABLE_TEMPLATE)
            return MessageData(formatted, settings)


class BattlePassBoughtFormatter(WaitItemsSyncFormatter):

    @adisp_async
    @adisp_process
    def format(self, message, callback=None):
        isSynced = yield self._waitForSyncItems()
        resultMessage = MessageData(None, None)
        if message.data and isSynced and message.data.get(b'chapter') == 0:
            template = b'BattlePassBuyMultipleMessage'
            header = backport.text(R.strings.messenger.serviceChannelMessages.battlePassReward.buyMultiple.text())
            formatted = g_settings.msgTemplates.format(template, ctx={b'header': header})
            settings = self._getGuiSettings(message, template)
            settings.showAt = BigWorld.time()
            resultMessage = MessageData(formatted, settings)
        callback([resultMessage])
        return


class BattlePassGiftByOfferFormatter(WaitItemsSyncFormatter):
    __battlePass = dependency.descriptor(IBattlePassController)

    @adisp_async
    @adisp_process
    def format(self, message, callback=None):
        isSynced = yield self._waitForSyncItems()
        resultMessage = MessageData(None, None)
        if message.data and isSynced and self.__battlePass.isValidChapterID(message.data.get(b'chapter')):
            data = message.data
            chId = data.get(b'chapter')
            header = backport.text(R.strings.messenger.serviceChannelMessages.battlePassReward.header.questGiftBP())
            chapterName = backport.text(R.strings.battle_pass.chapter.fullName.quoted.num(chId)())
            text = backport.text(R.strings.messenger.serviceChannelMessages.battlePassReward.buyWithoutRewards.text(), chapter=text_styles.credits(chapterName))
            template = b'BattlePassDefaultRewardMessage'
            templateParams = {b'text': text, b'header': header}
            settings = self._getGuiSettings(message, template, priorityLevel=NotificationPriorityLevel.LOW)
            formatted = g_settings.msgTemplates.format(template, templateParams)
            resultMessage = MessageData(formatted, settings)
        callback([resultMessage])
        return


class BattlePassReachedCapFormatter(WaitItemsSyncFormatter):
    __itemsCache = dependency.descriptor(IItemsCache)
    __template = b'BattlePassReachedCapMessage'

    @adisp_async
    @adisp_process
    def format(self, message, callback=None):
        isSynced = yield self._waitForSyncItems()
        resultMessage = MessageData(None, None)
        if message.data and isSynced:
            data = message.data
            vehCD = data.get(b'vehTypeCompDescr')
            limitPoints = data.get(b'vehiclePoints')
            bonusPoints = data.get(b'bonusPoints')
            if vehCD and limitPoints and bonusPoints:
                text = backport.text(R.strings.messenger.serviceChannelMessages.battlePass.reachedCap.text(), vehName=self.__itemsCache.items.getItemByCD(vehCD).userName, bonusPoints=text_styles.neutral(bonusPoints))
                formatted = g_settings.msgTemplates.format(self.__template, {b'text': text})
                resultMessage = MessageData(formatted, self._getGuiSettings(message, self.__template))
        callback([resultMessage])
        return


class BattlePassStyleReceivedFormatter(WaitItemsSyncFormatter):
    __itemsCache = dependency.descriptor(IItemsCache)
    __battlePass = dependency.descriptor(IBattlePassController)
    __template = b'BattlePassStyleReceivedMessage'

    @adisp_async
    @adisp_process
    def format(self, message, callback=None):
        isSynced = yield self._waitForSyncItems()
        resultMessage = MessageData(None, None)
        if message.data and isSynced:
            data = message.data
            rewardType = self.__battlePass.getRewardType(data.get(b'chapter'))
            text = b''
            if rewardType == FinalReward.STYLE:
                styleCD = data.get(b'styleCD')
                if styleCD is not None:
                    text = backport.text(R.strings.messenger.serviceChannelMessages.battlePass.styleChosen.text(), name=self.__itemsCache.items.getItemByCD(styleCD).userName)
            elif rewardType == FinalReward.TANKMAN:
                text = backport.text(R.strings.messenger.serviceChannelMessages.battlePass.tankmanChosen.text())
            if text:
                header = backport.text(R.strings.messenger.serviceChannelMessages.battlePass.styleChosen.header())
                formatted = g_settings.msgTemplates.format(self.__template, {b'header': header, b'text': text})
                resultMessage = MessageData(formatted, self._getGuiSettings(message, self.__template))
        callback([resultMessage])
        return


class BattlePassSeasonEndFormatter(WaitItemsSyncFormatter):
    __itemsCache = dependency.descriptor(IItemsCache)
    __template = b'BattlePassSeasonEndMessage'
    __rewardTemplate = b'battlePassDefaultRewardReceived'
    _BULLET = b'• '

    @adisp_async
    @adisp_process
    def format(self, message, callback=None):
        isSynced = yield self._waitForSyncItems()
        resultMessage = MessageData(None, None)
        if message.data and isSynced:
            data = message.data
            rewards = data.get(b'data')
            if rewards is not None:
                description = backport.text(R.strings.system_messages.battlePass.seasonEnd.text())
                text = []
                if b'customizations' in rewards:
                    text.extend(self.__formatCustomizationStrings(rewards[b'customizations']))
                if b'items' in rewards:
                    text.extend(self.__formatItemsStrings(rewards[b'items']))
                if b'blueprints' in rewards:
                    text.extend(self.__formatBlueprintsStrings(rewards[b'blueprints']))
                formatted = g_settings.msgTemplates.format(self.__template, {b'description': description, b'text': (b'<br>').join(text)})
                resultMessage = MessageData(formatted, self._getGuiSettings(message, self.__template))
        callback([resultMessage])
        return

    def __formatItemsStrings(self, items):
        rewardStrings = []
        for itemCD, count in items.iteritems():
            itemTypeID, _, _ = vehicles_core.parseIntCompactDescr(itemCD)
            if itemTypeID == I_T.optionalDevice:
                rewardStrings.append(self.__formatOptionalDeviceString(itemCD, count))
            elif itemTypeID == I_T.crewBook:
                rewardStrings.append(self.__formatCrewBookString(itemCD, count))

        return rewardStrings

    def __formatOptionalDeviceString(self, itemCD, count):
        item = self.__itemsCache.items.getItemByCD(itemCD)
        if item.isTrophy:
            textRes = R.strings.system_messages.battlePass.seasonEnd.rewards.trophy()
        elif item.isModernized:
            textRes = R.strings.system_messages.battlePass.seasonEnd.rewards.expequipment()
        else:
            textRes = R.strings.system_messages.battlePass.seasonEnd.rewards.device()
        text = backport.text(textRes, name=item.userName)
        text = self._BULLET + text
        return g_settings.htmlTemplates.format(self.__rewardTemplate, {b'text': text, b'count': count})

    def __formatCrewBookString(self, itemCD, count):
        item = self.__itemsCache.items.getItemByCD(itemCD)
        text = backport.text(R.strings.system_messages.battlePass.seasonEnd.rewards.crewBook(), name=item.userName)
        text = self._BULLET + text
        return g_settings.htmlTemplates.format(self.__rewardTemplate, {b'text': text, b'count': count})

    def __formatBlueprintsStrings(self, blueprints):
        rewardStrings = []
        for fragmentCD, count in blueprints.iteritems():
            nation = nations.NAMES[getFragmentNationID(fragmentCD)]
            nationName = backport.text(R.strings.nations.dyn(nation)())
            text = backport.text(R.strings.system_messages.battlePass.seasonEnd.rewards.blueprints(), name=nationName)
            text = self._BULLET + text
            rewardStrings.append(g_settings.htmlTemplates.format(self.__rewardTemplate, {b'text': text, b'count': count}))

        return rewardStrings

    def __formatCustomizationStrings(self, customizations):
        rewardStrings = []
        for item in customizations:
            guiItemType = item[b'custType']
            itemData = getCustomizationItemData(item[b'id'], guiItemType)
            typeRes = R.strings.system_messages.battlePass.seasonEnd.rewards.dyn(guiItemType)
            if typeRes.exists():
                text = backport.text(typeRes(), name=itemData.userName)
                text = self._BULLET + text
                rewardStrings.append(g_settings.htmlTemplates.format(b'battlePassDefaultStyleReceived', {b'text': text}))

        return rewardStrings


class EpicLevelUpFormatter(WaitItemsSyncFormatter):
    __itemsCache = dependency.descriptor(IItemsCache)
    __epicController = dependency.descriptor(IEpicBattleMetaGameController)
    __template = b'EpicLevelUpMessage'
    __iconPrefix = b'epicSysMsgLevel'
    __rewardTemplate = b'epicDefaultRewardReceived'
    __gotLevelTemplate = b'epicGotLevel'

    @adisp_async
    @adisp_process
    def format(self, message, callback=None):
        isSynced = yield self._waitForSyncItems()
        resultMessage = MessageData(None, None)
        if message.data and isSynced:
            battleResults = message.data
            sysMsgExtraData = battleResults.get(b'sysMsgExtraData')
            newLevel, _ = sysMsgExtraData.get(b'metaLevel')
            battleResults[b'epicAbilityPoints'] = sysMsgExtraData.get(b'epicAbilityPoints')
            icon = self.__iconPrefix + str(self._getLevelUpIconId(newLevel))
            title = backport.text(R.strings.system_messages.epicBattles.levelUp.title())
            levelCongrats = backport.text(R.strings.system_messages.epicBattles.levelUp.body.levelCongrats(), tier=newLevel)
            body = g_settings.htmlTemplates.format(self.__gotLevelTemplate, {b'levelCongrats': levelCongrats})
            awards = backport.text(R.strings.system_messages.epicBattles.levelUp.awards())
            achieves = EpicQuestAchievesFormatter.formatQuestAchieves(battleResults, False)
            formatted = g_settings.msgTemplates.format(self.__template, {b'title': title, b'body': body, b'awards': awards, b'achieves': achieves}, data={b'icon': icon, b'savedData': sysMsgExtraData})
            settings = self._getGuiSettings(message, self.__template)
            settings.showAt = BigWorld.time()
            resultMessage = MessageData(formatted, settings)
        callback([resultMessage])
        return

    @staticmethod
    def _getLevelUpIconId(level):
        if level is None:
            return 0
        else:
            for index, levelRange in enumerate(EPIC_BATTLE_LEVEL_IMAGE_INDEX):
                if level in levelRange:
                    return index

            return


class EpicQuestAchievesFormatter(QuestAchievesFormatter):
    __offersProvider = dependency.descriptor(IOffersDataProvider)
    __itemsCache = dependency.descriptor(IItemsCache)
    __goodiesCache = dependency.descriptor(IGoodiesCache)
    _SEPARATOR = b'<br>'
    __rEpicReward = R.strings.messenger.serviceChannelMessages.epicReward
    __rewardTemplate = b'epicLevelUpReward'

    @classmethod
    def formatQuestAchieves(cls, data, asBattleFormatter, processCustomizations=True, processTokens=True):
        result = []
        battlePassPointsResult = cls.__processBattlePassPoints(data)
        if battlePassPointsResult:
            result.append(battlePassPointsResult)
        abilityPointsResult = cls.__processAbilityPoints(data)
        if abilityPointsResult:
            result.append(abilityPointsResult)
        crystalResult = cls.__processCrystal(data)
        if crystalResult:
            result.append(crystalResult)
        tokenResult = cls._processTokens(data)
        if tokenResult and processTokens:
            result.append(tokenResult)
        recertificationFormResult = cls.__processRecertificationForm(data)
        if recertificationFormResult:
            result.append(recertificationFormResult)
        crewBookResult = cls.__processCrewBook(data)
        if crewBookResult:
            result.append(crewBookResult)
        return cls._SEPARATOR.join(result)

    @classmethod
    def __processCrewBook(cls, data):
        items = data.get(b'items', {})
        for itemCD, count in items.iteritems():
            itemTypeID, _, _ = vehicles_core.parseIntCompactDescr(itemCD)
            if itemTypeID == I_T.crewBook:
                if count > 0:
                    return cls.__makeQuestsAchieve(cls.__rewardTemplate, text=backport.text(cls.__rEpicReward.brochure_gift()), count=count)

    @classmethod
    def __processRecertificationForm(cls, data):
        goodies = data.get(b'goodies', {})
        count = 0
        for goodieID, ginfo in goodies.iteritems():
            if goodieID in cls.__itemsCache.items.shop.recertificationForms:
                recertificationForm = cls.__goodiesCache.getRecertificationForm(goodieID)
                if recertificationForm is not None and recertificationForm.enabled:
                    count += ginfo.get(b'count')

        if count > 0:
            return cls.__makeQuestsAchieve(cls.__rewardTemplate, text=backport.text(cls.__rEpicReward.recertificationForm_gift()), count=count)
        else:
            return

    @classmethod
    def __processCrystal(cls, data):
        crystal = data.get(Currency.CRYSTAL, 0)
        if crystal:
            return cls.__makeQuestsAchieve(cls.__rewardTemplate, text=backport.text(cls.__rEpicReward.crystal()), count=crystal)

    @classmethod
    def __processBattlePassPoints(cls, data):
        value = sum(points for points in data.get(b'battlePassPoints', {}).get(b'vehicles', {}).itervalues())
        if value > 0:
            return cls.__makeQuestsAchieve(cls.__rewardTemplate, text=backport.text(cls.__rEpicReward.battlePassPoints()), count=value)

    @classmethod
    def __processAbilityPoints(cls, data):
        value = data.get(b'epicAbilityPoints', 0)
        if value > 0:
            return cls.__makeQuestsAchieve(cls.__rewardTemplate, text=backport.text(cls.__rEpicReward.epicAbilityPoints()), count=value)

    @classmethod
    def _processTokens(cls, data):
        from gui.battle_pass.battle_pass_helpers import getOfferTokenByGift
        result = []
        rewardChoiceTokens = {}
        for token, tokenData in data.get(b'tokens', {}).iteritems():
            from epic_constants import EPIC_OFFER_TOKEN_PREFIX
            if token.startswith(EPIC_OFFER_TOKEN_PREFIX):
                offer = cls.__offersProvider.getOfferByToken(getOfferTokenByGift(token))
                if offer is None:
                    LOG_ERROR((b'Offer for {} token not found').format(token))
                else:
                    gift = first(offer.getAllGifts())
                    giftType = token.split(b':')[2]
                    rewardChoiceTokens.setdefault(giftType, 0)
                    rewardChoiceTokens[giftType] += gift.giftCount * tokenData.get(b'count', 1)

        result.extend(cls.__processRewardChoiceTokens(rewardChoiceTokens))
        return cls._SEPARATOR.join(result)

    @classmethod
    def __processRewardChoiceTokens(cls, tokens):
        result = []
        rBonuses = R.strings.messenger.serviceChannelMessages.epicReward
        for rewardType, count in tokens.iteritems():
            result.append(g_settings.htmlTemplates.format(cls.__rewardTemplate, {b'text': backport.text(rBonuses.dyn(rewardType)()), b'count': count}))

        return result

    @classmethod
    def __makeQuestsAchieve(cls, key, **kwargs):
        return g_settings.htmlTemplates.format(key, kwargs)


class EpicSeasonEndFormatter(WaitItemsSyncFormatter):
    __itemsCache = dependency.descriptor(IItemsCache)
    __template = b'EpicSeasonEndMessage'
    __rewardTemplate = b'epicDefaultRewardReceived'

    @adisp_async
    @adisp_process
    def format(self, message, callback=None):
        isSynced = yield self._waitForSyncItems()
        resultMessage = MessageData(None, None)
        if message.data and isSynced:
            data = message.data
            rewards = data.get(b'data')
            if rewards is not None:
                description = backport.text(R.strings.system_messages.epicBattles.seasonEnd.text())
                title = backport.text(R.strings.system_messages.epicBattles.seasonEnd.title())
                text = []
                if b'items' in rewards:
                    text.extend(self.__formatItemsStrings(rewards[b'items']))
                formatted = g_settings.msgTemplates.format(self.__template, {b'title': title, b'description': description, b'text': (b'<br>').join(text)})
                resultMessage = MessageData(formatted, self._getGuiSettings(message, self.__template))
        callback([resultMessage])
        return

    def __formatItemsStrings(self, items):
        rewardStrings = []
        for itemCD, count in items.iteritems():
            itemTypeID, _, _ = vehicles_core.parseIntCompactDescr(itemCD)
            if itemTypeID == I_T.crewBook:
                rewardStrings.append(self.__formatCrewBookString(itemCD, count))
            elif itemTypeID in (I_T.equipment, I_T.optionalDevice):
                rewardStrings.append(self.__formatRewardChoiceTokenString(itemCD, count, itemTypeID))

        return rewardStrings

    def __formatRewardChoiceTokenString(self, itemCD, count, itemTypeID):
        typeName = ITEM_TYPE_NAMES[itemTypeID]
        item = self.__itemsCache.items.getItemByCD(itemCD)
        textRes = R.strings.system_messages.epicBattles.seasonEnd.rewards.dyn(typeName)()
        text = backport.text(textRes, name=item.userName)
        return g_settings.htmlTemplates.format(self.__rewardTemplate, {b'text': text, b'count': count})

    def __formatCrewBookString(self, itemCD, count):
        item = self.__itemsCache.items.getItemByCD(itemCD)
        text = backport.text(R.strings.system_messages.epicBattles.seasonEnd.rewards.crewBook(), name=item.userName)
        return g_settings.htmlTemplates.format(self.__rewardTemplate, {b'text': text, b'count': count})


class BattlePassFreePointsUsedFormatter(ServiceChannelFormatter):
    __template = b'BattlePassFreePointsUsedMessage'
    __battlePassController = dependency.descriptor(IBattlePassController)

    def format(self, message, *args):
        resultMessage = MessageData(None, None)
        if message.data:
            data = message.data
            chapterID = data.get(b'chapter')
            pointsDiff = data.get(b'diffPoints')
            if not (chapterID is None or pointsDiff is None):
                header = backport.text(R.strings.messenger.serviceChannelMessages.battlePass.freePointsUsed.header())
                chapterName = backport.text(R.strings.battle_pass.chapter.fullName.quoted.num(chapterID)())
                text = backport.text(R.strings.messenger.serviceChannelMessages.battlePass.freePointsUsed.text(), chapter=text_styles.credits(chapterName), points=pointsDiff)
                formatted = g_settings.msgTemplates.format(self.__template, {b'header': header, b'text': text})
                resultMessage = MessageData(formatted, self._getGuiSettings(message, self.__template))
        return [
         resultMessage]


class CollectibleVehiclesUnlockedFormatter(ServiceChannelFormatter):
    __TEMPLATE = b'UnlockedCollectibleVehiclesMessage'

    def format(self, message, *args):
        data = message.data
        if data:
            nationID = data.get(b'nationID')
            level = data.get(b'level')
            if nationID is not None and nationID < len(NAMES):
                formatted = g_settings.msgTemplates.format(self.__TEMPLATE, {b'header': backport.text(R.strings.messenger.serviceChannelMessages.vehicleCollector.unlockLevel.header()), 
                   b'text': backport.text(R.strings.messenger.serviceChannelMessages.vehicleCollector.unlockLevel.text(), level=int2roman(level), nation=backport.text(R.strings.nations.dyn(NAMES[nationID]).genetiveCase()))})
                return [
                 MessageData(formatted, self._getGuiSettings(message, self.__TEMPLATE))]
        return [
         MessageData(None, None)]


class TechTreeActionDiscountFormatter(ServiceChannelFormatter):
    __template = b'TechTreeActionDiscountMessage'

    def format(self, message, *args):
        actionName = message.get(b'actionName', None)
        timeLeft = message.get(b'timeLeft', None)
        single = message.get(b'single', True)
        textKey = R.strings.system_messages.techtree.action.text
        if actionName is not None and timeLeft is not None:
            formatted = g_settings.msgTemplates.format(self.__template, {b'header': backport.text(R.strings.system_messages.techtree.action.header(), actionName=actionName), 
               b'text': backport.text(textKey() if single else textKey.closest()), 
               b'timeLeft': getTillTimeByResource(timeLeft, R.strings.menu.Time.timeLeftShort, useRoundUp=True)})
            return [
             MessageData(formatted, self._getGuiSettings(message, self.__template))]
        else:
            return [
             MessageData(None, None)]


class BlueprintsConvertSaleFormatter(ServiceChannelFormatter):
    __templates = {BCSActionState.STARTED: b'BlueprintsConvertSaleStartMessage', 
       BCSActionState.PAUSED: b'BlueprintsConvertSalePauseMessage', 
       BCSActionState.RESTORE: b'BlueprintsConvertSaleRestoreMessage', 
       BCSActionState.END: b'BlueprintsConvertSaleEndMessage'}

    def format(self, message, *args):
        actionName = message.get(b'state', None)
        if actionName is not None and actionName in self.__templates:
            formatted = g_settings.msgTemplates.format(self.__templates[actionName], {b'header': backport.text(R.strings.messenger.serviceChannelMessages.blueprintsConvertSale.header()), 
               b'text': backport.text(R.strings.messenger.serviceChannelMessages.blueprintsConvertSale.dyn(actionName.value)()), 
               b'button': backport.text(R.strings.messenger.serviceChannelMessages.blueprintsConvertSale.button())})
            return [
             MessageData(formatted, self._getGuiSettings(message, self.__templates[actionName]))]
        else:
            return [
             MessageData(None, None)]


class CustomizationProgressFormatter(WaitItemsSyncFormatter):
    itemsCache = dependency.descriptor(IItemsCache)

    @adisp_async
    @adisp_process
    def format(self, message, callback):
        from gui.customization.shared import checkIsFirstProgressionDecalOnVehicle
        priorityLevel = NotificationPriorityLevel.MEDIUM
        isSynced = yield self._waitForSyncItems()
        if isSynced and message.data:
            messageData = []
            for vehicleCD, items in message.data.iteritems():
                vehicleName = self.itemsCache.items.getItemByCD(vehicleCD).shortUserName if vehicleCD != UNBOUND_VEH_KEY else b''
                isFirst = checkIsFirstProgressionDecalOnVehicle(vehicleCD, items.keys())
                for itemCD, level in items.iteritems():
                    itemName = self.itemsCache.items.getItemByCD(itemCD).userName
                    text = self.__getMessageText(itemName, level, vehicleName)
                    if vehicleName:
                        template = b'ProgressiveItemUpdatedMessage'
                        ctx = {b'text': text}
                    else:
                        template = b'notificationsCenterMessage_1'
                        ctx = {b'topic': b'', b'body': text}
                    data = {b'savedData': {b'itemIntCD': itemCD, 
                                      b'vehicleIntCD': vehicleCD, 
                                      b'toProjectionDecals': True}}
                    guiSettings = self._getGuiSettings(message, template, priorityLevel=priorityLevel, messageType=message.type)
                    formatted = g_settings.msgTemplates.format(template, ctx, data=data)
                    messageData.append(MessageData(formatted, guiSettings))

                if isFirst:
                    text = backport.text(R.strings.messenger.serviceChannelMessages.sysMsg.customizationProgress.editStyleUnlocked(), vehicleName=vehicleName)
                    ctx = {b'text': text}
                    template = b'ProgressiveItemUpdatedMessage'
                    data = {b'savedData': {b'vehicleIntCD': vehicleCD, 
                                      b'toStyle': True}}
                    guiSettings = self._getGuiSettings(message, template, priorityLevel=priorityLevel, messageType=message.type)
                    formatted = g_settings.msgTemplates.format(template, ctx, data=data)
                    messageData.append(MessageData(formatted, guiSettings))

            callback(messageData)
        else:
            callback([MessageData(None, None)])
        return

    @staticmethod
    def __getMessageText(itemName, level, vehicleName=b''):
        text = b''
        if vehicleName:
            if level == 1:
                text = backport.text(R.strings.messenger.serviceChannelMessages.sysMsg.customizationProgress.itemReceived(), itemName=itemName, vehicleName=vehicleName)
            elif level > 1:
                text = backport.text(R.strings.messenger.serviceChannelMessages.sysMsg.customizationProgress.itemUpdated(), level=level, itemName=itemName, vehicleName=vehicleName)
        elif level == 1:
            text = backport.text(R.strings.messenger.serviceChannelMessages.sysMsg.customizationProgress.itemReceivedNotAutoBound(), itemName=itemName)
        elif level > 1:
            text = backport.text(R.strings.messenger.serviceChannelMessages.sysMsg.customizationProgress.itemUpdatedNotAutoBound(), level=level, itemName=itemName)
        return text


class CustomizationProgressionChangedFormatter(WaitItemsSyncFormatter):
    REQUIRED_KEYS = {
     b'custType', b'id', b'prevLevel', b'actualLevel'}

    @adisp_async
    @adisp_process
    def format(self, message, callback=None):
        result = [MessageData(None, None)]
        isSynced = yield self._waitForSyncItems()
        if isSynced and message.data and self.REQUIRED_KEYS == set(message.data.keys()):
            data = message.data
            guiItemType, itemUserName, _ = getCustomizationItemData(data[b'id'], data[b'custType'])
            prevLevel = data[b'prevLevel']
            actualLevel = data[b'actualLevel']
            if actualLevel == 0:
                callback(result)
                return
            if actualLevel > prevLevel:
                operation = b'up'
            elif actualLevel < prevLevel:
                operation = b'down'
            else:
                callback(result)
                return
            messageR = R.strings.system_messages.customization.progression.dyn(operation).dyn(guiItemType)
            if messageR.exists():
                messageString = backport.text(messageR(), itemUserName, int2roman(actualLevel))
            else:
                _logger.warning(b"CustomizationProgressionChangedFormatter doesn't have message for custType: %s", guiItemType)
                callback(result)
                return
            formatted = g_settings.msgTemplates.format(b'CustomizationProgressionMessage', ctx={b'message': messageString})
            result = [
             MessageData(formatted, self._getGuiSettings(message))]
        callback(result)
        return


class PrbEventEnqueueDataFormatter(ServiceChannelFormatter):
    __itemsCache = dependency.descriptor(IItemsCache)

    def format(self, message, *args):
        formatted = g_settings.msgTemplates.format(b'prbWrongEnqueueDataKick', ctx={})
        return [MessageData(formatted, self._getGuiSettings(message, b'prbWrongEnqueueDataKick'))]


class DogTagFormatter(ServiceChannelFormatter):

    @cached_property
    def serviceMessageSource(self):
        return R.strings.messenger.serviceChannelMessages.dogTags

    @cached_property
    def viewTypes(self):
        viewTypeSource = {ComponentViewType.ENGRAVING: self.serviceMessageSource.viewType.engraving(), ComponentViewType.BACKGROUND: self.serviceMessageSource.viewType.background()}
        return viewTypeSource

    def getViewTypeText(self, viewType):
        return backport.text(self.viewTypes[viewType])


class DogTagComponentUnlockFormatter(DogTagFormatter):

    def format(self, message, *args):
        if not message:
            return []
        title = backport.text(self.serviceMessageSource.unlockMessage.title())
        lines = []
        composer = dogTagComposer
        for data in message.data:
            component = componentConfigAdapter.getComponentById(int(data))
            viewTypeText = self.getViewTypeText(component.viewType)
            name = composer.getComponentTitle(component.componentId) or b'No name'
            lines.append((b'{} "{}"').format(viewTypeText, name))

        messageString = (b'<br/>').join(lines)
        ctx = {b'title': title, b'message': messageString}
        templateKey = b'DogTagComponentUnlockMessage'
        formatted = g_settings.msgTemplates.format(templateKey, ctx=ctx)
        return [MessageData(formatted, self._getGuiSettings(message))]


class DogTagComponentGradingFormatter(DogTagFormatter):
    grades = {0: b'I', 1: b'II', 
       2: b'III', 
       3: b'IV', 
       4: b'V', 
       5: b'VI', 
       6: b'VII', 
       7: b'VIII', 
       8: b'IX', 
       9: b'X', 
       10: b'XI', 
       11: b'XII', 
       12: b'XIII', 
       13: b'XIV', 
       14: b'XV'}

    def format(self, message, *args):
        if not message:
            return []
        title = backport.text(self.serviceMessageSource.gradingMessage.title())
        lines = []
        composer = dogTagComposer
        for data in message.data:
            compId, grade = data
            component = componentConfigAdapter.getComponentById(int(compId))
            viewTypeText = self.getViewTypeText(component.viewType)
            name = composer.getComponentTitle(component.componentId) or b'No name'
            levelUpToText = backport.text(self.serviceMessageSource.gradingMessage.levelUpToText())
            gradingText = self.grades.get(int(grade), b'No Data')
            lines.append((b'{viewTypeText} "{name}" {levelUpToText} {gradingText}').format(viewTypeText=viewTypeText, name=name, levelUpToText=levelUpToText, gradingText=gradingText))

        messageString = (b'<br/>').join(lines)
        ctx = {b'title': title, b'message': messageString}
        templateKey = b'DogTagComponentGradingMessage'
        formatted = g_settings.msgTemplates.format(templateKey, ctx=ctx)
        return [MessageData(formatted, self._getGuiSettings(message))]


class DedicationRewardFormatter(ServiceChannelFormatter):
    _template = b'DedicationRewardMessage'

    @classmethod
    def _getCountOfCustomizations(cls, rewards):
        customizations = rewards.get(b'customizations', [])
        totalCount = 0
        for customizationItem in customizations:
            totalCount += customizationItem[b'value']

        return totalCount

    def format(self, message, *args):
        result = [
         MessageData(None, None)]
        if message.data:
            data = message.data
            if b'ctx' in data and b'rewards' in data:
                ctx = data[b'ctx']
                rewards = data[b'rewards']
                battleCount = ctx.get(b'reason', 0)
                medalName = _getAchievementsFromQuestData(rewards)
                decalsCount = self._getCountOfCustomizations(rewards)
                if battleCount and medalName and decalsCount:
                    text = backport.text(R.strings.messenger.serviceChannelMessages.dedicationReward.text(), battlesCount=battleCount, medalName=medalName[0], decalsCount=decalsCount)
                    formatted = g_settings.msgTemplates.format(self._template, {b'text': text})
                    result = [
                     MessageData(formatted, self._getGuiSettings(message, self._template))]
        return result


class MapboxStartedFormatter(ServiceChannelFormatter):
    __TEMPLATE = b'MapboxStartedMessage'

    def format(self, message, *args):
        formatted = g_settings.msgTemplates.format(self.__TEMPLATE)
        return [MessageData(formatted, self._getGuiSettings(message, self.__TEMPLATE))]


class MapboxEndedFormatter(ServiceChannelFormatter):
    __TEMPLATE = b'Mapbox{}Message'
    __REWARDS_LEFT_MSG = b'Ended'
    __NO_REWARDS_LEFT_MSG = b'EndedNoRewards'

    def format(self, message, *args):
        rewards = message.get(b'rewards')
        if rewards is not None:
            template = self.__TEMPLATE.format(self.__REWARDS_LEFT_MSG)
            resultRewards = {}
            mergeRewards(resultRewards, {reward[b'name']:reward[b'value'] for reward in rewards})
            formatted = g_settings.msgTemplates.format(template, {b'header': backport.text(R.strings.messenger.serviceChannelMessages.mapbox.congrats.title()), 
               b'text': backport.text(R.strings.messenger.serviceChannelMessages.mapbox.eventEnded.text()), 
               b'achieves': QuestAchievesFormatter.formatQuestAchieves(resultRewards, False)})
        else:
            template = self.__TEMPLATE.format(self.__NO_REWARDS_LEFT_MSG)
            formatted = g_settings.msgTemplates.format(template)
        return [MessageData(formatted, self._getGuiSettings(message, template))]


class BattleMattersTokenAward(ServiceChannelFormatter):
    __TEMPLATE = b'BattleMattersTokenAward'

    def format(self, message, *args):
        achievesFormatter = BattleMattersQuestAchievesFormatter()
        achieves = achievesFormatter.formatQuestAchieves(message, asBattleFormatter=False)
        formatted = g_settings.msgTemplates.format(self.__TEMPLATE, {b'achieves': achieves})
        settings = self._getGuiSettings(message, self.__TEMPLATE)
        return [MessageData(formatted, settings)]


class MapboxSurveyAvailableFormatter(ServiceChannelFormatter):
    __TEMPLATE = b'MapboxSurveyAvailableMessage'
    __STR_PATH = R.strings.messenger.serviceChannelMessages.mapbox

    def format(self, message, *args):
        if not message:
            return [MessageData(None, None)]
        else:
            mapName = message.get(b'map')
            header = backport.text(self.__STR_PATH.surveyAvailable.header())
            if mapName in ArenaType.g_geometryNamesToIDs:
                arenaType = ArenaType.g_cache[ArenaType.g_geometryNamesToIDs[mapName]]
                text = backport.text(self.__STR_PATH.surveyAvailable.singleMap(), mapName=arenaType.name)
            else:
                text = backport.text(self.__STR_PATH.surveyAvailable.allMaps())
            formatted = g_settings.msgTemplates.format(self.__TEMPLATE, {b'header': header, 
               b'text': text}, data={b'savedData': mapName})
            return [
             MessageData(formatted, self._getGuiSettings(message, self.__TEMPLATE, messageSubtype=message.get(b'msgType')))]


class MapboxRewardReceivedFormatter(ServiceChannelFormatter):
    __mapboxCtrl = dependency.descriptor(IMapboxController)
    __TEMPLATE = b'MapboxRewardReceivedMessage'
    __STR_PATH = R.strings.messenger.serviceChannelMessages.mapbox

    def format(self, message, *args):
        rewards = message.get(b'rewards')
        if rewards is None:
            return [MessageData(None, None)]
        else:
            resultRewards = {}
            textItems = []
            battles = message.get(b'battles')
            if battles is not None:
                textItems.append(backport.text(self.__STR_PATH.progressionStageCompleted(), battles=battles))
            isFinal = message.get(b'isFinal', False) and battles is not None
            if isFinal:
                textItems.append(backport.text(self.__STR_PATH.progressionFinalRewardReceived()))
            else:
                textItems.append(backport.text(self.__STR_PATH.rewardReceived()))
            rewards = {item[b'name']:item[b'value'] for item in formatMapboxRewards(rewards)}
            mergeRewards(resultRewards, rewards)
            textItems.append(LootBoxAchievesFormatter.formatQuestAchieves(resultRewards, False))
            formatted = g_settings.msgTemplates.format(self.__TEMPLATE, {b'header': backport.text(self.__STR_PATH.congrats.title()), 
               b'text': (b'<br>').join(textItems)}, data={b'savedData': {b'rewards': rewards, b'battles': battles}})
            return [
             MessageData(formatted, self._getGuiSettings(message, self.__TEMPLATE, messageSubtype=message.get(b'msgType')))]


class TelecomMergeResultsFormatter(WaitItemsSyncFormatter):
    __TEMPLATE = b'telecomMergeResultsMessage'

    @adisp_async
    @adisp_process
    def format(self, message, callback=None):
        isSynced = yield self._waitForSyncItems()
        data = message.data
        if data and isSynced:
            debitedVehIDs = data.get(b'debitedVehIDs')
            mergedVehID = data.get(b'mergedVehID')
            crewVehIDs = data.get(b'crewVehIDs')
            creditsCompens = data.get(b'creditsCompens')
            xpCompens = data.get(b'xpCompens')
            goldCompens = data.get(b'goldCompens')
            textItems = []
            if mergedVehID:
                mergedVehName = getUserName(vehicles_core.getVehicleType(mergedVehID))
                if debitedVehIDs:
                    debitedVehNames = [ getUserName(vehicles_core.getVehicleType(vehCD)) for vehCD in debitedVehIDs ]
                    debitedVehNamesStr = backport.text(R.strings.system_messages.telecomMergeResults.body.listSeparator()).join(debitedVehNames)
                    textItems.append(backport.text(R.strings.system_messages.telecomMergeResults.body.accrualMsg(), tanks=debitedVehNamesStr))
                    if len(debitedVehIDs) == 1:
                        textItems.append(backport.text(R.strings.system_messages.telecomMergeResults.body.equipAndStatisticMovedMsg(), mergedTank=mergedVehName))
                    else:
                        textItems.append(backport.text(R.strings.system_messages.telecomMergeResults.body.statisticMovedMsg(), mergedTank=mergedVehName))
                        textItems.append(backport.text(R.strings.system_messages.telecomMergeResults.body.demountMsg()))
                    textItems.append(backport.text(R.strings.system_messages.telecomMergeResults.body.battleQuestsMsg()))
                else:
                    textItems.append(backport.text(R.strings.system_messages.telecomMergeResults.body.statisticMovedMsg(), mergedTank=mergedVehName))
                textItems.append(backport.text(R.strings.system_messages.telecomMergeResults.body.tankXPMsg()))
            if crewVehIDs:
                crewVehNames = [ getUserName(vehicles_core.getVehicleType(vehCD)) for vehCD in crewVehIDs ]
                crewVehNamesStr = backport.text(R.strings.system_messages.telecomMergeResults.body.listSeparator()).join(crewVehNames)
                textItems.append(backport.text(R.strings.system_messages.telecomMergeResults.body.crewRetrainingMsg(), tanks=crewVehNamesStr))
            if creditsCompens or xpCompens:
                compensationList = []
                if xpCompens:
                    compensationList.append(backport.text(R.strings.system_messages.telecomMergeResults.body.freeXP(), value=text_styles.expText(backport.getIntegralFormat(xpCompens))))
                if creditsCompens:
                    compensationList.append(backport.text(R.strings.system_messages.telecomMergeResults.body.credits(), value=text_styles.credits(backport.getIntegralFormat(creditsCompens))))
                compensationStr = backport.text(R.strings.system_messages.telecomMergeResults.body.conjunction()).join(compensationList)
                textItems.append(backport.text(R.strings.system_messages.telecomMergeResults.body.postprogressionMsg(), compensation=compensationStr))
            if goldCompens:
                textItems.append(backport.text(R.strings.system_messages.telecomMergeResults.body.progressDecalesCompens(), value=goldCompens))
            textItems.append(backport.text(R.strings.system_messages.telecomMergeResults.body.wishMsg()))
            formatted = g_settings.msgTemplates.format(self.__TEMPLATE, {b'text': (b'<br>').join(textItems)})
            callback([MessageData(formatted, self._getGuiSettings(message, self.__TEMPLATE))])
        else:
            callback([MessageData(None, None)])
        return


class RecertificationResetUsedFormatter(ServiceChannelFormatter):
    __TEMPLATE = b'RecertificationResetUsedSysMessage'
    __messageData = {b'blanks': {b'priority': NotificationPriorityLevel.LOW, 
                   b'header': R.strings.recertification_form.serviceChannelMessages.Reset.header(), 
                   b'currency': R.strings.recertification_form.serviceChannelMessages.currencyBlanks(), 
                   b'icon': b'RecertificationIcon'}}

    def format(self, message, *args):
        if not message:
            return [MessageData(None, None)]
        else:
            data = message.data
            currencyType = data.get(b'currencyType')
            messageData = self.__messageData.get(currencyType, {})
            if not messageData:
                return [MessageData(None, None)]
            textItems = [backport.text(R.strings.recertification_form.serviceChannelMessages.Reset.body()),
             backport.text(R.strings.recertification_form.serviceChannelMessages.ResetUsed.body(), currency=backport.text(messageData[b'currency']), count=getNiceNumberFormat(data.get(b'count')))]
            formatted = g_settings.msgTemplates.format(self.__TEMPLATE, {b'header': backport.text(messageData[b'header']), 
               b'text': (b'<br>').join(textItems)}, data={b'icon': messageData[b'icon'], 
               b'savedData': data})
            return [
             MessageData(formatted, self._getGuiSettings(message, self.__TEMPLATE, priorityLevel=messageData[b'priority']))]


class RecertificationResetFormatter(ServiceChannelFormatter):
    __TEMPLATE = b'RecertificationInformationSysMessage'

    def format(self, message, *args):
        if not message:
            return [MessageData(None, None)]
        else:
            text = backport.text(R.strings.recertification_form.serviceChannelMessages.Reset.body())
            formatted = g_settings.msgTemplates.format(self.__TEMPLATE, {b'text': text})
            return [
             MessageData(formatted, self._getGuiSettings(message, self.__TEMPLATE))]


class RecertificationAvailabilityFormatter(ServiceChannelFormatter):
    __messageData = {SwitchState.INACTIVE.value: {b'template': b'RecertificationAvailabilityOffSysMessage', 
                                    b'header': R.strings.recertification_form.serviceChannelMessages.Availability.error()}, 
       SwitchState.ENABLED.value: {b'template': b'RecertificationAvailabilityOnSysMessage', 
                                   b'header': None}}

    def format(self, message, *args):
        if not message:
            return [MessageData(None, None)]
        else:
            data = message.data
            state = data.get(b'state')
            messageData = self.__messageData.get(state, {})
            if not messageData:
                return [MessageData(None, None)]
            text = backport.text(R.strings.recertification_form.serviceChannelMessages.Availability.dyn(state)())
            header = messageData[b'header']
            template = messageData[b'template']
            formatted = g_settings.msgTemplates.format(template, {b'header': backport.text(header) if header else b'', 
               b'text': text}, data={b'savedData': state})
            return [
             MessageData(formatted, self._getGuiSettings(message, template))]


class RecertificationFinancialFormatter(ServiceChannelFormatter):
    __TEMPLATE = b'RecertificationFinancialSysMessage'
    __messageData = {b'buy': b'loss', 
       b'sell': b'profit'}

    def format(self, message, *args):
        if not message:
            return [MessageData(None, None)]
        else:
            data = message.data
            operationType = data.get(b'operationType')
            operationState = self.__messageData.get(operationType, b'')
            if not operationState:
                return [MessageData(None, None)]
            header = backport.text(R.strings.recertification_form.serviceChannelMessages.Financial.dyn(operationType)())
            state = backport.text(R.strings.recertification_form.serviceChannelMessages.Financial.dyn(operationState)())
            blanksCount = data.get(b'blanksCount')
            style = text_styles.credits if operationType == b'sell' else str
            creditsCount = style(getNiceNumberFormat(data.get(b'creditsCount')))
            text = backport.text(R.strings.recertification_form.serviceChannelMessages.Financial.text(), blanksCount=blanksCount, state=state, creditsCount=creditsCount)
            formatted = g_settings.msgTemplates.format(self.__TEMPLATE, {b'header': header, 
               b'text': text}, data={b'savedData': data})
            return [
             MessageData(formatted, self._getGuiSettings(message, self.__TEMPLATE))]


class ResourceWellOperationFormatter(ServiceChannelFormatter):
    __TEMPLATE = b'ResourceWellOperationMessage'
    __RESOURCE_WELL_MESSAGES = R.strings.messenger.serviceChannelMessages.resourceWell
    __BULLET = b'• '
    __NONE_NATION_NAME = b'intelligence'
    __NO_NATION_INDEX = 0
    __NATIONS_ORDER = {name:idx for idx, name in enumerate(GUI_NATIONS, 1)}
    __NATIONS_ORDER[__NONE_NATION_NAME] = __NO_NATION_INDEX
    __CURRENCY_ORDER = {name:idx for idx, name in enumerate(Currency.GUI_ALL + (CURRENCIES_CONSTANTS.FREE_XP,))}
    __FULL_PROGRESS = 100.0
    __resourceWell = dependency.descriptor(IResourceWellController)

    def format(self, message, *args):
        data = message.data
        if b'type' not in data or b'data' not in data:
            return [MessageData(None, None)]
        else:
            operationType = data[b'type']
            title = backport.text(self.__RESOURCE_WELL_MESSAGES.dyn(operationType).title())
            text = backport.text(self.__RESOURCE_WELL_MESSAGES.dyn(operationType).text())
            resources = self.__formatResources(data[b'data'])
            if not resources:
                return [MessageData(None, None)]
            additionalText = b''
            points = data.get(b'points')
            if points is not None and operationType == b'put':
                progress = self.__FULL_PROGRESS / (self.__resourceWell.getMaxPoints() or self.__FULL_PROGRESS) * points
                additionalText = backport.text(self.__RESOURCE_WELL_MESSAGES.progress(), progress=progress) + backport.text(R.strings.common.common.percent())
            ctx = {b'resources': self.__BULLET + resources, 
               b'title': title, 
               b'text': text, 
               b'additionalText': additionalText}
            formatted = g_settings.msgTemplates.format(self.__TEMPLATE, ctx=ctx)
            return [
             MessageData(formatted, self._getGuiSettings(message, self.__TEMPLATE))]

    def __formatResources(self, resources):
        resourceStrings = []
        if ServerResourceType.CURRENCY.value in resources:
            resourceStrings.extend(self.__formatCurrencies(resources[ServerResourceType.CURRENCY.value]))
        if ServerResourceType.BLUEPRINTS.value in resources:
            resourceStrings.append(self.__formatBlueprints(resources[ServerResourceType.BLUEPRINTS.value]))
        if ServerResourceType.ENTITLEMENTS.value in resources:
            resourceStrings.extend(self.__formatEntitlements(resources[ServerResourceType.ENTITLEMENTS.value]))
        return (backport.text(self.__RESOURCE_WELL_MESSAGES.breakLine()) + self.__BULLET).join(resourceStrings)

    def __formatBlueprints(self, blueprintResources):
        blueprints = []
        for fragmentCD, count in blueprintResources.iteritems():
            fragmentType = getFragmentType(fragmentCD)
            if fragmentType == BlueprintTypes.INTELLIGENCE_DATA:
                blueprints.append((self.__NONE_NATION_NAME, count))
            elif fragmentType == BlueprintTypes.NATIONAL:
                blueprints.append((nations.MAP.get(getFragmentNationID(fragmentCD), nations.NONE_INDEX), count))

        blueprints.sort(cmp=lambda a, b: cmp(self.__NATIONS_ORDER.get(a), self.__NATIONS_ORDER.get(b)), key=lambda x: x[0])
        blueprintStrings = []
        for nation, count in blueprints:
            nationStr = backport.text(R.strings.blueprints.nations.dyn(nation, self.__RESOURCE_WELL_MESSAGES.intelligence)())
            blueprintStrings.append(nationStr + self.__formatBlueprintCount(count))

        return backport.text(self.__RESOURCE_WELL_MESSAGES.blueprints()) + (b', ').join(blueprintStrings)

    def __formatCurrencies(self, currencyResources):
        currencies = sorted(currencyResources.items(), key=lambda x: x[0], cmp=lambda a, b: cmp(self.__CURRENCY_ORDER.get(a), self.__CURRENCY_ORDER.get(b)))
        return [ backport.text(self.__RESOURCE_WELL_MESSAGES.dyn(name)(), count=self.__formatCurrencyCount(name, count)) for name, count in currencies
               ]

    def __formatEntitlements(self, entitlementResources):
        result = []
        for resourceName, diff in entitlementResources.items():
            if resourceName == PREMIUM_ENTITLEMENTS.PLUS:
                days = abs(diff) // SECONDS_IN_DAY
                daysStr = backport.getIntegralFormat(days)
                result.append(backport.text(self.__RESOURCE_WELL_MESSAGES.premium_plus(), count=text_styles.crystal(daysStr)))
            else:
                _logger.error(b"ResourceWell: Unknown entitlement '%s'", resourceName)

        return result

    def __formatCurrencyCount(self, currencyName, count):
        style = getStyle(currencyName) if currencyName in Currency.ALL else text_styles.crystal
        return style(backport.getIntegralFormat(abs(count)))

    def __formatBlueprintCount(self, count):
        countStr = backport.getIntegralFormat(abs(count))
        return text_styles.crystal(backport.text(self.__RESOURCE_WELL_MESSAGES.blueprintCount(), count=countStr))


class ResourceWellRewardFormatter(WaitItemsSyncFormatter):
    __TEMPLATE = b'ResourceWellRewardReceivedMessage'
    __RESOURCE_WELL_MESSAGES = R.strings.messenger.serviceChannelMessages.resourceWell
    __resourceWell = dependency.descriptor(IResourceWellController)

    @adisp_async
    @adisp_process
    def format(self, message, callback):
        isSynced = yield self._waitForSyncItems()
        if isSynced:
            reward = message.data.get(b'reward')
            if reward is None:
                callback([MessageData(None, None)])
            callback([self.__getMainMessage(message), self.__getAdditionalMessage(message)])
        else:
            callback([MessageData(None, None)])
        return

    def __getMainMessage(self, message):
        from tutorial.control.game_vars import getVehicleByIntCD
        serialNumber = message.data.get(b'serialNumber')
        vehicle = getVehicleByIntCD(self.__resourceWell.getRewardVehicle()).userName
        additionalText = b''
        if serialNumber:
            title = backport.text(self.__RESOURCE_WELL_MESSAGES.topReward.title(), vehicle=vehicle)
            text = backport.text(self.__RESOURCE_WELL_MESSAGES.topReward.text(), vehicle=text_styles.crystal(vehicle))
            additionalText = backport.text(self.__RESOURCE_WELL_MESSAGES.topReward.additionalText(), serialNumber=serialNumber)
        else:
            title = backport.text(self.__RESOURCE_WELL_MESSAGES.regularReward.title(), vehicle=vehicle)
            text = backport.text(self.__RESOURCE_WELL_MESSAGES.regularReward.text(), vehicle=text_styles.crystal(vehicle))
        formatted = g_settings.msgTemplates.format(self.__TEMPLATE, ctx={b'title': title, b'text': text, b'additionalText': additionalText})
        return MessageData(formatted, self._getGuiSettings(message, self.__TEMPLATE))

    def __getAdditionalMessage(self, message):
        rewards = self.__resourceWell.getRewards()
        reward = rewards.get(message.data[b'reward'])
        if reward is None:
            return MessageData(None, None)
        else:
            slots = reward.bonus.get(b'slots')
            if not slots:
                return MessageData(None, None)
            text = g_settings.htmlTemplates.format(b'slotsAccruedInvoiceReceived', {b'amount': backport.getIntegralFormat(slots)})
            at = TimeFormatter.getLongDatetimeFormat(time_utils.makeLocalServerTime(message.sentTime))
            formatted = g_settings.msgTemplates.format(b'resourceWellInvoiceReceived', ctx={b'at': at, b'text': text})
            return MessageData(formatted, self._getGuiSettings(message, self.__TEMPLATE))


class ResourceWellNoVehiclesFormatter(WaitItemsSyncFormatter):
    __TEMPLATE = b'ResourceWellNoVehiclesMessage'
    __RETURN_TEMPLATE = b'ResourceWellNoVehiclesWithReturnMessage'
    __RESOURCE_WELL_MESSAGES = R.strings.messenger.serviceChannelMessages.resourceWell
    __itemsCache = dependency.descriptor(IItemsCache)
    __resourceWell = dependency.descriptor(IResourceWellController)

    @adisp_async
    @adisp_process
    def format(self, message, callback):
        isSynced = yield self._waitForSyncItems()
        if isSynced:
            from tutorial.control.game_vars import getVehicleByIntCD
            isSerial = message.data.get(b'isSerial')
            balance = self.__itemsCache.items.resourceWell.getBalance()
            title = backport.text(self.__RESOURCE_WELL_MESSAGES.noVehicles.title())
            template = self.__TEMPLATE
            if isSerial:
                template = self.__RETURN_TEMPLATE
                vehicle = getVehicleByIntCD(self.__resourceWell.getRewardVehicle()).userName
                text = backport.text(self.__RESOURCE_WELL_MESSAGES.noSerialVehicles.text(), vehicle=vehicle)
            elif balance:
                text = backport.text(self.__RESOURCE_WELL_MESSAGES.noVehiclesWithReturn.text())
            else:
                text = backport.text(self.__RESOURCE_WELL_MESSAGES.noVehicles.text())
            formatted = g_settings.msgTemplates.format(template, ctx={b'title': title, b'text': text})
            callback([MessageData(formatted, self._getGuiSettings(message, template))])
        else:
            callback([MessageData(None, None)])
        return


class Customization2DProgressionChangedFormatter(WaitItemsSyncFormatter):
    __itemsCache = dependency.descriptor(IItemsCache)
    REQUIRED_KEYS = {b'custType', b'id', b'2dProgression'}

    @adisp_async
    @adisp_process
    def format(self, message, callback, *args):
        result = [MessageData(None, None)]
        if not message:
            callback(result)
        isSynced = yield self._waitForSyncItems()
        data = message.data
        if isSynced and data and self.REQUIRED_KEYS == set(data.keys()):
            style = getCustomizationItem(data[b'id'], data[b'custType'])
            progression = data[b'2dProgression']
            totalItems = deque()
            rProgression = R.strings.messenger.serviceChannelMessages.progression2d
            for group, levels in progression:
                for level in list(OrderedDict.fromkeys(levels)):
                    itemsForLevel = style.descriptor.questsProgression.getUnlocks(group, level)[(-1)]
                    for itemType, itemIDs in itemsForLevel.iteritems():
                        for itemID in itemIDs:
                            custItem = getCustomizationItem(itemID, CustomizationTypeNames[itemType])
                            _, itemLevel = custItem.getQuestsProgressionInfo()
                            if itemType == CustomizationType.CAMOUFLAGE:
                                totalItems.appendleft((custItem, itemLevel))
                            else:
                                totalItems.append((custItem, itemLevel))

            title = backport.text(rProgression.title(), name=style.userName)
            itemsStrList = [ backport.text(rProgression.item(), typeName=backport.text(rProgression.dyn(custItem.itemTypeName)()), name=custItem.userName, level=self.__getLevelText(level)) for custItem, level in islice(totalItems, 0, 3)
                           ]
            if len(totalItems) > len(itemsStrList):
                itemsStrList += [backport.text(rProgression.itemCount(), count=len(totalItems) - len(itemsStrList))]
            itemsStr = (b'<br/>').join(itemsStrList)
            formatted = g_settings.msgTemplates.format(b'Customization2DProgressionMessage', ctx={b'title': title, b'itemsList': itemsStr}, data={b'savedData': {b'toStyle': True, b'styleID': data[b'id']}})
            result = [
             MessageData(formatted, self._getGuiSettings(message, messageType=message.type))]
        callback(result)
        return

    def __getLevelText(self, level):
        if level < 1:
            return b''
        return backport.text(R.strings.messenger.serviceChannelMessages.progression2d.level(), level=int2roman(level))


class FairplayFormatter(ServiceChannelFormatter):
    __TEMPLATE = b'InformationHeaderSysMessage'

    def format(self, message, *args):
        data = message.data
        if not data:
            return [MessageData(None, None)]
        else:
            isStarted = message.data.get(b'isStarted', False)
            reason = message.data.get(b'reason', b'')
            extraData = message.data.get(b'extraData', {})
            resrType = message.data.get(b'restrType', 0)
            if isStarted:
                header, text = self.__getBanStartedMessage(reason, extraData, resrType)
            else:
                header, text = self.__getBanStoppedMessage(reason, extraData, resrType)
            if not header and not text:
                return [MessageData(None, None)]
            formatted = g_settings.msgTemplates.format(self.__TEMPLATE, ctx={b'text': text, b'header': header})
            return [MessageData(formatted, self._getGuiSettings(message, self.__TEMPLATE))]

    @staticmethod
    def __isComp7DeserterBan(reason, extraData):
        return ARENA_BONUS_TYPE.COMP7 in extraData.get(b'bonusTypes', []) and FAIRPLAY_VIOLATIONS.COMP7_DESERTER in reason

    def __getBanStartedMessage(self, reason, extraData, resrType):
        header, text = (None, None)
        if resrType == RESTRICTION_TYPE.ARENA_BAN:
            if self.__isComp7DeserterBan(reason, extraData):
                penalty = extraData.get(b'penalty', 0)
                isQualification = extraData.get(b'qualActive', False)
                header = backport.text(R.strings.comp7.battleResult.message.header.deserter())
                text = backport.text(R.strings.comp7.battleResult.message.deserterQualification() if isQualification else R.strings.comp7.battleResult.message.deserter(), penalty=penalty)
        return (header, text)

    def __getBanStoppedMessage(self, reason, extraData, resrType):
        header, text = (None, None)
        if resrType == RESTRICTION_TYPE.ARENA_BAN:
            if self.__isComp7DeserterBan(reason, extraData):
                header = backport.text(R.strings.comp7.system_messages.temporaryBan.end.title())
                text = backport.text(R.strings.comp7.system_messages.temporaryBan.end.body())
        return (
         header, text)


class IntegratedAuctionResultFormatter(ServiceChannelFormatter):
    __TEMPLATE = b'IntegratedAuctionResultSysMessage'
    __AUCTION_MESSAGES = R.strings.messenger.serviceChannelMessages.integratedAuction
    __CURRENCY_TO_STYLE = {Currency.CREDITS: text_styles.creditsTitle, 
       Currency.GOLD: text_styles.goldTitle, 
       Currency.CRYSTAL: text_styles.crystalTitle, 
       CURRENCIES_CONSTANTS.FREE_XP: text_styles.expTitle}
    __FREE_XP = b'free_xp'
    __WGM_CURRENCY_TO_NAME = {__FREE_XP: CURRENCIES_CONSTANTS.FREE_XP}

    def format(self, message, *args):
        messageData = message.get(b'data', {})
        if b'currency' not in messageData or b'amount' not in messageData or b'result' not in messageData:
            return [MessageData(None, None)]
        else:
            headerResId, textResId = self.__getResIds(messageData[b'result'], messageData[b'amount'])
            headerStr = backport.text(headerResId)
            currencyStr = self.__getCurrencyString(str(messageData[b'currency']), int(messageData[b'amount']))
            header = text_styles.concatStylesWithSpace(headerStr, currencyStr)
            text = backport.text(textResId)
            formatted = g_settings.msgTemplates.format(self.__TEMPLATE, ctx={b'header': header, b'text': text})
            return [
             MessageData(formatted, self._getGuiSettings(message, self.__TEMPLATE))]

    def __getResIds(self, result, amount):
        if result == b'win':
            if amount == 0:
                return (self.__AUCTION_MESSAGES.winRate.header(), self.__AUCTION_MESSAGES.rateEqual.text())
            return (self.__AUCTION_MESSAGES.winRate.header(), self.__AUCTION_MESSAGES.winRate.text())
        else:
            if result == b'lost':
                return (self.__AUCTION_MESSAGES.lostRate.header(), self.__AUCTION_MESSAGES.lostRate.text())
            _logger.warning(b'Unsupported auction result type = %s', result)
            return (R.invalid(), R.invalid())

    def __getCurrencyString(self, currency, amount):
        currencyName = self.__WGM_CURRENCY_TO_NAME.get(currency, currency)
        icon = getattr(icons, currencyName + b'ExtraBig')()
        amountStr = self.__getCurrencyStyle(currency)(getBWFormatter(currency)(amount))
        return text_styles.concatStylesToSingleLine(amountStr, icon)

    def __getCurrencyStyle(self, currencyCode):
        currencyName = self.__WGM_CURRENCY_TO_NAME.get(currencyCode, currencyCode)
        return self.__CURRENCY_TO_STYLE.get(currencyName, getStyle(currencyName))


class PersonalReservesHaveBeenConvertedFormatter(ServiceChannelFormatter):
    __TEMPLATE = b'PersonalReservesHaveBeenConverted'

    def format(self, message, *args):
        formatted = g_settings.msgTemplates.format(self.__TEMPLATE)
        return [
         MessageData(formatted, self._getGuiSettings(message, self.__TEMPLATE))]


class CollectionsItemsFormatter(ServiceChannelFormatter):
    __TEMPLATE = b'CollectionItemsSysMessage'
    __collections = dependency.descriptor(ICollectionsSystemController)

    def format(self, message, *args):
        data = message.data
        if not (data and self.__collections.isEnabled()):
            return [MessageData(None, None)]
        else:
            from gui.collection.collections_helpers import getCollectionFullFeatureName
            messages = R.strings.collections.notifications
            collectionID = data[b'collectionId']
            collection = self.__collections.getCollection(collectionID)
            title = backport.text(messages.title.collectionName(), feature=getCollectionFullFeatureName(collection))
            rewards = data[b'items'] if b'items' in data else data[b'reward']
            text = backport.text(messages.newItemsReceived.text(), items=CollectionsFormatter.formatQuestAchieves(rewards, False))
            formatted = g_settings.msgTemplates.format(self.__TEMPLATE, ctx={b'title': title, b'text': text}, data={b'savedData': {b'collectionId': collectionID}})
            return [
             MessageData(formatted, self._getGuiSettings(message, self.__TEMPLATE))]


class CollectionsRewardFormatter(ServiceChannelFormatter):
    __MESSAGES = R.strings.collections.notifications
    __ITEMS_TEMPLATE = b'CollectionItemsSysMessage'
    __REWARD_TEMPLATE = b'CollectionRewardsSysMessage'
    __collections = dependency.descriptor(ICollectionsSystemController)

    def format(self, message, *args):
        data = message.data
        if not (data and self.__collections.isEnabled()):
            return [MessageData(None, None)]
        else:
            collectionID = data[b'collectionId']
            collection = self.__collections.getCollection(collectionID)
            isFinal = data[b'requiredCount'] == self.__collections.getMaxProgressItemCount(collectionID)
            result = [
             self.__makeMessageData(collection, isFinal, message)]
            if isFinal:
                result.append(self.__makeFinalMessageData(collection, message))
            return result

    def __makeMessageData(self, collection, isFinal, message):
        from gui.collection.collections_helpers import getCollectionFullFeatureName
        title = backport.text(self.__MESSAGES.title.collectionName(), feature=getCollectionFullFeatureName(collection))
        text = backport.text(self.__MESSAGES.newRewardsReceived.text(), items=CollectionsFormatter.formatQuestAchieves(deepcopy(message.data[b'reward']), False))
        template = self.__REWARD_TEMPLATE
        formatted = g_settings.msgTemplates.format(template, ctx={b'title': title, b'text': text}, data={b'savedData': {b'collectionId': collection.collectionId, 
                          b'bonuses': [
                                     message.data[b'reward']], 
                          b'isFinal': isFinal}})
        return MessageData(formatted, self._getGuiSettings(message, template, messageType=SYS_MESSAGE_TYPE.collectionsReward.index()))

    def __makeFinalMessageData(self, collection, message):
        from gui.collection.collections_helpers import getCollectionFullFeatureName
        text = backport.text(self.__MESSAGES.finalReceived.text(), feature=getCollectionFullFeatureName(collection))
        formatted = g_settings.msgTemplates.format(self.__ITEMS_TEMPLATE, ctx={b'title': backport.text(self.__MESSAGES.title.congratulation()), b'text': text}, data={b'savedData': {b'collectionId': collection.collectionId}})
        return MessageData(formatted, self._getGuiSettings(message, self.__ITEMS_TEMPLATE, messageType=SYS_MESSAGE_TYPE.collectionsItems.index()))


class AchievementsSMFormatter(ClientSysMessageFormatter):
    __ACHIEVEMENTS_MESSAGES = R.strings.achievements_page.notifications
    __ACHIEVEMENTS_IMAGES = R.images.gui.maps.icons.achievements

    def format(self, message, *args):
        messageType = message.get(b'type')
        if messageType is None:
            return
        else:
            rank = message.get(b'rank')
            subRank = message.get(b'subRank')
            template = self.__getTemplate(messageType)
            formatted = g_settings.msgTemplates.format(template, self.__getCtx(messageType, rank, subRank), data={b'linkageData': self.__getSavedDate(messageType, rank, subRank)})
            guiSettings = self._getGuiSettings(message, template)
            return [
             MessageData(formatted, guiSettings)]

    def __getSavedDate(self, type, rank=None, subRank=None):
        if type == Achievements20SystemMessages.RATING_UPGRADE:
            return {b'icon': backport.image(self.__ACHIEVEMENTS_IMAGES.messenger.rating.dyn((b'rating_{}_{}').format(rank, subRank))()), 
               b'type': b'rating'}
        if type == Achievements20SystemMessages.RATING_COMPLETE:
            return {b'icon': backport.image(self.__ACHIEVEMENTS_IMAGES.messenger.rating.dyn((b'rating_{}_{}').format(rank, subRank))()), 
               b'type': b'rating'}
        if type == Achievements20SystemMessages.EDITING_AVAILABLE:
            return {b'icon': backport.image(self.__ACHIEVEMENTS_IMAGES.messenger.editing()), 
               b'type': b'editing'}

    def __getCtx(self, type, rank=None, subRank=None):
        if type == Achievements20SystemMessages.RATING_UPGRADE:
            return {b'title': backport.text(self.__ACHIEVEMENTS_MESSAGES.ratingUp.title()), 
               b'text': backport.text(self.__ACHIEVEMENTS_MESSAGES.ratingUp.text(), level=self.__getLevel(rank, subRank))}
        if type == Achievements20SystemMessages.RATING_COMPLETE:
            return {b'title': backport.text(self.__ACHIEVEMENTS_MESSAGES.ratingCalculated.title()), 
               b'text': backport.text(self.__ACHIEVEMENTS_MESSAGES.ratingCalculated.text(), level=self.__getLevel(rank, subRank))}
        if type == Achievements20SystemMessages.EDITING_AVAILABLE:
            return {b'title': backport.text(self.__ACHIEVEMENTS_MESSAGES.editingEnabled.title()), 
               b'button': backport.text(self.__ACHIEVEMENTS_MESSAGES.editingEnabled.button())}

    def __getTemplate(self, type):
        if type == Achievements20SystemMessages.RATING_UPGRADE or type == Achievements20SystemMessages.RATING_COMPLETE:
            return b'achievementRating'
        if type == Achievements20SystemMessages.RATING_DOWNGRADE:
            return b'achievementRatingDowngrade'
        if type == Achievements20SystemMessages.EDITING_AVAILABLE:
            return b'achievementEditing'
        if type == Achievements20SystemMessages.FIRST_ENTRY:
            return b'achievementFirstEntry'
        if type == Achievements20SystemMessages.FIRST_ENTRY_WITHOUT_WTR:
            return b'achievementFirstEntryWithOutWTR'

    def __getLevel(self, rank=None, subRank=None):
        return backport.text(R.strings.achievements_page.tooltips.WTR.rating.levels.dyn((b'level_{}').format(rank))(), level=int2roman(subRank))


class EarlyAccessCompensationFormatter(ServiceChannelFormatter):
    __COMPENSATION_TEMPLATE = b'EarlyAccessCompensationSysMessage'
    __earlyAccessController = dependency.descriptor(IEarlyAccessController)

    def format(self, message, *args):
        data = message.data
        if not data or self.__earlyAccessController.getCurrentSeasonID() != 0:
            return [MessageData(None, None)]
        else:
            compensatedTokensCount = data[b'tokenAmount']
            compensationCredits = data[b'currencies'][Currency.CREDITS]
            formatter = getBWFormatter(Currency.CREDITS)
            formatted = g_settings.msgTemplates.format(self.__COMPENSATION_TEMPLATE, ctx={b'tokens': str(compensatedTokensCount), b'credits': formatter(compensationCredits)})
            return [
             MessageData(formatted, self._getGuiSettings(message, self.__COMPENSATION_TEMPLATE, priorityLevel=NotificationPriorityLevel.MEDIUM))]


class EarlyAccessVehicleObtainFormatter(ServiceChannelFormatter):
    __TEMPLATE = b'EarlyAccessCommonSysMessage'
    __earlyAccessController = dependency.descriptor(IEarlyAccessController)

    def format(self, message, *args):
        vehicles = message.data
        if not vehicles:
            return [MessageData(None, None)]
        else:
            nowTime = time_utils.getServerUTCTime()
            if self.__earlyAccessController.getPostProgressionVehicles() & set(vehicles):
                self.__earlyAccessController.onStartAnnouncement(EARLY_ACCESS_POSTPR_KEY)
            text = backport.text(R.strings.early_access.serviceChannelMessages.obtainVehicle.text(), date=backport.getDateTimeFormat(nowTime), vehicles=self.__formatVehiclesText(vehicles))
            formatted = g_settings.msgTemplates.format(self.__TEMPLATE, ctx={b'header': backport.text(R.strings.early_access.serviceChannelMessages.obtainVehicle.title()), b'text': text})
            return [
             MessageData(formatted, self._getGuiSettings(message, self.__TEMPLATE, messageType=SYS_MESSAGE_TYPE.earlyAccessVehicle.index(), priorityLevel=NotificationPriorityLevel.MEDIUM))]

    def __formatVehiclesText(self, vehicles):
        result = []
        for vehicle in vehicles:
            result.append(text_styles.vehicleName(self.__getVehicleName(vehicle)))

        return (b'\n').join(result)

    def __getVehicleName(self, vehTypeCD):
        return getUserName(getVehicleType(vehTypeCD))


class EarlyAccessQuestsTokensFormatter(object):
    __earlyAccessCtrl = dependency.descriptor(IEarlyAccessController)

    @classmethod
    def format(cls, data):
        for questID in data.get(b'completedQuestIDs', []):
            if questID.startswith(EARLY_ACCESS_PREFIX):
                count = cls.__earlyAccessCtrl.getTokensForQuest(questID)
                if count <= 0:
                    continue
                if cls.__earlyAccessCtrl.getReceivedTokensCount() >= cls.__earlyAccessCtrl.getTotalVehiclesPrice():
                    compensationCredits = cls.__earlyAccessCtrl.getTokenCompensation(Currency.CREDITS).credits * count
                    formatter = getBWFormatter(Currency.CREDITS)
                    return backport.text(R.strings.messenger.serviceChannelMessages.resourceWell.credits(), count=formatter(str(compensationCredits)))
                return backport.text(R.strings.messenger.serviceChannelMessages.battleResults.quests.items.name(), name=backport.text(R.strings.early_access.serviceChannelMessages.questAchieves.text()), count=count)

        return b''