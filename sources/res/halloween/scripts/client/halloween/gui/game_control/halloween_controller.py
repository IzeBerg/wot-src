from collections import namedtuple
import Event, adisp
from account_helpers import AccountSettings
from account_helpers.AccountSettings import CURRENT_VEHICLE
from CurrentVehicle import g_currentVehicle
from skeletons.gui.shared import IItemsCache
from wg_async import wg_await
from frameworks.wulf import WindowLayer
from gui import SystemMessages
from gui.impl import backport
from gui.impl.gen import R
from gui.game_control.season_provider import SeasonProvider
from gui.impl.pub.fade_manager import FadeManager
from gui.prb_control.entities.base.ctx import PrbAction
from gui.prb_control.entities.listener import IGlobalListener
from gui.shared.notifications import NotificationPriorityLevel
from gui.shared.utils.scheduled_notifications import Notifiable, SimpleNotifier
from gui.shared import events, g_eventBus, EVENT_BUS_SCOPE
from halloween.gui.shared.event_dispatcher import showHangarAsync, closeViewsByID, showHangar
from halloween.gui.prb_control.entities.pre_queue.entity import HalloweenEntity
from halloween.gui.prb_control.entities.squad.entity import HalloweenSquadEntity
from halloween.gui.shared.utils.performance_analyzer import PerformanceAnalyzerMixin
from helpers import dependency, time_utils
from halloween_common.halloween_constants import QUEUE_TYPE, PREBATTLE_TYPE
from halloween.gui.halloween_gui_constants import PREBATTLE_ACTION_NAME, FUNCTIONAL_FLAG
from halloween.skeletons.halloween_controller import IHalloweenController
from halloween_common.halloween_constants import HALLOWEEN_GAME_PARAMS_KEY
from shared_utils import makeTupleByDict, _logger
from skeletons.gui.game_control import IReferralProgramController
from skeletons.gui.server_events import IEventsCache
from skeletons.gui.lobby_context import ILobbyContext
IGNORE_MODE_FOR_SELECTED_VEHICLE = [
 FUNCTIONAL_FLAG.EVENT, FUNCTIONAL_FLAG.HALLOWEEN, FUNCTIONAL_FLAG.BOOTCAMP, FUNCTIONAL_FLAG.BATTLE_ROYALE]

class _HalloweenConfig(namedtuple('_HalloweenConfig', ('isEnabled', 'isBattlesEnabled', 'startDate', 'endDate',
                                'artefactsSettings', 'vehicles', 'rent', 'shop',
                                'hangarStyles', 'isChatEnabled'))):
    __slots__ = ()

    def __new__(cls, **kwargs):
        defaults = dict(isEnabled=False, isBattlesEnabled={}, startDate=0, endDate=0, artefactsSettings={}, rent={}, vehicles=[], shop={}, hangarStyles=[], isChatEnabled=False)
        defaults.update(kwargs)
        return super(_HalloweenConfig, cls).__new__(cls, **defaults)

    def asDict(self):
        return self._asdict()

    def replace(self, data):
        allowedFields = self._fields
        dataToUpdate = dict((k, v) for k, v in data.iteritems() if k in allowedFields)
        return self._replace(**dataToUpdate)

    @classmethod
    def defaults(cls):
        return cls()


