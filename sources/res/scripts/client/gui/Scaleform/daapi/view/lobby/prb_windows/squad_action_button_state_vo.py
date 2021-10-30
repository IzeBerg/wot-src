from gui.Scaleform.daapi.view.lobby.rally.action_button_state_vo import ActionButtonStateVO
from gui.Scaleform.locale.CYBERSPORT import CYBERSPORT
from gui.prb_control.settings import UNIT_RESTRICTION
_VALID_RESTRICTIONS = (
 UNIT_RESTRICTION.COMMANDER_VEHICLE_NOT_SELECTED,
 UNIT_RESTRICTION.NOT_READY_IN_SLOTS,
 UNIT_RESTRICTION.UNIT_NOT_FULL)

class SquadActionButtonStateVO(ActionButtonStateVO):

    def _isEnabled(self, isValid, restriction):
        return isValid or restriction in _VALID_RESTRICTIONS

    def _getLabel(self):
        if self._playerInfo.isReady:
            label = CYBERSPORT.WINDOW_UNIT_NOTREADY
        else:
            label = CYBERSPORT.WINDOW_UNIT_READY
        return label

    def _getArenaStateStr(self):
        return (
         CYBERSPORT.WINDOW_UNIT_MESSAGE_SQUADINBATTLE, {})

    def _getReadyValidInSlotStateStr(self):
        return (
         CYBERSPORT.WINDOW_UNIT_MESSAGE_GETNOTREADY, {})

    def _getIdleStateStr(self):
        return (
         CYBERSPORT.SQUADWINDOW_WAITINGFORBATTLE, {})