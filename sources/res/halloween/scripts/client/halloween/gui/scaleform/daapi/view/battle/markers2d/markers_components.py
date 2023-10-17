from helpers import dependency
from skeletons.gui.battle_session import IBattleSessionProvider
from chat_commands_consts import DefaultMarkerSubType
from gui.Scaleform.daapi.view.battle.shared.component_marker.markers_components import World2DActionMarkerComponent
from halloween.gui.halloween_gui_constants import SoulsCollectorMarkerStates
from halloween.gui.battle_control.halloween_battle_constants import VEHICLE_VIEW_STATE

def getSoulsCollectorMarkerState(collected, capacity, isFull, teamSouls):
    state = SoulsCollectorMarkerStates.NOT_ENOUGHT_SOULS.value
    if isFull:
        state = SoulsCollectorMarkerStates.MOVE_TO_SOULS_COLLECTOR.value
    elif teamSouls >= capacity - collected:
        state = SoulsCollectorMarkerStates.ENOUGHT_SOULS.value
    return state


class SoulsCollector2DActionMarkerComponent(World2DActionMarkerComponent):
    __sessionProvider = dependency.descriptor(IBattleSessionProvider)
    __UNHIDE_STATES_TRIGGERS = (
     VEHICLE_VIEW_STATE.DESTROYED, VEHICLE_VIEW_STATE.CREW_DEACTIVATED, VEHICLE_VIEW_STATE.SWITCHING)

    def __init__(self, *args, **kwargs):
        super(SoulsCollector2DActionMarkerComponent, self).__init__(*args, **kwargs)
        self._isMarkerHidden = False

    @classmethod
    def configReader(cls, section):
        config = super(SoulsCollector2DActionMarkerComponent, cls).configReader(section)
        config.update({'shape': ''})
        return config

    def setVisible(self, isVisible):
        super(SoulsCollector2DActionMarkerComponent, self).setVisible(isVisible and not self._isMarkerHidden)

    def _setupMarker(self, gui):
        super(SoulsCollector2DActionMarkerComponent, self)._setupMarker(gui)
        ctrl = self.__sessionProvider.shared.vehicleState
        if ctrl is not None:
            ctrl.onVehicleStateUpdated += self.__onVehicleStateUpdated
        if self._entity and 'hwSoulsCollector' in self._entity.dynamicComponents:
            soulsComponent = self._entity.hwSoulsCollector
            soulsComponent.onUpdateSoulsCollectorState += self._updateMarkerState
            soulsComponent.onUpdateSoulsCollectorProgress += self._updateMarkerProgress
            gui.setMarkerSubType(self.componentID, DefaultMarkerSubType.ALLY_MARKER_SUBTYPE)
            gui.invokeMarker(self.componentID, 'setProgressMax', soulsComponent.capacity)
            gui.setMarkerAlwaysSticky(self.componentID)
            gui.setMarkerSticky(self.componentID, self._config['is_sticky'])
            self._updateMarkerState(soulsComponent.collected, soulsComponent.capacity, soulsComponent.isFull, soulsComponent.vehicleStats.getTeamSouls() if soulsComponent.vehicleStats else 0)
            self._updateMarkerProgress(soulsComponent.collected)
        return True

    def _deleteMarker(self):
        gui = self._gui()
        if gui:
            gui.removeMarkerAlwaysSticky(self.componentID)
        if self._entity and 'hwSoulsCollector' in self._entity.dynamicComponents:
            soulsComponent = self._entity.hwSoulsCollector
            soulsComponent.onUpdateSoulsCollectorState -= self._updateMarkerState
            soulsComponent.onUpdateSoulsCollectorProgress -= self._updateMarkerProgress
        ctrl = self.__sessionProvider.shared.vehicleState
        if ctrl is not None:
            ctrl.onVehicleStateUpdated -= self.__onVehicleStateUpdated
        super(SoulsCollector2DActionMarkerComponent, self)._deleteMarker()
        return

    def _updateMarkerState(self, collected, capacity, isFull, teamSouls):
        gui = self._gui()
        if gui and self._isMarkerExists:
            gui.invokeMarker(self.componentID, 'setVolotState', getSoulsCollectorMarkerState(collected, capacity, isFull, teamSouls))

    def _updateMarkerProgress(self, collected):
        gui = self._gui()
        if gui and self._isMarkerExists:
            gui.invokeMarker(self.componentID, 'setProgress', int(collected))

    def __onVehicleStateUpdated(self, state, value):
        if state == VEHICLE_VIEW_STATE.COLLECTOR_FULL:
            self._isMarkerHidden = value
        elif state == VEHICLE_VIEW_STATE.COLLECTOR_FILL:
            self._isMarkerHidden = value is not None
        elif state in self.__UNHIDE_STATES_TRIGGERS:
            self._isMarkerHidden = False
        return


class Camp2DActionMarkerComponent(World2DActionMarkerComponent):

    def _setupMarker(self, gui):
        super(Camp2DActionMarkerComponent, self)._setupMarker(gui)
        gui.setMarkerSubType(self.componentID, DefaultMarkerSubType.ENEMY_MARKER_SUBTYPE)
        gui.setHasAnimation(self.componentID, True)
        gui.onReplyFeedbackReceived += self._updateSticky
        return True

    def _deleteMarker(self):
        gui = self._gui()
        if self._isMarkerExists and gui:
            gui.onReplyFeedbackReceived -= self._updateSticky
        super(Camp2DActionMarkerComponent, self)._deleteMarker()

    def _updateSticky(self, componentID, isSticky):
        if self._componentID != componentID:
            return
        gui = self._gui()
        if self._isMarkerExists and gui:
            gui.setMarkerSticky(self.componentID, isSticky)