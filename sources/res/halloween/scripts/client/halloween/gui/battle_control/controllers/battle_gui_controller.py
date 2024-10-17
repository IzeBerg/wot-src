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
_logger = logging.getLogger(__name__)

class EventBattleGoal(object):
    UNKNOWN = None
    COLLECT_SOULS = 'halloween.collectSouls'
    GET_TO_COLLECTOR = 'halloween.getToCollector'


class HWBattleGUIController(IArenaVehiclesController):
    guiSessionProvider = dependency.descriptor(IBattleSessionProvider)
    _TIME_TO_END_NOTIFY = 10
    _UPDATE_PERIOD = 0.5

    def __init__(self):
        super(HWBattleGUIController, self).__init__()
        self._eManager = EventManager()
        self.onApplyBuff = Event(self._eManager)
        self.onUnapplyBuff = Event(self._eManager)
        self.onBuffStateChanged = Event(self._eManager)
        self.onVehicleDetectorChangeDistance = Event(self._eManager)
        self.onBattleGoalChanged = Event(self._eManager)
        self.onBossAuraVictimMarkerIcon = Event(self._eManager)
        self.onVehicleBuffIconAdded = Event(self._eManager)
        self.onVehicleBuffIconRemoved = Event(self._eManager)
        self.onPhaseChanged = Event(self._eManager)
        self.onSoulCollectorProgress = Event(self._eManager)
        self.onHandleEquipmentPressed = Event(self._eManager)
        self.onShowPanelBuffNotification = Event(self._eManager)
        self.onBossHealthActivated = Event(self._eManager)
        self.onBossHealthChanged = Event(self._eManager)
        self.onBossLivesChanged = Event(self._eManager)
        self.onSoulsContainerReady = Event(self._eManager)
        self._callbackDelayer = CallbackDelayer()
        self._currentGoal = EventBattleGoal.UNKNOWN
        self._currentCollector = None
        self._vehiclesInRadius = set()
        self._isCollectorFull = False
        self._vehicleMarkerIcons = {}
        self._hiddenVehicleIDs = set()
        self._pendingHint = None
        return

    @property
    def currentGoal(self):
        return self._currentGoal

    @property
    def vehicleMarkerIcons(self):
        return self._vehicleMarkerIcons

    @property
    def battleHintsCtrl(self):
        return self.guiSessionProvider.dynamic.battleHints

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
        self._eManager.clear()
        self._vehicleMarkerIcons.clear()
        self._hiddenVehicleIDs.clear()
        self._currentCollector = None
        self._pendingHint = None
        super(HWBattleGUIController, self).stopControl()
        return

    def onSoulsCollectorSpawned(self, collector):
        self._currentCollector = collector

    def onSoulsCollectorDestroyed(self, collector):
        if self._currentCollector == collector:
            self._currentCollector = None
        self.guiSessionProvider.invalidateVehicleState(VEHICLE_VIEW_STATE.COLLECTOR_FULL, False)
        self._isCollectorFull = False
        self._vehiclesInRadius = set()
        return

    def setVehicleHidden(self, vehicleID, isHidden):
        if isHidden:
            self.guiSessionProvider.shared.feedback.onVehicleMarkerRemoved(vehicleID)
            self._hiddenVehicleIDs.add(vehicleID)
        else:
            self._hiddenVehicleIDs.discard(vehicleID)

    def isVehicleHidden(self, vehicleID):
        return vehicleID in self._hiddenVehicleIDs

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

    def addVehicleMarkerIcon(self, vehicleID, iconName):
        self._vehicleMarkerIcons.setdefault(vehicleID, set()).add(iconName)
        self.onVehicleBuffIconAdded(vehicleID, iconName)

    def removeVehicleMarkerIcon(self, vehicleID, iconName):
        self._vehicleMarkerIcons.get(vehicleID, set()).discard(iconName)
        self.onVehicleBuffIconRemoved(vehicleID, iconName)

    def vehicleDetectorChangeDistance(self, ctx):
        self.onVehicleDetectorChangeDistance(ctx)

    def getCurrentCollectorSoulsInfo(self):
        if self._currentCollector:
            return (self._currentCollector.collected, self._currentCollector.capacity)
        else:
            return (None, None)

    def updateCollector(self, collector):
        guiSessionProvider = self.guiSessionProvider
        vehicle = BigWorld.player().getVehicleAttached()
        if not vehicle:
            return
        vehicleID = vehicle.id
        if vehicleID in collector.vehiclesInRadius:
            if collector.isFull and vehicle.isAlive():
                arenaDP = guiSessionProvider.getArenaDP()
                alivePlayerNotInRadius = any(vInfo for vInfo in arenaDP.getVehiclesInfoIterator() if vInfo.player.accountDBID > 0 and vInfo.team == arenaDP.getAllyTeams()[0] and vInfo.isAlive() and vInfo.vehicleID not in collector.vehiclesInRadius)
                if alivePlayerNotInRadius:
                    self._callbackDelayer.delayCallback(self._UPDATE_PERIOD, lambda : guiSessionProvider.invalidateVehicleState(VEHICLE_VIEW_STATE.COLLECTOR_FULL, True))
                if not self._isCollectorFull:
                    self._callbackDelayer.delayCallback(self._UPDATE_PERIOD, self._onCollectorFull)
        removed = set(self._vehiclesInRadius) - set(collector.vehiclesInRadius)
        if vehicleID in removed:
            guiSessionProvider.invalidateVehicleState(VEHICLE_VIEW_STATE.COLLECTOR_FULL, False)
        self._vehiclesInRadius = set(collector.vehiclesInRadius)
        self.onSoulCollectorProgress(collector.collected, collector.capacity, collector.isFull)

    def _onCollectorFull(self):
        self._isCollectorFull = True

    def setVehicleMaxHealth(self, vehicleID, maxHealth):
        ctrl = self.guiSessionProvider.shared.feedback
        if ctrl is not None:
            ctrl.onVehicleFeedbackReceived(FEEDBACK_EVENT_ID.HW_VEHICLE_MARKER_HEALTH, vehicleID, maxHealth)
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
            vehicle = BigWorld.player().vehicle
            if vehicle is None or not vehicle.isAlive() or timeLeft <= 0:
                self.guiSessionProvider.invalidateVehicleState(VEHICLE_VIEW_STATE.PHASE_END, (None, False))
            elif timeLeft < self._TIME_TO_END_NOTIFY and (self._TIME_TO_END_NOTIFY <= prev or timeLeft == prev):
                collector = self._currentCollector
                isFull = collector and collector.isFull
                self.guiSessionProvider.invalidateVehicleState(VEHICLE_VIEW_STATE.PHASE_END, (timeLeft, isFull))
            return

    def _update(self):
        if not isPlayerAvatar():
            return self._UPDATE_PERIOD
        else:
            relevantGoal = self._getRelevantGoal()
            if relevantGoal != self._currentGoal:
                self.onBattleGoalChanged(relevantGoal)
                self._pendingHint = (self._currentGoal, relevantGoal)
                self._currentGoal = relevantGoal
            if self._pendingHint is not None and self._showRelevantBattleHint(*self._pendingHint):
                self._pendingHint = None
            return self._UPDATE_PERIOD

    def _getRelevantGoal(self):
        collector = self._currentCollector
        if collector is None or collector.capacity <= 0:
            return EventBattleGoal.UNKNOWN
        else:
            if collector.isFull:
                return EventBattleGoal.GET_TO_COLLECTOR
            if not self._getAliveAllyVehicles():
                return EventBattleGoal.UNKNOWN
            return EventBattleGoal.COLLECT_SOULS

    def _getAliveAllyVehicles(self):
        arenaDP = self.guiSessionProvider.getArenaDP()
        return [ vInfo.vehicleID for vInfo in arenaDP.getVehiclesInfoIterator() if arenaDP.isAllyTeam(vInfo.team) and vInfo.isAlive()
               ]

    def _showRelevantBattleHint(self, prevGoal, newGoal):
        if self.battleHintsCtrl is None:
            _logger.warning('BattleHintsController is not loaded. Battle hint (%s) will not be displayed.', newGoal)
            return False
        else:
            if prevGoal is not None:
                self.battleHintsCtrl.removeHint(prevGoal, hide=True)
            if newGoal is None:
                return True
            self.battleHintsCtrl.showHint(newGoal, params=self._getHintParams())
            success = self.battleHintsCtrl.checkHintInQueue(newGoal)
            if not success:
                _logger.warning('Hint (%s) will not be displayed. Will retry on the next update.', newGoal)
            return success

    def _isPlayerVehicle(self, vehicleID):
        player = BigWorld.player()
        if not player:
            return False
        return vehicleID == player.playerVehicleID

    def _getHintParams(self):
        return

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