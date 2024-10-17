from collections import namedtuple
import CGF, Event, adisp
from account_helpers import AccountSettings
from account_helpers.AccountSettings import CURRENT_VEHICLE
from CurrentVehicle import g_currentVehicle
from cgf_components.hangar_camera_manager import HangarCameraManager
from skeletons.gui.shared import IItemsCache
from frameworks.wulf import WindowLayer
from gui import SystemMessages
from gui.impl import backport
from gui.impl.gen import R
from gui.limited_ui.lui_rules_storage import LUI_RULES
from gui.game_control.season_provider import SeasonProvider
from gui.prb_control import prbEntityProperty
from gui.prb_control.entities.base.ctx import PrbAction
from gui.prb_control.entities.listener import IGlobalListener
from gui.shared.notifications import NotificationPriorityLevel
from gui.shared.utils.requesters import REQ_CRITERIA
from gui.shared.utils.scheduled_notifications import Notifiable, SimpleNotifier
from gui.shared import events, g_eventBus, EVENT_BUS_SCOPE
from gui.shared.event_dispatcher import showHangar as showMainHangar
from halloween.gui.shared.event_dispatcher import closeViewsByID, showHangar
from halloween.gui.prb_control.entities.pre_queue.entity import HalloweenEntity
from halloween.gui.prb_control.entities.squad.entity import HalloweenSquadEntity
from halloween.gui.shared.utils.performance_analyzer import PerformanceAnalyzerMixin
from halloween.gui.shared.event_dispatcher import showPromoWindowView
from helpers import dependency, time_utils
from halloween_common.halloween_constants import QUEUE_TYPE, PREBATTLE_TYPE, DEFENCE_FORBIDDEN_VEHICLE_TAGS
from halloween.gui.halloween_gui_constants import PREBATTLE_ACTION_NAME, FUNCTIONAL_FLAG, QUEUE_TYPE_TO_DIFFICULTY_LEVEL
from halloween.skeletons.difficulty_level_controller import IDifficultyLevelController
from halloween.skeletons.halloween_controller import IHalloweenController
from halloween_common.halloween_constants import HALLOWEEN_GAME_PARAMS_KEY
from shared_utils import makeTupleByDict
from skeletons.gui.game_control import IReferralProgramController
from skeletons.gui.server_events import IEventsCache
from skeletons.gui.lobby_context import ILobbyContext
from skeletons.gui.game_control import IHangarLoadingController
from skeletons.gui.game_control import ILimitedUIController
from skeletons.gui.shared.utils import IHangarSpace
IGNORE_MODE_FOR_SELECTED_VEHICLE = [
 FUNCTIONAL_FLAG.EVENT, FUNCTIONAL_FLAG.HALLOWEEN, FUNCTIONAL_FLAG.BATTLE_ROYALE]

class _HalloweenConfig(namedtuple('_HalloweenConfig', ('isEnabled', 'isBattlesEnabled', 'startDate', 'endDate',
                                'rewardsSettings', 'artefactsSettings', 'vehicles',
                                'defenceVehicles', 'rent', 'shop', 'isChatEnabled',
                                'isPromoScreenEnabled'))):
    __slots__ = ()

    def __new__(cls, **kwargs):
        defaults = dict(isEnabled=False, isBattlesEnabled={}, startDate=0, endDate=0, rewardsSettings={}, artefactsSettings={}, rent={}, vehicles=[], defenceVehicles={}, shop={}, isChatEnabled=False, isPromoScreenEnabled=False)
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


_DefenceVehiclesConfig = namedtuple('_DefenceVehiclesConfig', ('includeVehicles', 'allowedLevels',
                                                               'forbiddenClassTags',
                                                               'forbiddenVehicles'))

