import logging, typing, AccountCommands, BigWorld
from Event import Event
from PlayerEvents import g_playerEvents
from bootcamp.Bootcamp import g_bootcamp
from constants import RENEWABLE_SUBSCRIPTION_CONFIG, IS_CHINA
from gui import SystemMessages
from gui.impl import backport
from gui.impl.gen import R
from gui.server_events import settings
from gui.shared.gui_items.artefacts import OptionalDevice
from gui.shared.utils.requesters.ItemsRequester import REQ_CRITERIA
from helpers import dependency
from messenger.m_constants import SCH_CLIENT_MSG_TYPE
from messenger.proto.bw.wrappers import ServiceChannelMessage
from piggy_bank_common.settings_constants import PIGGY_BANK_PDATA_KEY
from renewable_subscription_common.settings_constants import RS_PDATA_KEY, IDLE_CREW_XP_PDATA_KEY, SUBSCRIPTION_DURATION_LENGTH, IDLE_CREW_VEH_INV_ID, RS_EXPIRATION_TIME, WotPlusState
from shared_utils.account_helpers.diff_utils import synchronizeDicts
from skeletons.gui.game_control import IWotPlusController, ISteamCompletionController
from skeletons.gui.lobby_context import ILobbyContext
from skeletons.gui.platform.product_fetch_controller import IUserSubscriptionsFetchController
from skeletons.gui.shared import IItemsCache
from skeletons.gui.system_messages import ISystemMessages
from wg_async import wg_async, wg_await
from wotdecorators import condition
if typing.TYPE_CHECKING:
    from typing import Dict, Optional, Callable, Any
    from gui.shared.gui_items import ItemsCollection
    from gui.game_control.account_completion import SteamCompletionController
_logger = logging.getLogger(__name__)
_SECONDS_IN_DAY = 86400

class _INotificationStrategy(object):
    _systemMessages = dependency.descriptor(ISystemMessages)

    def notifyClient(self, lastSeenStatus, currentStatus, enableMsgId, disableMsgId, data=None):
        raise NotImplementedError


class _LoginNotificationStrategy(_INotificationStrategy):

    def notifyClient(self, lastSeenStatus, currentStatus, enableMsgId, disableMsgId, data=None):
        if data is None:
            data = ServiceChannelMessage()
        if lastSeenStatus != currentStatus:
            if not currentStatus:
                self._systemMessages.proto.serviceChannel.pushClientMessage(data, disableMsgId)
            else:
                self._systemMessages.proto.serviceChannel.pushClientMessage(data, enableMsgId)
        return


class _SessionNotificationStrategy(_INotificationStrategy):

    def notifyClient(self, lastSeenStatus, currentStatus, enableMsgId, disableMsgId, data=None):
        if data is None:
            data = {}
        if lastSeenStatus != currentStatus:
            if not currentStatus:
                self._systemMessages.proto.serviceChannel.pushClientMessage(data, disableMsgId)
            else:
                self._systemMessages.proto.serviceChannel.pushClientMessage(data, enableMsgId)
        return


