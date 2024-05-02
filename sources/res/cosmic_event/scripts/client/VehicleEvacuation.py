import Math
from script_component.DynamicScriptComponent import DynamicScriptComponent

class VehicleEvacuation(DynamicScriptComponent):

    def _onAvatarReady(self):
        va = self.entity.appearance
        va.changeVisibility(False)
        va.clearUndamagedStateChildren()
        va.compoundModel.matrix = Math.Matrix()
        if self.entity.isPlayerVehicle:
            self.entity.removeEdge()
            from gui.battle_control.battle_constants import VEHICLE_VIEW_STATE
            self.entity.guiSessionProvider.invalidateVehicleState(VEHICLE_VIEW_STATE.CREW_DEACTIVATED, 0)
            from gui.shared import g_eventBus, EVENT_BUS_SCOPE
            from cosmic_event.gui.shared.events import VehicleEvent
            g_eventBus.handleEvent(VehicleEvent(VehicleEvent.VEHICLE_EVACUATED), scope=EVENT_BUS_SCOPE.BATTLE)
        else:
            self.entity.guiSessionProvider.shared.feedback.onVehicleMarkerRemoved(self.entity.id)