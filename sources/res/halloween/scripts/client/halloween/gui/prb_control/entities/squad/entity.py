import typing, json
from frameworks.wulf import WindowLayer
from wg_async import wg_await, wg_async
import account_helpers
from debug_utils import LOG_ERROR
from gui.ClientUpdateManager import g_clientUpdateManager
from gui.prb_control import prb_getters, prbEntityProperty
from gui.prb_control.entities.base.squad.entity import SquadEntryPoint, SquadEntity
from gui.prb_control.storages import storage_getter, RECENT_PRB_STORAGE
from gui.prb_control.settings import REQUEST_TYPE
from gui.prb_control.events_dispatcher import g_eventDispatcher
from gui.impl.gen import R
from gui.impl.pub.dialog_window import DialogButtons
from gui.impl.dialogs.gf_builders import ResDialogBuilder
from gui.impl.common.fade_manager import UseFading
from halloween.gui.prb_control.entities.squad.ctx import SetDifficultyLevelUnitCtx, HalloweenSquadSettingsCtx
from halloween.gui.prb_control.entities.vehicles_watcher import HalloweenVehiclesWatcher, HalloweenDefenceVehiclesWatcher
from halloween.gui.shared.event_dispatcher import showHangar, isHangarLoaded
from halloween.gui.prb_control.entities.vehicle_switcher import VehicleSwitcher
from halloween.skeletons.difficulty_level_controller import IDifficultyLevelController
from helpers import dependency
from halloween.gui.prb_control.entities.squad.actions_validator import HalloweenSquadActionsValidator, HalloweenSquadActionsHandler
from halloween.gui.prb_control.entities.squad.scheduler import HalloweenSquadScheduler
from skeletons.gui.lobby_context import ILobbyContext
from skeletons.gui.server_events import IEventsCache
from halloween.gui.halloween_gui_constants import PREBATTLE_ACTION_NAME, FUNCTIONAL_FLAG
from halloween.gui.halloween_gui_constants import QUEUE_TYPE_TO_DIFFICULTY_LEVEL
from halloween_common.halloween_constants import PREBATTLE_TYPE, QUEUE_TYPE, CURRENT_QUEUE_TYPE_KEY, CLIENT_UNIT_CMD
from halloween.skeletons.halloween_controller import IHalloweenController

class HalloweenEntryPoint(SquadEntryPoint):
    __difficultyLevelCtrl = dependency.descriptor(IDifficultyLevelController)

    def __init__(self, accountsToInvite=None):
        super(HalloweenEntryPoint, self).__init__(FUNCTIONAL_FLAG.HALLOWEEN, accountsToInvite)
        self.arenaUniqueID = None
        return

    def makeDefCtx(self):
        return HalloweenSquadSettingsCtx(waitingID='prebattle/create', accountsToInvite=self._accountsToInvite, arenaUniqueID=self.arenaUniqueID)

    def setExtData(self, extData):
        self.arenaUniqueID = extData.get('arenaUniqueID')

    def _doCreate(self, unitMgr, ctx):
        unitExtrasInit = json.dumps({CURRENT_QUEUE_TYPE_KEY: self.__difficultyLevelCtrl.getCurrentQueueType()})
        unitMgr.createSquadByQueueType(QUEUE_TYPE.HALLOWEEN, unitExtrasInitStr=unitExtrasInit)


