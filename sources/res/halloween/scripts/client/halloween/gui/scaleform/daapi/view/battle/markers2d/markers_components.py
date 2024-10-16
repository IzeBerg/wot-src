from helpers import dependency
from skeletons.gui.battle_session import IBattleSessionProvider
from chat_commands_consts import DefaultMarkerSubType
from gui.Scaleform.daapi.view.battle.shared.component_marker.markers_components import World2DActionMarkerComponent
from halloween.gui.halloween_gui_constants import SoulsCollectorMarkerStates, BATTLE_CTRL_ID
from halloween.gui.battle_control.halloween_battle_constants import VEHICLE_VIEW_STATE

def getSoulsCollectorMarkerState(isFull):
    if isFull:
        return SoulsCollectorMarkerStates.MOVE_TO_SOULS_COLLECTOR.value
    return SoulsCollectorMarkerStates.NOT_ENOUGHT_SOULS.value


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

    @property
    def hwBattleGuiCtrl(self):
        return self.__sessionProvider.dynamic.getControllerByID(BATTLE_CTRL_ID.HW_BATTLE_GUI_CTRL)

    def setVisible(self, isVisible):
        super(SoulsCollector2DActionMarkerComponent, self).setVisible(isVisible and not self._isMarkerHidden)

    def _setupMarker(self, gui, **kwargs):
        super(SoulsCollector2DActionMarkerComponent, self)._setupMarker(gui)
        ctrl = self.__sessionProvider.shared.vehicleState
        if ctrl is not None:
            ctrl.onVehicleStateUpdated += self.__onVehicleStateUpdated
        if self.hwBattleGuiCtrl:
            self.hwBattleGuiCtrl.onSoulCollectorProgress += self._updateMarkerState
            self.hwBattleGuiCtrl.onSoulCollectorProgress += self._updateMarkerProgress
        if self._entity and 'hwSoulsCollector' in self._entity.dynamicComponents:
            soulsComponent = self._entity.hwSoulsCollector
            gui.setMarkerSubType(self.componentID, DefaultMarkerSubType.ALLY_MARKER_SUBTYPE)
            gui.invokeMarker(self.componentID, 'setProgressMax', soulsComponent.capacity)
            gui.setMarkerAlwaysSticky(self.componentID)
            gui.setMarkerSticky(self.componentID, self._config['is_sticky'])
            self._updateMarkerState(soulsComponent.collected, soulsComponent.capacity, soulsComponent.isFull)
            self._updateMarkerProgress(soulsComponent.collected, soulsComponent.capacity, soulsComponent.isFull)
        return True

    def _deleteMarker(self):
        if self.hwBattleGuiCtrl:
            self.hwBattleGuiCtrl.onSoulCollectorProgress -= self._updateMarkerState
            self.hwBattleGuiCtrl.onSoulCollectorProgress -= self._updateMarkerProgress
        gui = self._gui()
        if gui:
            gui.removeMarkerAlwaysSticky(self.componentID)
        ctrl = self.__sessionProvider.shared.vehicleState
        if ctrl is not None:
            ctrl.onVehicleStateUpdated -= self.__onVehicleStateUpdated
        super(SoulsCollector2DActionMarkerComponent, self)._deleteMarker()
        return

    def _updateMarkerState(self, collected, capacity, isFull):
        gui = self._gui()
        if gui and self._isMarkerExists:
            gui.invokeMarker(self.componentID, 'setVolotState', getSoulsCollectorMarkerState(isFull))

    def _updateMarkerProgress(self, collected, capacity, isFull):
        gui = self._gui()
        if gui and self._isMarkerExists:
            gui.invokeMarker(self.componentID, 'setProgress', int(collected))

    def __onVehicleStateUpdated(self, state, value):
        if state == VEHICLE_VIEW_STATE.COLLECTOR_FULL:
            self._isMarkerHidden = value
        elif state in self.__UNHIDE_STATES_TRIGGERS:
            self._isMarkerHidden = False


class Camp2DActionMarkerComponent(World2DActionMarkerComponent):

    def _setupMarker(self, gui, **kwargs):
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