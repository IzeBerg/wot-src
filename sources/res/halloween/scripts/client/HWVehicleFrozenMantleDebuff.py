from gui.battle_control.battle_constants import VEHICLE_VIEW_STATE
from HWVehicleDebuffBase import HWVehicleDebuffBase

class HWVehicleFrozenMantleDebuff(HWVehicleDebuffBase):
    _TIMER_ID = VEHICLE_VIEW_STATE.HW_VEHICLE_FROZEN_MANTLE

    def _getTimerData(self, isShow=True):
        return isShow

    def _getDuration(self):
        return 99