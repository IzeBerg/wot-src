from gui.battle_control.battle_constants import VEHICLE_VIEW_STATE
from VehicleAbilityBaseComponent import VehicleAbilityBaseComponent

class VehicleCorrodingShotComponent(VehicleAbilityBaseComponent):
    __TIMER_VIEW_ID = VEHICLE_VIEW_STATE.CORRODING_SHOT

    def __init__(self, *args):
        super(VehicleCorrodingShotComponent, self).__init__(self.__TIMER_VIEW_ID)