class HalloweenController(IHalloweenController, Notifiable, SeasonProvider, IGlobalListener, PerformanceAnalyzerMixin):
    __lobbyContext = dependency.descriptor(ILobbyContext)
    __eventsCache = dependency.descriptor(IEventsCache)
    __itemsCache = dependency.descriptor(IItemsCache)
    __hangarLoadingController = dependency.descriptor(IHangarLoadingController)
    __referralCtrl = dependency.descriptor(IReferralProgramController)
    __limitedUIController = dependency.descriptor(ILimitedUIController)
    __difficultyLevelCtrl = dependency.descriptor(IDifficultyLevelController)
    __hangarSpace = dependency.descriptor(IHangarSpace)

    def __init__(self):
        super(HalloweenController, self).__init__()
        self.__serverSettings = None
        self._prevStates = (False, {})
        self.onEventDisabled = Event.Event()
        self.onSettingsUpdate = Event.Event()
        return

    def init(self):
        super(HalloweenController, self).init()
        self._prevStates = (False, {})
        self.addNotificator(SimpleNotifier(self.__getTimer, self.__timerUpdate))
        self.__hangarLoadingController.onHangarLoadedAfterLogin += self.__onHangarLoadedAfterLogin

    def fini(self):
        self.onEventDisabled.clear()
        self.onSettingsUpdate.clear()
        self.clearNotification()
        self._prevStates = (False, {})
        self.__clear()
        self.__hangarLoadingController.onHangarLoadedAfterLogin -= self.__onHangarLoadedAfterLogin
        super(HalloweenController, self).fini()

    def onDisconnected(self):
        super(HalloweenController, self).onDisconnected()
        self._prevStates = (False, {})
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
        if isinstance(self.prbEntity, HalloweenEntity):
            accountSelectedLevel = self.__difficultyLevelCtrl.getLastSelectedLevel()
            self.__difficultyLevelCtrl.selectLevel(accountSelectedLevel)
        if self.prbEntity.getModeFlags() & FUNCTIONAL_FLAG.STRONGHOLD:
            showMainHangar()

    def isEnabled(self):
        return self.getModeSettings().isEnabled

    def isBattlesEnabled(self):
        currentQueueType = self.prbEntity.currentQueueType if self.prbEntity is not None else QUEUE_TYPE.UNKNOWN
        return self.getModeSettings().isBattlesEnabled.get(currentQueueType, False)

    def isPromoScreenEnabled(self):
        return self.getModeSettings().isPromoScreenEnabled and self.isEnabled()

    def isAvailable(self):
        return self.isEnabled() and self.__getTimer() is not None

    def getConfig(self):
        return self.__lobbyContext.getServerSettings().getSettings().get(HALLOWEEN_GAME_PARAMS_KEY, {})

    def getModeSettings(self):
        if self.getConfig():
            return makeTupleByDict(_HalloweenConfig, self.getConfig())
        return _HalloweenConfig.defaults()

    def selectBattle(self):
        self.__selectMode(PREBATTLE_ACTION_NAME.HALLOWEEN)

    def openHangar(self):
        if self.isEventHangar():
            showHangar()
        else:
            self.selectBattle()

    def isEventHangar(self):
        prbDispatcher = self.prbDispatcher
        state = prbDispatcher.getFunctionalState() if prbDispatcher is not None else None
        return state is not None and (state.isInPreQueue(QUEUE_TYPE.HALLOWEEN) or state.isInPreQueue(QUEUE_TYPE.HALLOWEEN_MEDIUM) or state.isInPreQueue(QUEUE_TYPE.HALLOWEEN_HARD) or state.isInUnit(PREBATTLE_TYPE.HALLOWEEN) or state.isInPreQueue(QUEUE_TYPE.HALLOWEEN_DEFENCE))

    def selectRandomMode(self):
        self.__selectMode(PREBATTLE_ACTION_NAME.RANDOM)

    @prbEntityProperty
    def prbEntity(self):
        pass

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

    def getDefenceVehiclesConfig(self):
        limits = self.getModeSettings().defenceVehicles
        return _DefenceVehiclesConfig(limits.get('includeVehicles', []), limits.get('allowedLevels', []), limits.get('forbiddenClassTags', []), limits.get('forbiddenVehicles', []))

    def getDefenceSuitableVehicles(self):
        vehConfig = self.getDefenceVehiclesConfig()
        hwVehicles = {self.__itemsCache.items.getItemByCD(intCD) for intCD in vehConfig.includeVehicles}
        criteria = REQ_CRITERIA.INVENTORY | ~REQ_CRITERIA.VEHICLE.HAS_ANY_TAG(DEFENCE_FORBIDDEN_VEHICLE_TAGS)
        if vehConfig.allowedLevels:
            criteria |= REQ_CRITERIA.VEHICLE.LEVELS(vehConfig.allowedLevels)
        if vehConfig.forbiddenVehicles:
            criteria |= ~REQ_CRITERIA.VEHICLE.SPECIFIC_BY_CD(vehConfig.forbiddenVehicles)
        if vehConfig.forbiddenClassTags:
            criteria |= ~REQ_CRITERIA.VEHICLE.CLASSES(vehConfig.forbiddenClassTags)
        hwVehicles.update(self.__itemsCache.items.getVehicles(criteria).values())
        return hwVehicles

    def __onServerSettingsChanged(self, serverSettings):
        if self.__serverSettings is not None:
            self.__serverSettings.onServerSettingsChange -= self.__updateEventBattlesSettings
        self.__serverSettings = serverSettings
        self.__serverSettings.onServerSettingsChange += self.__updateEventBattlesSettings
        return

    def __onHangarLoadedAfterLogin(self):
        if self.isPromoScreenEnabled() and self.__limitedUIController.isRuleCompleted(LUI_RULES.HalloweenEntryPoint):
            showPromoWindowView()
        if self.isEventHangar():
            cameraManager = CGF.getManager(self.__hangarSpace.spaceID, HangarCameraManager)
            if cameraManager:
                cameraManager.enablePlatoonMode(False)

    def __updateEventBattlesSettings(self, diff):
        if HALLOWEEN_GAME_PARAMS_KEY in diff:
            self.startNotification()
            self.onSettingsUpdate()
            if not self.isAvailable():
                self.__closeHalloweenViews()
                self.onEventDisabled()
            self.__updateStates()

    def __updateStates(self):
        wasEnabled, wasBattlesEnabled = self._prevStates
        modeSettings = self.getModeSettings()
        isEnabled, isBattlesEnabled = self._prevStates = (modeSettings.isEnabled, modeSettings.isBattlesEnabled.copy())
        if self.__getTimer() is None:
            return
        else:
            systemMessages = []
            for queueType, queueTypeEnabled in isBattlesEnabled.items():
                if wasBattlesEnabled.get(queueType, False) and not queueTypeEnabled:
                    systemMessages.append(backport.text(R.strings.halloween_system_messages.serviceChannelMessages.switchedOffDifficulty(), difficulty=self.__getQueueTypeLocalizedName(queueType)))

            if len(systemMessages) == len(isBattlesEnabled):
                systemMessages = [
                 backport.text(R.strings.halloween_system_messages.serviceChannelMessages.switchedOff())]
            if wasEnabled != isEnabled and not isEnabled:
                systemMessages.append(backport.text(R.strings.halloween_system_messages.serviceChannelMessages.switchedOffFull()))
            for message in systemMessages:
                SystemMessages.pushMessage(message, type=SystemMessages.SM_TYPE.Error, priority=NotificationPriorityLevel.MEDIUM)

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
        self.__closeHalloweenViews()
        self.onEventDisabled()

    def __closeHalloweenViews(self):
        if not self.isEventHangar():
            return
        closeViewsByID([
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

    @adisp.adisp_process
    def __selectMode(self, name):
        dispatcher = self.prbDispatcher
        if dispatcher is None:
            return
        else:
            isHalloweenMode = name == PREBATTLE_ACTION_NAME.HALLOWEEN
            result = yield dispatcher.doSelectAction(PrbAction(name), fadeCtx={'layer': WindowLayer.OVERLAY, 
               'waitForLayoutReady': R.views.halloween.lobby.HangarView() if isHalloweenMode else None})
            if not result:
                return
            if isHalloweenMode:
                showHangar()
            return

    @staticmethod
    def __getQueueTypeLocalizedName(queueType):
        difficultyLevel = QUEUE_TYPE_TO_DIFFICULTY_LEVEL[queueType].value
        return backport.text(R.strings.halloween_lobby.difficult.dyn(('level_{}').format(difficultyLevel))())