class HalloweenSquadEntity(SquadEntity, VehicleSwitcher):
    __difficultyLevelCtrl = dependency.descriptor(IDifficultyLevelController)

    def setReserve(self, ctx, callback=None):
        pass

    eventsCache = dependency.descriptor(IEventsCache)
    lobbyContext = dependency.descriptor(ILobbyContext)
    halloweenBattleCtrl = dependency.descriptor(IHalloweenController)

    def __init__(self):
        super(HalloweenSquadEntity, self).__init__(FUNCTIONAL_FLAG.HALLOWEEN, PREBATTLE_TYPE.HALLOWEEN)
        self._mmData = 0
        self.__watcher = None
        return

    @storage_getter(RECENT_PRB_STORAGE)
    def storage(self):
        return

    @property
    def currentQueueType(self):
        return self.__difficultyLevelCtrl.getCurrentQueueType()

    @prbEntityProperty
    def prbEntity(self):
        return

    def init(self, ctx=None):
        rv = super(HalloweenSquadEntity, self).init(ctx)
        self.__updateQueueTypeFromUnit()
        self.startSwitcher()
        self._switchActionsValidator()
        self._switchRosterSettings()
        self.invalidateVehicleStates()
        self.lobbyContext.getServerSettings().onServerSettingsChange += self._onServerSettingChanged
        self.eventsCache.onSyncCompleted += self._onServerSettingChanged
        self.__difficultyLevelCtrl.onChangeDifficultyLevel += self._updateEntityType
        g_clientUpdateManager.addCallbacks({'inventory.1': self._onInventoryVehiclesUpdated})
        self.__updateVehiclesWatcher()
        return rv

    def fini(self, ctx=None, woEvents=False):
        self.lobbyContext.getServerSettings().onServerSettingsChange -= self._onServerSettingChanged
        self.eventsCache.onSyncCompleted -= self._onServerSettingChanged
        self.__difficultyLevelCtrl.onChangeDifficultyLevel -= self._updateEntityType
        self.__difficultyLevelCtrl.onLevelsInfoReady -= self._onLevelsInfoReady
        g_clientUpdateManager.removeObjectCallbacks(self, force=True)
        self.stopSwitcher()
        self.invalidateVehicleStates()
        if self.__watcher is not None:
            self.__watcher.stop()
            self.__watcher = None
        return super(HalloweenSquadEntity, self).fini(ctx=ctx, woEvents=woEvents)

    def leave(self, ctx, callback=None):
        if ctx.hasFlags(FUNCTIONAL_FLAG.SWITCH):
            self.storage.queueType = QUEUE_TYPE.UNKNOWN
        if ctx.hasFlags(FUNCTIONAL_FLAG.EXIT):
            super(HalloweenSquadEntity, self).leave(ctx, callback)
        else:
            self.__leaveWithFade(ctx, callback=callback)

    def getQueueType(self):
        return self.storage.queueType

    def doAction(self, action=None):
        self._mmData = 0 if action is None else action.mmData
        super(HalloweenSquadEntity, self).doAction(action)
        return

    def doBattleQueue(self, ctx, callback=None):
        ctx.mmData = self._mmData
        self._mmData = 0
        super(HalloweenSquadEntity, self).doBattleQueue(ctx, callback)

    def unit_onUnitVehicleChanged(self, dbID, vehInvID, vehTypeCD):
        super(HalloweenSquadEntity, self).unit_onUnitVehicleChanged(dbID, vehInvID, vehTypeCD)
        self._onUnitMemberVehiclesChanged(dbID)

    def unit_onUnitVehiclesChanged(self, dbID, vehicles):
        super(HalloweenSquadEntity, self).unit_onUnitVehiclesChanged(dbID, vehicles)
        self._onUnitMemberVehiclesChanged(dbID)

    def unit_onUnitPlayerRoleChanged(self, playerID, prevRoleFlags, nextRoleFlags):
        super(HalloweenSquadEntity, self).unit_onUnitPlayerRoleChanged(playerID, prevRoleFlags, nextRoleFlags)
        if playerID == account_helpers.getAccountDatabaseID():
            self.unit_onUnitRosterChanged()

    def unit_onUnitPlayerRemoved(self, playerID, playerData):
        super(HalloweenSquadEntity, self).unit_onUnitPlayerRemoved(playerID, playerData)
        if playerID == account_helpers.getAccountDatabaseID():
            self.unit_onUnitRosterChanged()

    def unit_onUnitExtraChanged(self, extras):
        super(HalloweenSquadEntity, self).unit_onUnitExtraChanged(extras)
        queueType = extras.get(CURRENT_QUEUE_TYPE_KEY)
        levelFromQueue = QUEUE_TYPE_TO_DIFFICULTY_LEVEL[queueType]
        for item in self.__difficultyLevelCtrl.getLevelsInfo():
            if item.level == levelFromQueue:
                self.__difficultyLevelCtrl.selectLevel(levelFromQueue)
                self.selectModeVehicle()
                break

    def getConfirmDialogMeta(self, ctx):
        if not self.halloweenBattleCtrl.isAvailable():
            builder = self.__getLeaveSquadBuilder(R.strings.halloween_lobby.squad.leave.disabledEvent)
            self.__showBuilderDialog(builder, None)
            return
        else:
            if self.hasLockedState():
                return self.__getLeaveSquadBuilder(R.strings.halloween_lobby.squad.leaveDisabled)
            if self.isCommander() and len(self.getPlayers()) == 1:
                return
            return self.__createUnitLeaveMeta(ctx, self.canSwitch(ctx))

    def showDialog(self, builder, callback, parent=None):
        self.__showBuilderDialog(builder, callback)

    def loadHangar(self):
        if not isHangarLoaded():
            showHangar()

    def _onServerSettingChanged(self, *args, **kwargs):
        self.invalidateVehicleStates()
        self._switchActionsValidator()
        self.unit_onUnitRosterChanged()

    def _onInventoryVehiclesUpdated(self, diff):
        self.invalidateVehicleStates()

    def _setDifficultyLevel(self, ctx, callback=None):
        pPermissions = self.getPermissions()
        if not pPermissions.canChangeRosters():
            LOG_ERROR('Player can not change difficulty level', pPermissions)
            if callback:
                callback(False)
            return
        self._requestsProcessor.doRequest(ctx, 'doUnitCmd', CLIENT_UNIT_CMD.SET_UNIT_DIFFICULTY_LEVEL, ctx.getQueueType(), 0, '', callback=callback)
        self._cooldown.process(REQUEST_TYPE.CHANGE_SETTINGS, coolDown=ctx.getCooldown())

    def _onUnitMemberVehiclesChanged(self, accoundDbID):
        self.invalidateVehicleStates()
        if accoundDbID != account_helpers.getAccountDatabaseID():
            self.unit_onUnitRosterChanged()

    def _createActionsHandler(self):
        return HalloweenSquadActionsHandler(self)

    def _createActionsValidator(self):
        return HalloweenSquadActionsValidator(self)

    def _createScheduler(self):
        return HalloweenSquadScheduler(self)

    def _goToHangar(self):
        if self.getPlayerInfo().isReady and self.getFlags().isInQueue():
            g_eventDispatcher.loadBattleQueue()
        elif not isHangarLoaded():
            showHangar()

    def _updateEntityType(self, *args, **kwargs):
        self.storage.queueType = self.currentQueueType
        self.__updateVehiclesWatcher()
        self.selectModeVehicle()
        pInfo = self.getPlayerInfo()
        if not pInfo.isCommander():
            return
        ctx = SetDifficultyLevelUnitCtx(self.currentQueueType, waitingID='prebattle/change_settings')
        self._setDifficultyLevel(ctx)

    def _onLevelsInfoReady(self):
        self.__difficultyLevelCtrl.onLevelsInfoReady -= self._onLevelsInfoReady
        self.__updateQueueTypeFromUnit()
        self.__updateVehiclesWatcher()
        self.selectModeVehicle()

    @property
    def _showUnitActionNames(self):
        return (PREBATTLE_ACTION_NAME.HALLOWEEN, PREBATTLE_ACTION_NAME.HALLOWEEN_SQUAD)

    def __createUnitLeaveMeta(self, unlockCtx, isSwitching=False):
        isHWEntityCtx = unlockCtx.getEntityType() == PREBATTLE_TYPE.HALLOWEEN
        if (unlockCtx.hasFlags(FUNCTIONAL_FLAG.SWITCH) or isSwitching) and not isHWEntityCtx or unlockCtx.hasFlags(FUNCTIONAL_FLAG.EXIT) and isHWEntityCtx:
            return self.__getLeaveSquadBuilder(R.strings.halloween_lobby.squad.leave)
        return self.__getLeaveSquadBuilder(R.strings.halloween_lobby.squad.goToAnother)

    def __getLeaveSquadBuilder(self, key):
        builder = ResDialogBuilder()
        builder.setMessagesAndButtons(key, buttons=key)
        builder.setLayer(WindowLayer.OVERLAY)
        builder.setIcon(R.images.halloween.gui.maps.icons.platoon.logo_180(), backgrounds=[
         R.images.gui.maps.uiKit.dialogs.highlights.green()])
        return builder

    @wg_async
    def __showBuilderDialog(self, builder, callback):
        from gui.impl.dialogs import dialogs
        result = yield wg_await(dialogs.show(builder.build()))
        if callback is not None:
            callback(result.result == DialogButtons.SUBMIT)
        return

    def __updateVehiclesWatcher(self):
        if self.storage.queueType == QUEUE_TYPE.HALLOWEEN_DEFENCE:
            watcherType = HalloweenDefenceVehiclesWatcher
        else:
            watcherType = HalloweenVehiclesWatcher
        if isinstance(self.__watcher, watcherType):
            return
        else:
            if self.__watcher is not None:
                self.__watcher.stop()
            self.__watcher = watcherType()
            self.__watcher.start()
            return

    @UseFading(layer=WindowLayer.OVERLAY)
    def __leaveWithFade(self, ctx, callback=None):
        super(HalloweenSquadEntity, self).leave(ctx, callback)

    def __updateQueueTypeFromUnit(self):
        unit = prb_getters.getUnit(safe=True)
        if unit:
            levelsInfo = self.__difficultyLevelCtrl.getLevelsInfo()
            if levelsInfo:
                queueType = unit._extras.get(CURRENT_QUEUE_TYPE_KEY)
                levelFromQueue = QUEUE_TYPE_TO_DIFFICULTY_LEVEL[queueType]
                for item in levelsInfo:
                    if item.level == levelFromQueue:
                        self.__difficultyLevelCtrl.selectLevel(levelFromQueue)

            else:
                self.__difficultyLevelCtrl.onLevelsInfoReady += self._onLevelsInfoReady
        self.storage.queueType = self.currentQueueType