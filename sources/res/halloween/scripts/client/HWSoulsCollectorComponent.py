import functools, CGF, Event, constants
from halloween.cgf_components.soul_collector_components import SoulCollectorComponent
from script_component.DynamicScriptComponent import DynamicScriptComponent
from WeakMethod import WeakMethod
from helpers.CallbackDelayer import CallbackDelayer
from halloween.gui.halloween_gui_constants import BATTLE_CTRL_ID
from halloween.gui.sounds.souls_collector_sound import SoulsCollectorSound
from helpers import dependency
from skeletons.gui.battle_session import IBattleSessionProvider
from HWTeamInfoStatsComponent import HWTeamInfoStatsComponent
from halloween_dyn_object_cache import HWPrefabs, getPrefabPath

def _onPrefabLoaded(callback, go):
    if callback() is None:
        CGF.removeGameObject(go)
        return
    else:
        callback()(go)
        return


class HWSoulsCollectorComponent(DynamicScriptComponent):
    POLL_RATE = 0.01
    guiSessionProvider = dependency.descriptor(IBattleSessionProvider)

    def __init__(self):
        super(HWSoulsCollectorComponent, self).__init__()
        self.onUpdateSoulsCollectorState = Event.Event()
        self.onUpdateSoulsCollectorProgress = Event.Event()
        self.go = None
        self._visualComponent = None
        self._soundComponent = None
        self._callbacks = CallbackDelayer()
        return

    def onDestroy(self):
        if self.hwBattleGuiCtrl:
            self.hwBattleGuiCtrl.onSoulsCollectorDestroyed(self)
        if self.vehicleStats:
            self.vehicleStats.onTeamSoulsUpdated -= self.onTeamSoulsUpdated
        self._callbacks.destroy()
        if self._visualComponent:
            self._visualComponent.onDestroy()
            self._visualComponent = None
        if self._soundComponent:
            self._soundComponent.destroy()
            self._soundComponent = None
        if self.go:
            CGF.removeGameObject(self.go)
            self.go = None
        self.onUpdateSoulsCollectorState.clear()
        self.onUpdateSoulsCollectorProgress.clear()
        return

    def set_capacity(self, prev):
        self.updateVisualProgress()
        self.updateVisualCollectingState()

    def set_collected(self, prev):
        self.updateVisualProgress()
        self.updateVisualCollectingState()

    def set_vehiclesInRadius(self, prev):
        self.updateVisualCollectingState()

    def onTeamSoulsUpdated(self):
        self.updateVisualCollectingState()

    def updateVisualCollectingState(self):
        self._callbacks.delayCallback(constants.SERVER_TICK_LENGTH, self._updateVisualCollectingState)

    @property
    def vehicleStats(self):
        return HWTeamInfoStatsComponent.getInstance()

    @property
    def progress(self):
        if self.capacity <= 0.0:
            return 0.0
        return max(0.0, min(1.0, float(self.collected) / float(self.capacity)))

    @property
    def isFull(self):
        return self.collected >= self.capacity

    @property
    def hwBattleGuiCtrl(self):
        return self.guiSessionProvider.dynamic.getControllerByID(BATTLE_CTRL_ID.HW_BATTLE_GUI_CTRL)

    def updateVisualProgress(self):
        if not self._isReady:
            return
        self._visualComponent.updateProgress(self.progress)
        self.onUpdateSoulsCollectorProgress(self.collected)

    @property
    def _isReady(self):
        return self._visualComponent is not None and self._visualComponent.isReady and self.vehicleStats is not None

    def _updateVisualCollectingState(self):
        if not self._isReady:
            return
        isCollecting = bool(self.vehiclesInRadius) and any(self.vehicleStats.getSouls(vID) > 0 for vID in self.vehiclesInRadius) and not self.isFull
        teamSouls = self.vehicleStats.getTeamSouls() if self.vehicleStats else 0
        if self.hwBattleGuiCtrl:
            self.hwBattleGuiCtrl.updateCollector(self)
        self._visualComponent.updateIsCollecting(isCollecting)
        self.onUpdateSoulsCollectorState(self.collected, self.capacity, self.isFull, teamSouls)
        self._soundComponent.updateSoulsCollectorState(self.collected, self.capacity, isCollecting)

    def _onAvatarReady(self):
        CGF.loadGameObjectIntoHierarchy(getPrefabPath(HWPrefabs.SOULS_COLLECTOR), self.entity.entityGameObject, (0,
                                                                                                                 0,
                                                                                                                 0), functools.partial(_onPrefabLoaded, WeakMethod(self._onPrefabLoaded)))

    def _onPrefabLoaded(self, go):
        go.activate()
        self.go = go
        self._callbacks.delayCallback(self.POLL_RATE, self._waitAllComponentsReady)

    def _waitAllComponentsReady(self):
        if self._visualComponent is None:
            self._visualComponent = SoulCollectorComponent.init(self.go)
        if not self._isReady:
            return self.POLL_RATE
        else:
            self.vehicleStats.onTeamSoulsUpdated += self.onTeamSoulsUpdated
            self.updateVisualProgress()
            self.updateVisualCollectingState()
            if self.hwBattleGuiCtrl:
                self.hwBattleGuiCtrl.onSoulsCollectorSpawned(self)
            self._soundComponent = SoulsCollectorSound(self)
            return