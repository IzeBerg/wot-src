import itertools, BigWorld
from historical_battles_common import hb_constants_extension
from dossiers2.ui.achievements import BADGES_BLOCK
from gui.impl import backport
from gui.impl.gen import R
from gui.shared.money import Currency
from gui.shared.formatters.currency import getBWFormatter
from helpers import dependency
from items import vehicles
from messenger import g_settings
from messenger.formatters.service_channel import ServiceChannelFormatter, InvoiceReceivedFormatter, BattleResultsFormatter, QuestAchievesFormatter
from messenger.formatters.service_channel_helpers import MessageData
from historical_battles.skeletons.gui.game_event_controller import IGameEventController
from historical_battles_common.hb_constants import FrontmanRoleID, BADGE_QUEST_ID
from historical_battles_common.helpers_common import getVehicleBonus
from historical_battles.notification.decorators import HBProgressionLockButtonDecorator

class HBProgressionAchievesFormatter(QuestAchievesFormatter):
    _BULLET = '• '
    _SEPARATOR = '<br/>' + _BULLET

    @classmethod
    def formatQuestAchieves(cls, data, asBattleFormatter, processCustomizations=True, processTokens=True):
        result = super(HBProgressionAchievesFormatter, cls).formatQuestAchieves(data, asBattleFormatter, processCustomizations, processTokens)
        if result:
            return cls._BULLET + result
        return result


class HBProgressionSystemMessageFormatter(ServiceChannelFormatter):
    __TEMPLATE = 'HistoricalBattlesProgressionSystemMessage'

    def __init__(self):
        super(HBProgressionSystemMessageFormatter, self).__init__()
        self._achievesFormatter = HBProgressionAchievesFormatter()

    def format(self, message, *args):
        return self._format(message, args)

    def _format(self, message, *_):
        messageData = message.data or {}
        results = messageData.get('stages', set())
        messageDataList = []
        for result in sorted(results, key=lambda result: result.get('stage', {})):
            messageDataList.append(self._formatSingleStageCompletion(message, result))

        return messageDataList

    def _formatSingleStageCompletion(self, message, stageInfo):
        decorator = HBProgressionLockButtonDecorator
        messageHeader = backport.text(R.strings.historical_battles_progression.serviceChannelMessages.header())
        stage = stageInfo.get('stage')
        progressionName = backport.text(R.strings.historical_battles_progression.serviceChannelMessages.progressionName())
        messageBody = backport.text(R.strings.historical_battles_progression.serviceChannelMessages.body(), stage=str(stage), progressionName=progressionName)
        rewardsData = stageInfo.get('detailedRewards', {})
        if not rewardsData:
            return None
        else:
            self.__formatVehicles(rewardsData)
            formattedRewards = self._achievesFormatter.formatQuestAchieves(rewardsData, asBattleFormatter=False)
            return MessageData(g_settings.msgTemplates.format(self.__TEMPLATE, ctx={'header': messageHeader, 'body': messageBody, 
               'awards': formattedRewards}, data={}), self._getGuiSettings(message, self.__TEMPLATE, decorator=decorator))

    @staticmethod
    def __formatVehicles(data):
        vehiclesToFormat = data.get('vehicles')
        if vehiclesToFormat and isinstance(vehiclesToFormat, dict):
            data['vehicles'] = [
             vehiclesToFormat]


def __getBadgeIdFromResult(battleResults, questID):
    dossiers = battleResults['detailedRewards'][questID]['dossier']
    for rec in dossiers.itervalues():
        for (block, name), _ in rec.iteritems():
            if block == BADGES_BLOCK and name != '':
                return name

    return


