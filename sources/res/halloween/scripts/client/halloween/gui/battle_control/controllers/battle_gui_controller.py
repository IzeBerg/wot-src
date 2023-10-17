import BigWorld, logging
from Event import EventManager, Event
from battleground.location_point_manager import g_locationPointManager
from chat_commands_consts import BATTLE_CHAT_COMMAND_NAMES
from messenger_common_chat2 import MESSENGER_ACTION_IDS as _ACTIONS
from halloween.gui.halloween_gui_constants import BATTLE_CTRL_ID, FEEDBACK_EVENT_ID
from halloween.gui.scaleform.daapi.view.battle.buffs_notification_panel import BuffsNotificationSystem
from helpers import dependency, isPlayerAvatar
from skeletons.gui.battle_session import IBattleSessionProvider
from HWArenaPhasesComponent import HWArenaPhasesComponent
from gui.battle_control.arena_info.interfaces import IArenaVehiclesController
from halloween.gui.battle_control.halloween_battle_constants import VEHICLE_VIEW_STATE
from helpers.CallbackDelayer import CallbackDelayer
from HWTeamInfoStatsComponent import HWTeamInfoStatsComponent
_logger = logging.getLogger(__name__)

class EventBattleGoal(object):
    UNKNOWN = None
    COLLECT_SOULS = 'collectSouls'
    DELIVER_SOULS = 'deliverSouls'
    GET_TO_COLLECTOR = 'getToCollector'


