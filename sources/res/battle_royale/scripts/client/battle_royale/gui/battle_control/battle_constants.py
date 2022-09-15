from gui.battle_control.battle_constants import TIMER_VIEW_STATE
from death_zones_helpers import ZONE_STATE

class BrTimerViewState(TIMER_VIEW_STATE):
    DAMAGING = 'damaging'

    @staticmethod
    def fromZone(state):
        if state == ZONE_STATE.CRITICAL:
            return BrTimerViewState.CRITICAL
        else:
            if state == ZONE_STATE.WARNING:
                return BrTimerViewState.WARNING
            return