def hbExtendBattleResultsContext(ctx, battleResults):
    gameEventController = dependency.instance(IGameEventController)
    frontmanID = battleResults['frontmanID']
    frontmanRoleID = battleResults['frontmanRoleID']
    hbCoins = battleResults['hbCoins']
    hasReceivedRoleAbility = battleResults['roleObtained']
    badgeQuestComplete = 'completedQuestIDs' in battleResults and BADGE_QUEST_ID in battleResults['completedQuestIDs']
    ctx['hbFrontName'] = backport.text(R.strings.hb_lobby.system_messages.battleResults.event(), text=backport.text(R.strings.hb_lobby.battleModeLong.offence()))
    ctx['hbFrontman'] = backport.text(R.strings.hb_lobby.system_messages.battleResults.frontman(), name=backport.text(R.strings.hb_lobby.dyn(('frontman_{}').format(frontmanID)).name()), role=backport.text(R.strings.hb_lobby.roleRegular.dyn(FrontmanRoleID(frontmanRoleID).name.lower())()))
    extraData = []
    if hasReceivedRoleAbility or badgeQuestComplete:
        extraData.append(g_settings.htmlTemplates.format('hbShopBundleSimpleText', {'text': backport.text(R.strings.quests.details.status.completed())}))
    if hasReceivedRoleAbility:
        frontmen = {}
        for _, f in gameEventController.frontController.getFronts().iteritems():
            frontmen.update(f.getFrontmen())

        abilityID = frontmen[frontmanID].getRoleAbility()
        roleAbility = vehicles.g_cache.equipments()[abilityID]
        extraData.append(backport.text(R.strings.hb_lobby.system_messages.battleResults.roleAbility(), text=roleAbility.userString))
    if badgeQuestComplete:
        badgeID = __getBadgeIdFromResult(battleResults, BADGE_QUEST_ID)
        if badgeID:
            extraData.append(backport.text(R.strings.hb_lobby.system_messages.battleResults.badge(), text=backport.text(R.strings.badge.dyn(('badge_{}').format(badgeID))())))
    if hbCoins:
        extraData.append(backport.text(R.strings.hb_lobby.system_messages.battleResults.coins.dyn(hbCoins['type'])(), amount=backport.getIntegralFormat(hbCoins['amount'])))
    ctx['hbExtraData'] = ('<br/>').join(extraData)


def hbAddExtendedBattleModeForBattleResultsNotification():
    battleModeInfo = BattleResultsFormatter.ExtendedBattleModeInfo(htmlTemplates={-1: 'HBBattleDefeatResult', 
       0: 'HBBattleDefeatResult', 
       1: 'HBBattleVictoryResult'}, extendContextFn=hbExtendBattleResultsContext)
    BattleResultsFormatter.EXTENDED_BATTLE_MODES.update({hb_constants_extension.ARENA_GUI_TYPE.HISTORICAL_BATTLES: battleModeInfo})


class HBShopBundlePurchasedSysMessageFormatter(InvoiceReceivedFormatter):
    _MESSAGE_TEMPLATE = 'HBShopBundlePurchasedSysMessage'
    _MULTI_PRICE_ICON = 'multiPrice'
    _CURRENCY_TO_ICON = {Currency.GOLD: 'GoldIcon', 
       Currency.CREDITS: 'CreditsIcon', 
       'hb_coin_defence': 'historical_battles:defence', 
       'hb_coin_counterattack': 'historical_battles:counterattack', 
       'hb_coin_offence': 'historical_battles:offence', 
       _MULTI_PRICE_ICON: 'historical_battles:multiPriceCoins'}

    def isAsync(self):
        return False

    @property
    def shop(self):
        return getattr(BigWorld.player(), 'HBShopAccountComponent', None)

    def format(self, message, *args):
        bundleID = message.data['bundleID']
        count = message.data['count']
        bundle = self.shop.getBundle(bundleID)
        operations = self._formatBundleName(bundle)
        operations += self._composeOperations(message.data)
        operations += self._formatBundleTokens(bundle, count)
        operations += self._formatWithdrawnMoney(bundle.prices, count)
        settings = self._getGuiSettings(message, self._MESSAGE_TEMPLATE)
        formatted = g_settings.msgTemplates.format(self._MESSAGE_TEMPLATE, {'op': ('<br/>').join(operations)}, data={'icon': self._getMessageIcon(bundle)})
        return [
         MessageData(formatted, settings)]

    def _getMessageIcon(self, bundle):
        key = self._MULTI_PRICE_ICON if len(bundle.prices) > 1 else bundle.prices[0].currency
        return self._CURRENCY_TO_ICON.get(key, '')

    def _formatBundleName(self, bundle):
        resource = R.strings.hb_shop.bundles.dyn(bundle.id).dyn('systemMessage').dyn('purchased')
        if resource.exists():
            return [
             g_settings.htmlTemplates.format('hbShopBundleSimpleText', {'text': backport.text(resource())})]
        return []

    def _formatBundleTokens(self, bundle, purchasesCount):
        result = []
        for name, record in self._getTokensIter(bundle.bonuses):
            tokenFormatter = self._getTokenFormatter(name)
            if tokenFormatter is not None:
                result.append(tokenFormatter(record, bundle, purchasesCount))

        return result

    def _getTokensIter(self, bonuses):
        return itertools.chain.from_iterable(b.getTokens().iteritems() for b in bonuses if b.getName() == 'battleToken')

    def _getTokenFormatter(self, tokenID):
        return

    def _formatWithdrawnMoney(self, prices, count):
        return [ g_settings.htmlTemplates.format('hbShopBundleSimpleText', {'text': backport.text(R.strings.hb_shop.systemMessage.moneySpent(), text=backport.text(R.strings.hb_shop.systemMessage.moneySpent.dyn(subPrice.currency)(), amount=getBWFormatter(subPrice.currency)(subPrice.amount * count)))}) for subPrice in prices
               ]