class HWBattleGUIController(IArenaVehiclesController):
    guiSessionProvider = dependency.descriptor(IBattleSessionProvider)
    _TIME_TO_END_NOTIFY = 10
    _UPDATE_PERIOD = 0.5

    def __init__(self):
        super(HWBattleGUIController, self).__init__()
        self.__eManager = EventManager()
        self.onApplyBuff = Event(self.__eManager)
        self.onUnapplyBuff = Event(self.__eManager)
        self.onBuffStateChanged = Event(self.__eManager)
        self.onVehicleDetectorChangeDistance = Event(self.__eManager)
        self.onBattleGoalChanged = Event(self.__eManager)
        self.onBossAuraVictimMarkerIcon = Event(self.__eManager)
        self.onVehicleBuffIconAdded = Event(self.__eManager)
        self.onVehicleBuffIconRemoved = Event(self.__eManager)
        self.onPhaseChanged = Event(self.__eManager)
        self.onSoulCollectorProgress = Event(self.__eManager)
        self.onHandleEquipmentPressed = Event(self.__eManager)
        self.onShowPanelBuffNotification = Event(self.__eManager)
        self._callbackDelayer = CallbackDelayer()
        self._currentGoal = EventBattleGoal.UNKNOWN
        self._currentCollector = None
        self._vehiclesInRadius = set()
        self._isCollectorFull = False
        return

    @property
    def currentGoal(self):
        return self._currentGoal

    def getControllerID(self):
        return BATTLE_CTRL_ID.HW_BATTLE_GUI_CTRL

    def startControl(self, battleCtx, arenaVisitor):
        super(HWBattleGUIController, self).startControl(battleCtx, arenaVisitor)
        self._callbackDelayer.delayCallback(self._UPDATE_PERIOD, self._update)
        HWArenaPhasesComponent.onPhaseChanged += self._onPhaseChanged
        HWArenaPhasesComponent.onPhaseTimeChanged += self._onPhaseTimeChanged

    def stopControl(self):
        HWArenaPhasesComponent.onPhaseChanged -= self._onPhaseChanged
        HWArenaPhasesComponent.onPhaseTimeChanged -= self._onPhaseTimeChanged
        self._callbackDelayer.clearCallbacks()
        self.__eManager.clear()
        self._currentCollector = None
        super(HWBattleGUIController, self).stopControl()
        return

    @property
    def battleHintsCtrl(self):
        return self.guiSessionProvider.dynamic.battleHints

    def onSoulsCollectorSpawned(self, collector):
        self._currentCollector = collector

    def onSoulsCollectorDestroyed(self, collector):
        if self._currentCollector == collector:
            self._currentCollector = None
        self.guiSessionProvider.invalidateVehicleState(VEHICLE_VIEW_STATE.COLLECTOR_FULL, False)
        self.guiSessionProvider.invalidateVehicleState(VEHICLE_VIEW_STATE.COLLECTOR_FILL, None)
        self._isCollectorFull = False
        self._vehiclesInRadius = set()
        return

    def applyBuff(self, ctx):
        if not self._isPlayerVehicle(ctx.get('vehicleID')):
            return
        self.onApplyBuff(ctx)
        if self.battleHintsCtrl:
            self.battleHintsCtrl.showHint(BuffsNotificationSystem.BATTLE_HINT_TEMPLATE, ctx)

    def unapplyBuff(self, ctx):
        if not self._isPlayerVehicle(ctx.get('vehicleID')):
            return
        self.onUnapplyBuff(ctx)
        if self.battleHintsCtrl:
            self.battleHintsCtrl.hideHint(BuffsNotificationSystem.BATTLE_HINT_TEMPLATE)

    def buffStateChanged(self, ctx):
        if self._isPlayerVehicle(ctx.get('vehicleID')):
            self.onBuffStateChanged(ctx)

    def vehicleDetectorChangeDistance(self, ctx):
        self.onVehicleDetectorChangeDistance(ctx)

    def getCurrentCollectorSoulsInfo(self):
        if self._currentCollector:
            return (self._currentCollector.collected, self._currentCollector.capacity)
        else:
            return (None, None)

    def updateCollector(self, collector):
        guiSessionProvider = self.guiSessionProvider
        vehicle = BigWorld.player().vehicle
        if not vehicle:
            return
        else:
            vehicleID = vehicle.id
            if vehicleID in collector.vehiclesInRadius:
                isEmpty = collector.vehicleStats.getSouls(vehicleID) == 0
                teamSouls = collector.vehicleStats.getTeamSouls() if collector.vehicleStats else 0
                enoughSouls = teamSouls >= collector.capacity - collector.collected
                isFull = collector.isFull and self._isCollectorFull
                stateValue = None if isEmpty or isFull else (collector.collected, collector.capacity, enoughSouls)
                guiSessionProvider.invalidateVehicleState(VEHICLE_VIEW_STATE.COLLECTOR_FILL, stateValue)
                if collector.isFull and vehicle.isAlive():
                    arenaDP = guiSessionProvider.getArenaDP()
                    alivePlayerNotInRadius = any(vInfo for vInfo in arenaDP.getVehiclesInfoIterator() if vInfo.player.accountDBID > 0 and vInfo.team == arenaDP.getAllyTeams()[0] and vInfo.isAlive() and vInfo.vehicleID not in collector.vehiclesInRadius)
                    if alivePlayerNotInRadius:
                        self._callbackDelayer.delayCallback(self._UPDATE_PERIOD, lambda : guiSessionProvider.invalidateVehicleState(VEHICLE_VIEW_STATE.COLLECTOR_FULL, True))
                    if not self._isCollectorFull:
                        self._callbackDelayer.delayCallback(self._UPDATE_PERIOD, self._onCollectorFull)
            removed = set(self._vehiclesInRadius) - set(collector.vehiclesInRadius)
            if vehicleID in removed:
                guiSessionProvider.invalidateVehicleState(VEHICLE_VIEW_STATE.COLLECTOR_FILL, None)
                guiSessionProvider.invalidateVehicleState(VEHICLE_VIEW_STATE.COLLECTOR_FULL, False)
            self._vehiclesInRadius = set(collector.vehiclesInRadius)
            self.onSoulCollectorProgress(collector.isFull)
            return

    def _onCollectorFull(self):
        self.guiSessionProvider.invalidateVehicleState(VEHICLE_VIEW_STATE.COLLECTOR_FILL, None)
        self._isCollectorFull = True
        return

    def setVehicleMaxHealth(self, isPlayerVehicle, vehicleID, newHealth):
        if not isPlayerVehicle:
            ctrl = self.guiSessionProvider.shared.feedback
            if ctrl is not None:
                ctrl.onVehicleFeedbackReceived(FEEDBACK_EVENT_ID.HW_VEHICLE_MARKER_HEALTH, vehicleID, newHealth)
        return

    def _onPhaseChanged(self, arenaPhases):
        self._callbackDelayer.delayCallback(self._UPDATE_PERIOD, lambda : self.guiSessionProvider.invalidateVehicleState(VEHICLE_VIEW_STATE.COLLECTOR_FULL, False))
        self.guiSessionProvider.invalidateVehicleState(VEHICLE_VIEW_STATE.PHASE_END, (None, False))
        self.__removeAllLocationMarkers()
        self.onPhaseChanged()
        return

    def _onPhaseTimeChanged(self, timeLeft, prev, lastPhase):
        if lastPhase:
            return
        else:
            if timeLeft < self._TIME_TO_END_NOTIFY and (self._TIME_TO_END_NOTIFY <= prev or timeLeft == prev):
                collector = self._currentCollector
                isFull = collector and collector.isFull
                self.guiSessionProvider.invalidateVehicleState(VEHICLE_VIEW_STATE.PHASE_END, (timeLeft, isFull))
            if timeLeft <= 0:
                self.guiSessionProvider.invalidateVehicleState(VEHICLE_VIEW_STATE.PHASE_END, (None, False))
            return

    def _update(self):
        if not isPlayerAvatar():
            return self._UPDATE_PERIOD
        relevantGoal = self._getRelevantGoal()
        if relevantGoal != self._currentGoal:
            self._showRelevantBattleHint(self._currentGoal, relevantGoal)
            self._currentGoal = relevantGoal
            self.onBattleGoalChanged(relevantGoal)
        return self._UPDATE_PERIOD

    def _getRelevantGoal(self):
        collector = self._currentCollector
        if collector is None or collector.capacity <= 0:
            return EventBattleGoal.UNKNOWN
        else:
            if collector.isFull:
                return EventBattleGoal.GET_TO_COLLECTOR
            aliveVehiclesSouls = self._getAliveAllyVehiclesSouls()
            if not aliveVehiclesSouls:
                return EventBattleGoal.UNKNOWN
            playersSoulsCount = sum(aliveVehiclesSouls, 0)
            if collector.collected + playersSoulsCount >= collector.capacity:
                return EventBattleGoal.DELIVER_SOULS
            return EventBattleGoal.COLLECT_SOULS

    def _getAliveAllyVehiclesSouls(self):
        teamStats = HWTeamInfoStatsComponent.getInstance()
        arenaDP = self.guiSessionProvider.getArenaDP()
        return [ teamStats.getSouls(vInfo.vehicleID) if teamStats else 0 for vInfo in arenaDP.getVehiclesInfoIterator() if arenaDP.isAllyTeam(vInfo.team) and vInfo.isAlive()
               ]

    def _showRelevantBattleHint(self, prevGoal, newGoal):
        if self.battleHintsCtrl is None:
            return
        else:
            if prevGoal is not None:
                self.battleHintsCtrl.removeHintFromQueue(prevGoal)
                self.battleHintsCtrl.hideHint(prevGoal)
            if newGoal is None:
                return
            self.battleHintsCtrl.showHint(newGoal)
            return

    def _isPlayerVehicle(self, vehicleID):
        player = BigWorld.player()
        if not player:
            return False
        return vehicleID == player.playerVehicleID

    def __removeAllLocationMarkers(self):
        markedAreas = g_locationPointManager.markedAreas
        chatCommands = self.guiSessionProvider.shared.chatCommands
        removeIDList = markedAreas.keys()
        advChatCmp = getattr(self.guiSessionProvider.arenaVisitor.getComponentSystem(), 'advancedChatComponent', None)
        for targetID in removeIDList:
            markerData = markedAreas[targetID]
            action = _ACTIONS.battleChatCommandFromActionID(markerData.commandID).name
            if action == BATTLE_CHAT_COMMAND_NAMES.GOING_THERE:
                chatCommands.sendCancelReplyChatCommand(targetID, action)
            elif advChatCmp:
                advChatCmp._tryRemovingCommandFromMarker(markerData.commandID, targetID, forceRemove=True)

        return