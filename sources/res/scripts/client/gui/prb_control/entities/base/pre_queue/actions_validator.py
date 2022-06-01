from gui.prb_control.entities.base.actions_validator import BaseActionsValidator, ActionsValidatorComposite, CurrentVehicleActionsValidator, TutorialActionsValidator
from gui.prb_control.items import ValidationResult

class InQueueValidator(BaseActionsValidator):

    def _validate(self):
        if self._entity.isInQueue():
            return ValidationResult(False)
        return super(InQueueValidator, self)._validate()


class PreQueueActionsValidator(ActionsValidatorComposite):

    def __init__(self, entity):
        self._stateValidator = self._createStateValidator(entity)
        self._vehiclesValidator = self._createVehiclesValidator(entity)
        self._tutorialValidator = self._createTutorialValidator(entity)
        validators = [
         self._stateValidator,
         self._vehiclesValidator,
         self._tutorialValidator]
        super(PreQueueActionsValidator, self).__init__(entity, validators)

    def _createStateValidator(self, entity):
        return InQueueValidator(entity)

    def _createVehiclesValidator(self, entity):
        return CurrentVehicleActionsValidator(entity)

    def _createTutorialValidator(self, entity):
        return TutorialActionsValidator(entity)