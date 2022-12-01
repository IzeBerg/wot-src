from gui.prb_control.entities.base.actions_validator import BaseActionsValidator
from gui.prb_control.entities.base.unit.actions_validator import UnitStateValidator
from gui.prb_control.items import ValidationResult
from gui.prb_control.settings import PRE_QUEUE_RESTRICTION, UNIT_RESTRICTION
from gui.periodic_battles.models import PrimeTimeStatus

def _validateModeState(controller, restrictions):
    if controller is None:
        return ValidationResult(False, restrictions.UNDEFINED, None)
    else:
        if not controller.isBattlesPossible():
            return ValidationResult(False, restrictions.MODE_NO_BATTLES, None)
        status, _, _ = controller.getPrimeTimeStatus()
        if status == PrimeTimeStatus.NOT_SET:
            return ValidationResult(False, restrictions.MODE_NOT_SET, None)
        if status != PrimeTimeStatus.AVAILABLE:
            return ValidationResult(False, restrictions.MODE_NOT_AVAILABLE, None)
        return


class PrimeTimeValidator(BaseActionsValidator):

    def _getController(self):
        raise NotImplementedError

    def _validate(self):
        validationRes = _validateModeState(self._getController(), PRE_QUEUE_RESTRICTION)
        if validationRes is not None:
            return validationRes
        else:
            return super(PrimeTimeValidator, self)._validate()


class SquadPrimeTimeValidator(UnitStateValidator):

    def _getController(self):
        raise NotImplementedError

    def _validate(self):
        validationRes = _validateModeState(self._getController(), UNIT_RESTRICTION)
        if validationRes is not None:
            return validationRes
        else:
            return super(SquadPrimeTimeValidator, self)._validate()