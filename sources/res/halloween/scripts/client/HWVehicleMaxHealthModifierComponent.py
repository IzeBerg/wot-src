import BigWorld
from gui.battle_control.battle_constants import VEHICLE_VIEW_STATE
from script_component.DynamicScriptComponent import DynamicScriptComponent

class HWVehicleMaxHealthModifierComponent(DynamicScriptComponent):

    def set_maxHealth(self, _):
        BigWorld.player().guiSessionProvider.invalidateVehicleState(VEHICLE_VIEW_STATE.HW_MAX_HEALTH, self.entity.maxHealth, self.entity.id)
        BigWorld.player().guiSessionProvider.invalidateVehicleState(VEHICLE_VIEW_STATE.HEALTH, self.entity.health, self.entity.id)