from gui.Scaleform.daapi.view.battle.shared.damage_panel import DamagePanel, _STATE_HANDLERS
from gui.battle_control.battle_constants import VEHICLE_VIEW_STATE

class HalloweenDamagePanel(DamagePanel):

    def __init__(self):
        super(HalloweenDamagePanel, self).__init__()
        _STATE_HANDLERS[VEHICLE_VIEW_STATE.HW_DRAIN_LIFE] = _STATE_HANDLERS[VEHICLE_VIEW_STATE.FIRE]
        self._prevFireStateValue = False
        self.__prevDrainStateValue = False

    def _onVehicleStateUpdated(self, state, value):
        if state == VEHICLE_VIEW_STATE.FIRE:
            self._prevFireStateValue = value
        elif state == VEHICLE_VIEW_STATE.HW_DRAIN_LIFE:
            if not (value or self._prevFireStateValue or self.__prevDrainStateValue):
                return
            self.__prevDrainStateValue = value
            if self._prevFireStateValue and not value:
                return
        super(HalloweenDamagePanel, self)._onVehicleStateUpdated(state, value)