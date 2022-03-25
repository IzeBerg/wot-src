from gui.Scaleform.daapi.view.battle.shared.timers_panel import TimersPanel
from gui.battle_control.battle_constants import VEHICLE_VIEW_STATE

class CommanderTimersPanel(TimersPanel):

    def _onVehicleStateUpdated(self, state, value):
        if state == VEHICLE_VIEW_STATE.SWITCHING:
            return
        super(CommanderTimersPanel, self)._onVehicleStateUpdated(state, value)