class HBCouponsBundlePurchasedSysMessageFormatter(HBShopBundlePurchasedSysMessageFormatter):
    _MESSAGE_TEMPLATE = 'HBCouponsBundlePurchasedSysMessage'
    _R = R.strings.hb_shop.systemMessage.x10FrontCoupons

    def _getTokenFormatter(self, _):
        return self._formatFrontCouponsToken

    @classmethod
    def _formatFrontCouponsToken(cls, tokenRecord, bundle, purchasesCount):
        isGift = bundle.prices[0].currency == Currency.GOLD
        return g_settings.htmlTemplates.format('hbShopBundleSimpleText', {'text': backport.text(cls._R.gift() if isGift else cls._R.purchase(), count=tokenRecord.count * purchasesCount)})


class HBTankModuleBundlePurchasedSysMessageFormatter(HBShopBundlePurchasedSysMessageFormatter):
    MAIN_PRIZE_VEHICLE_BUNDLE_ID = 'hb22BundleMainPrizeVehicle'

    def _formatBundleName(self, bundle):
        mainPrizeBundle = self.shop.getBundle(self.MAIN_PRIZE_VEHICLE_BUNDLE_ID)
        bundleBonuses = self.shop.getBundleBonusesWithQuests(mainPrizeBundle)
        vehicleBonus = getVehicleBonus(bundleBonuses)
        if vehicleBonus is None:
            return []
        else:
            self.__mainPrizeVehicleName = vehicleBonus.userName
            resource = R.strings.hb_shop.bundles.dyn(bundle.id).dyn('systemMessage').dyn('purchased')
            if resource.exists():
                return [
                 g_settings.htmlTemplates.format('hbShopBundleSimpleText', {'text': backport.text(resource(), vehName=self.__mainPrizeVehicleName)})]
            return []