class HalloweenController(IHalloweenController, Notifiable, SeasonProvider, IGlobalListener, PerformanceAnalyzerMixin):
    __lobbyContext = dependency.descriptor(ILobbyContext)
    __eventsCache = dependency.descriptor(IEventsCache)
    __itemsCache = dependency.descriptor(IItemsCache)
    __referralCtrl = dependency.descriptor(IReferralProgramController)

    def __init__(self):
        super(HalloweenController, self).__init__()
        self.__serverSettings = None
        self._prevStates = (False, False)
        self.onEventDisabled = Event.Event()
        self.onSettingsUpdate = Event.Event()
        return

    def init(self):
        super(HalloweenController, self).init()
        self._prevStates = (False, False)
        self.addNotificator(SimpleNotifier(self.__getTimer, self.__timerUpdate))

    def fini(self):
        self.onEventDisabled.clear()
        self.onSettingsUpdate.clear()
        self.clearNotification()
        self._prevStates = (False, False)
        self.__clear()
        super(HalloweenController, self).fini()

    def onDisconnected(self):
        super(HalloweenController, self).onDisconnected()
        self._prevStates = (False, False)
        self.__clear()

    def onAvatarBecomePlayer(self):
        super(HalloweenController, self).onAvatarBecomePlayer()
        self.__clear()

    def onAccountBecomePlayer(self):
        super(HalloweenController, self).onAccountBecomePlayer()
        self.__onServerSettingsChanged(self.__lobbyContext.getServerSettings())

    def onLobbyInited(self, event):
        super(HalloweenController, self).onLobbyInited(event)
        self.startNotification()
        g_eventBus.addListener(events.HangarVehicleEvent.SELECT_VEHICLE_IN_HANGAR, self.__onSelectVehicleInHangar, scope=EVENT_BUS_SCOPE.LOBBY)
        self.startGlobalListening()
        if not self.isAvailable() and self.isEventHangar():
            self.selectRandomMode()

    def onPrbEntitySwitched(self):
        self.__referralCtrl.setReferralHardDisabled(self.isEventHangar())
        if not any(self.prbEntity.getModeFlags() & flag for flag in IGNORE_MODE_FOR_SELECTED_VEHICLE):
            g_currentVehicle.selectVehicle(AccountSettings.getFavorites(CURRENT_VEHICLE))

    def isEnabled(self):
        return self.getModeSettings().isEnabled

    def isBattlesEnabled(self):
        return self.getModeSettings().isBattlesEnabled

    def isAvailable(self):
        return self.isEnabled() and self.__getTimer() is not None

    def getConfig(self):
        return self.__lobbyContext.getServerSettings().getSettings().get(HALLOWEEN_GAME_PARAMS_KEY, {})

    def getModeSettings(self):
        if self.getConfig():
            return makeTupleByDict(_HalloweenConfig, self.getConfig())
        return _HalloweenConfig.defaults()

    @adisp.adisp_process
    def selectBattle(self):
        dispatcher = self.prbDispatcher
        if dispatcher is None:
            _logger.error('Prebattle dispatcher is not defined')
            return
        else:
            if self.isEventHangar():
                return
            with FadeManager(WindowLayer.SERVICE_LAYOUT) as (fadeManager):
                result = yield dispatcher.doSelectAction(PrbAction(PREBATTLE_ACTION_NAME.HALLOWEEN), transition=wg_await(fadeManager.show()))
                if not result:
                    return
                yield showHangarAsync()
                yield wg_await(fadeManager.hide())
            return

    def openHangar(self):
        if self.isEventHangar():
            showHangar()
        else:
            self.selectBattle()

    def isEventHangar(self):
        prbDispatcher = self.prbDispatcher
        state = prbDispatcher.getFunctionalState() if prbDispatcher is not None else None
        return state is not None and (state.isInPreQueue(QUEUE_TYPE.HALLOWEEN) or state.isInPreQueue(QUEUE_TYPE.HALLOWEEN_MEDIUM) or state.isInPreQueue(QUEUE_TYPE.HALLOWEEN_HARD) or state.isInUnit(PREBATTLE_TYPE.HALLOWEEN))

    @adisp.adisp_process
    def selectRandomMode(self):
        dispatcher = self.prbDispatcher
        if dispatcher is None:
            return
        else:
            with FadeManager(WindowLayer.SERVICE_LAYOUT) as (fadeManager):
                result = yield dispatcher.doSelectAction(PrbAction(PREBATTLE_ACTION_NAME.RANDOM), transition=wg_await(fadeManager.show()))
                if not result:
                    return
                yield wg_await(fadeManager.hide())
            return

    def selectVehicle(self, invID):
        if not self.isEventHangar():
            return
        else:
            dispatcher = self.prbDispatcher
            if dispatcher is None:
                return
            entity = dispatcher.getEntity()
            if entity and isinstance(entity, (HalloweenEntity, HalloweenSquadEntity)):
                entity.selectModeVehicle(invID)
            return

    def hasAccessToVehicle(self, vehTypeCD):
        rentVehicles = self.getModeSettings().rent.get('vehicles', {})
        if vehTypeCD not in rentVehicles:
            return True
        return any(self.__eventsCache.questsProgress.getTokenCount(accessToken) > 0 for accessToken in rentVehicles[vehTypeCD].itervalues())

    def __onServerSettingsChanged(self, serverSettings):
        if self.__serverSettings is not None:
            self.__serverSettings.onServerSettingsChange -= self.__updateEventBattlesSettings
        self.__serverSettings = serverSettings
        self.__serverSettings.onServerSettingsChange += self.__updateEventBattlesSettings
        return

    def __updateEventBattlesSettings(self, diff):
        if HALLOWEEN_GAME_PARAMS_KEY in diff:
            self.startNotification()
            self.onSettingsUpdate()
            if self.isEventHangar() and not self.isAvailable():
                self.__closeHalloweenViews()
                self.onEventDisabled()
            self.__updateStates()

    def __updateStates(self):
        isEnabled, isBattleEnabled = self._prevStates
        if isBattleEnabled != self.isBattlesEnabled() and not self.isBattlesEnabled() and self.__getTimer() is not None:
            SystemMessages.pushMessage(backport.text(R.strings.halloween_system_messages.serviceChannelMessages.switched_off()), type=SystemMessages.SM_TYPE.Error, priority=NotificationPriorityLevel.MEDIUM)
        if isEnabled != self.isEnabled() and not self.isEnabled() and self.__getTimer() is not None:
            SystemMessages.pushMessage(backport.text(R.strings.halloween_system_messages.serviceChannelMessages.switched_off_full()), type=SystemMessages.SM_TYPE.Error, priority=NotificationPriorityLevel.MEDIUM)
        self._prevStates = (self.isEnabled(), self.isBattlesEnabled())
        return

    def __clear(self):
        self.stopNotification()
        self.stopGlobalListening()
        g_eventBus.removeListener(events.HangarVehicleEvent.SELECT_VEHICLE_IN_HANGAR, self.__onSelectVehicleInHangar, scope=EVENT_BUS_SCOPE.LOBBY)
        if self.__serverSettings is not None:
            self.__serverSettings.onServerSettingsChange -= self.__updateEventBattlesSettings
        self.__serverSettings = None
        return

    def __getTimer(self):
        endDate = self.getModeSettings().endDate
        now = time_utils.getCurrentLocalServerTimestamp()
        timeLeft = endDate - now
        if timeLeft > 0:
            return timeLeft + 1
        else:
            return

    def __timerUpdate(self):
        if self.isEventHangar():
            self.__closeHalloweenViews()
            self.onEventDisabled()

    def __closeHalloweenViews(self):
        closeViewsByID([
         R.views.halloween.lobby.BundleView(),
         R.views.halloween.lobby.ComparisonWindowView(),
         R.views.halloween.lobby.MetaIntroView(),
         R.views.dialogs.DefaultDialog(),
         R.views.lobby.tanksetup.dialogs.Confirm(),
         R.views.lobby.tanksetup.dialogs.ConfirmActionsWithEquipmentDialog(),
         R.views.lobby.tanksetup.dialogs.ExchangeToBuyItems()])

    def __onSelectVehicleInHangar(self, event):
        if not self.isEventHangar():
            return
        vehicleInvID = event.ctx['vehicleInvID']
        vehicle = self.__itemsCache.items.getVehicle(vehicleInvID)
        if vehicle:
            self.selectRandomMode()