class WotPlusController(IWotPlusController):
    _lobbyContext = dependency.descriptor(ILobbyContext)
    _steamCompletionCtrl = dependency.descriptor(ISteamCompletionController)
    _itemsCache = dependency.descriptor(IItemsCache)
    _systemMessages = dependency.descriptor(ISystemMessages)
    _userSubscriptionFetchCtrl = dependency.descriptor(IUserSubscriptionsFetchController)
    ifAccount = condition('_account')

    def __init__(self):
        super(WotPlusController, self).__init__()
        self._validSessionStarted = False
        self._cache = {}
        self._account = None
        self._state = WotPlusState.INACTIVE
        self.onDataChanged = Event()
        self.onPendingRentChanged = Event()
        return

    def init(self):
        g_playerEvents.onClientUpdated += self._onClientUpdate

    def fini(self):
        g_playerEvents.onClientUpdated -= self._onClientUpdate

    def onLobbyStarted(self, ctx):
        self._lobbyContext.getServerSettings().onServerSettingsChange += self._onServerSettingsChange
        self.processSwitchNotifications()
        self._validSessionStarted = False if g_bootcamp.isRunning() else True
        self._resolveState()

    def onAccountBecomePlayer(self):
        self._account = BigWorld.player()

    def onAccountBecomeNonPlayer(self):
        self._lobbyContext.getServerSettings().onServerSettingsChange -= self._onServerSettingsChange
        self._account = None
        return

    def onDisconnected(self):
        self._validSessionStarted = False
        self._lobbyContext.getServerSettings().onServerSettingsChange -= self._onServerSettingsChange

    def selectIdleCrewXPVehicle(self, vehicleInvID, successCallback=None, errorCallback=None):

        def _onIdleCrewXPVehicleSelected(_, requestID, errorStr, errorMsg=None):
            if AccountCommands.isCodeValid(requestID):
                _logger.debug('[WotPlusController] _onIdleCrewXPVehicleSelected SUCCESS')
                if successCallback:
                    successCallback()
                return
            if requestID == AccountCommands.RES_NOT_AVAILABLE:
                self._systemMessages.pushMessage(backport.text(R.strings.messenger.serviceChannelMessages.wotPlus.passiveXP.isDisabled.title()), type=SystemMessages.SM_TYPE.Warning)
            _logger.warning((errorStr, errorMsg))
            if errorCallback:
                errorCallback()

        if vehicleInvID is None:
            vehicleInvID = -1
        self._account._doCmdInt(AccountCommands.CMD_IDLE_CREW_XP_SELECT_VEHICLE, vehicleInvID, callback=_onIdleCrewXPVehicleSelected)
        return

    def isEnabled(self):
        return self._cache.get('isEnabled', False)

    def isFreeToDemount(self, device):
        isFreeEquipmentDemountingEnabled = self._lobbyContext.getServerSettings().isFreeEquipmentDemountingEnabled()
        return isFreeEquipmentDemountingEnabled and self.isEnabled() and not (device.isModernized and device.level > 1)

    def getState(self):
        return self._state

    def getExpiryTime(self):
        return self._cache.get(RS_EXPIRATION_TIME, 0)

    def getStartTime(self):
        return self.getExpiryTime() - SUBSCRIPTION_DURATION_LENGTH

    def getGoldReserve(self):
        return self._cache.get('piggyBank', {}).get('gold')

    def hasVehicleCrewIdleXP(self, vehicleInvID):
        return self._cache.get(IDLE_CREW_XP_PDATA_KEY, {}).get(IDLE_CREW_VEH_INV_ID) == vehicleInvID

    def getVehicleIDWithIdleXP(self):
        return self._cache.get(IDLE_CREW_XP_PDATA_KEY, {}).get(IDLE_CREW_VEH_INV_ID)

    def getExclusiveVehicles(self):
        return self._itemsCache.items.getVehicles(REQ_CRITERIA.VEHICLE.WOT_PLUS_VEHICLE)

    def setRentPending(self, vehCD):
        with settings.wotPlusSettings() as (dt):
            dt.setRentPending(vehCD)
        self.onPendingRentChanged(vehCD)

    def getRentPending(self):
        return settings.getWotPlusSettings().rentPendingVehCD

    def resetRentPending(self):
        self.setRentPending(None)
        return

    @ifAccount
    def toggleWotPlusDev(self):
        self._account._doCmdInt(AccountCommands.CMD_TOGGLE_RENEWABLE_SUB_DEV, 0, self._onCmdResponseReceived)

    def setWotPlusStateDev(self, state):
        self._state = WotPlusState(state)
        self.onDataChanged(self._cache)

    @ifAccount
    def activateWotPlusDev(self, expirySecondsInFuture=_SECONDS_IN_DAY):
        self._account._doCmdInt(AccountCommands.CMD_ACTIVATE_RENEWABLE_SUB_DEV, expirySecondsInFuture, self._onCmdResponseReceived)

    def simulateNewGameDay(self):
        self._account._doCmdInt(AccountCommands.CMD_WOT_PLUS_NEW_GAME_DAY, 0, self._onCmdResponseReceived)

    def simulateRentTank(self, tankId):
        self._account._doCmdInt(AccountCommands.CMD_WOT_PLUS_RENT_TANK, tankId, self._onCmdResponseReceived)

    @ifAccount
    def setReservesDev(self, creditsVal, goldVal):
        self._account._doCmdInt2(AccountCommands.CMD_SET_RESERVES_PIGGY_BANK_DEV, creditsVal, goldVal, self._onCmdResponseReceived)

    @ifAccount
    def smashPiggyBankDev(self):
        self._account._doCmdInt(AccountCommands.CMD_SMASH_PIGGY_BANK_DEV, 6, self._onCmdResponseReceived)

    def isWotPlusEnabled(self):
        isWotPlusEnabled = self._lobbyContext.getServerSettings().isRenewableSubEnabled()
        if not isWotPlusEnabled:
            return False
        playerHasActiveWotPlus = self.isEnabled()
        if playerHasActiveWotPlus:
            return True
        isWotPlusEnabledForSteam = self._lobbyContext.getServerSettings().isWotPlusEnabledForSteam()
        isSteamAccount = self._steamCompletionCtrl.isSteamAccount
        if not isWotPlusEnabledForSteam and isSteamAccount:
            return False
        return True

    def processSwitchNotifications(self):
        if g_bootcamp.isRunning():
            return
        serverSettings = self._lobbyContext.getServerSettings()
        isWotPlusEnabled = self.isWotPlusEnabled()
        isEntryPointsEnabled = serverSettings.isWotPlusNewSubscriptionEnabled()
        isGoldReserveEnabled = serverSettings.isRenewableSubGoldReserveEnabled()
        isPassiveXpEnabled = serverSettings.isRenewableSubPassiveCrewXPEnabled()
        isFreeDemountingEnabled = serverSettings.isFreeEquipmentDemountingEnabled()
        isExcludedMapEnabled = serverSettings.isWotPlusExcludedMapEnabled()
        with settings.wotPlusSettings() as (dt):
            dt.setEntryPointsEnabledState(isEntryPointsEnabled)
            dt.setWotPlusEnabledState(isWotPlusEnabled)
            hasSubscription = self.isEnabled()
            if not isWotPlusEnabled and not hasSubscription:
                return
            strategy = self._getStrategy()
            if hasSubscription and not dt.isFirstTime:
                if not isWotPlusEnabled:
                    self._systemMessages.proto.serviceChannel.pushClientMessage({}, SCH_CLIENT_MSG_TYPE.WOTPLUS_FEATURE_DISABLED)
                else:
                    strategy.notifyClient(dt.isGoldReserveEnabled, isGoldReserveEnabled, SCH_CLIENT_MSG_TYPE.WOTPLUS_GOLDRESERVE_ENABLED, SCH_CLIENT_MSG_TYPE.WOTPLUS_GOLDRESERVE_DISABLED)
                    strategy.notifyClient(dt.isPassiveXpEnabled, isPassiveXpEnabled, SCH_CLIENT_MSG_TYPE.WOTPLUS_PASSIVEXP_ENABLED, SCH_CLIENT_MSG_TYPE.WOTPLUS_PASSIVEXP_DISABLED)
                    strategy.notifyClient(dt.isFreeDemountingEnabled, isFreeDemountingEnabled, SCH_CLIENT_MSG_TYPE.WOTPLUS_FREE_DEMOUNT_ENABLED, SCH_CLIENT_MSG_TYPE.WOTPLUS_FREE_DEMOUNT_DISABLED)
                    strategy.notifyClient(dt.isExcludedMapEnabled, isExcludedMapEnabled, SCH_CLIENT_MSG_TYPE.BONUS_EXCLUDED_MAP_ENABLED, SCH_CLIENT_MSG_TYPE.BONUS_EXCLUDED_MAP_DISABLED)
            dt.setIsFirstTime(not hasSubscription)
            dt.setGoldReserveEnabledState(isGoldReserveEnabled)
            dt.setPassiveXpState(isPassiveXpEnabled)
            dt.setFreeDemountingState(isFreeDemountingEnabled)
            dt.setExcludedMapState(isExcludedMapEnabled)

    @wg_async
    def _resolveState(self):
        if not self.isEnabled():
            self._state = WotPlusState.INACTIVE
            return
        if IS_CHINA:
            self._state = WotPlusState.ACTIVE
            return
        subscriptions = yield wg_await(self._userSubscriptionFetchCtrl.getProducts(False))
        activeSubsCount = len(subscriptions.products) if subscriptions.isProcessed and subscriptions.products else 0
        if activeSubsCount:
            self._state = WotPlusState.ACTIVE
        else:
            self._state = WotPlusState.CANCELLED

    @wg_async
    def _onClientUpdate(self, diff, _):
        itemDiff = diff.get(RS_PDATA_KEY, {})
        if IDLE_CREW_XP_PDATA_KEY in diff:
            itemDiff[IDLE_CREW_XP_PDATA_KEY] = diff[IDLE_CREW_XP_PDATA_KEY]
        if PIGGY_BANK_PDATA_KEY in diff:
            itemDiff[PIGGY_BANK_PDATA_KEY] = diff[PIGGY_BANK_PDATA_KEY]
        if itemDiff:
            synchronizeDicts(itemDiff, self._cache)
            yield wg_await(self._resolveState())
            self.onDataChanged(itemDiff)

    def _getStrategy(self):
        if self._validSessionStarted:
            return _SessionNotificationStrategy()
        return _LoginNotificationStrategy()

    def _onServerSettingsChange(self, diff):
        if RENEWABLE_SUBSCRIPTION_CONFIG in diff:
            self.processSwitchNotifications()

    def _onCmdResponseReceived(self, resultID, requestID, errorStr, errorMsg=None):
        if not AccountCommands.isCodeValid(requestID):
            _logger.error('Received invalid response: resultId: %s, requestId: %s, error: %s, message: %s', resultID, requestID, errorStr, errorMsg)