class MainPrizeVehicleBundlePurchased(ServiceChannelFormatter):
    _MESSAGE_TEMPLATE = 'HBMainPrizeVehicleBundlePurchased'
    _MEDAL = 'hb24Medal'
    _R_MAIN_PRIZE = R.strings.hb_shop.systemMessage.mainPrize
    _CURRENCIES_ORDER = [Currency.CREDITS, Currency.GOLD]

    def format(self, message, *args):
        if not message.data:
            return []
        moneySpent = message.data.get('moneySpent')
        vehTypeIntCD = message.data.get('vehTypeIntCD')
        isGift = not moneySpent or not moneySpent.get(Currency.GOLD, 0)
        vehDescr = vehicles.VehicleDescr(typeID=vehicles.parseIntCompactDescr(vehTypeIntCD)[1:])
        messageLines = []
        vehResourse = self._R_MAIN_PRIZE.giftVehicle if isGift else self._R_MAIN_PRIZE.vehicle
        messageLines.append(g_settings.htmlTemplates.format('hbShopBundleSimpleText', {'text': backport.text(vehResourse(), vehName=vehDescr.type.userString)}))
        if isGift:
            messageLines.append(g_settings.htmlTemplates.format('hbShopBundleSimpleText', {'text': backport.text(self._R_MAIN_PRIZE.slot())}))
        messageLines.append(g_settings.htmlTemplates.format('hbShopBundleSimpleText', {'text': backport.text(self._R_MAIN_PRIZE.medal(), medalName=backport.text(R.strings.achievements.dyn(self._MEDAL)()))}))
        if moneySpent:
            money = [ backport.text(R.strings.hb_shop.systemMessage.moneySpent.dyn(currency)(), amount=getBWFormatter(currency)(moneySpent[currency])) for currency in self._CURRENCIES_ORDER if currency in moneySpent and moneySpent[currency] != 0
                    ]
            if money:
                messageLines.append(g_settings.htmlTemplates.format('hbShopBundleSimpleText', {'text': backport.text(R.strings.hb_shop.systemMessage.moneySpent(), text=(', ').join(money))}))
        settings = self._getGuiSettings(message, self._MESSAGE_TEMPLATE)
        formatted = g_settings.msgTemplates.format(self._MESSAGE_TEMPLATE, {'op': ('<br/>').join(messageLines)})
        return [
         MessageData(formatted, settings)]


class HBArenaBanSystemMessageFormatter(ServiceChannelFormatter):
    __TEMPLATE = 'HistoricalBattlesArenaBanSystemMessage'

    def canBeEmpty(self):
        return True

    def format(self, data, *args):
        messageDataList = []
        messageDataList.append(self._formatSingleStageCompletion(data))
        return messageDataList

    def _formatSingleStageCompletion(self, data):
        isStarted = data.get('isStarted', False)
        if isStarted:
            header = backport.text(R.strings.hb_lobby.sysMessageFairPlayMsg.arenaBanStart.header())
            body = backport.text(R.strings.hb_lobby.sysMessageFairPlayMsg.arenaBanStart.body())
            icon = 'hbBanIcon'
        else:
            header = backport.text(R.strings.hb_lobby.sysMessageFairPlayMsg.arenaBanStop.header())
            body = backport.text(R.strings.hb_lobby.sysMessageFairPlayMsg.arenaBanStop.body())
            icon = 'InformationIcon'
        data = {'savedData': {'isStarted': isStarted, 
                         'reason': data.get('reason', ''), 
                         'duration': data.get('duration', 0), 
                         'banExpiryTime': data.get('banExpiryTime', 0)}, 
           'icon': icon}
        return MessageData(g_settings.msgTemplates.format(self.__TEMPLATE, ctx={'header': header, 'body': body}, data=data), self._getGuiSettings(data, self.__TEMPLATE))


class HBArenaWarningSystemMessageFormatter(ServiceChannelFormatter):
    __TEMPLATE = 'HistoricalBattlesArenaWarningSystemMessage'

    def canBeEmpty(self):
        return True

    def format(self, data, *args):
        messageDataList = []
        messageDataList.append(self._formatSingleStageCompletion(data))
        return messageDataList

    def _formatSingleStageCompletion(self, data):
        header = backport.text(R.strings.hb_lobby.sysMessageFairPlayMsg.arenaWarning.header())
        body = backport.text(R.strings.hb_lobby.sysMessageFairPlayMsg.arenaWarning.body())
        data = {'savedData': {'reason': data.get('reason', ''), 
                         'duration': data.get('duration', 0), 
                         'banExpiryTime': data.get('banExpiryTime', 0)}}
        return MessageData(g_settings.msgTemplates.format(self.__TEMPLATE, ctx={'header': header, 'body': body}, data=data), self._getGuiSettings(data, self.__TEMPLATE))


class HBStateMessageFormatter(ServiceChannelFormatter):
    __TEMPLATE = 'HBStartedMessage'

    def format(self, message, *args):
        formatted = g_settings.msgTemplates.format(self.__TEMPLATE)
        return [MessageData(formatted, self._getGuiSettings(message, self.__TEMPLATE))]