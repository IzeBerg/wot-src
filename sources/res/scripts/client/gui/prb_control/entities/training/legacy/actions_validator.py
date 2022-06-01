from gui.prb_control.entities.base.actions_validator import ActionsValidatorComposite, BaseActionsValidator, CurrentVehicleActionsValidator
from gui.prb_control.entities.base.legacy.actions_validator import LegacyVehicleValid
from gui.prb_control.events_dispatcher import g_eventDispatcher
from gui.prb_control.items import ValidationResult

class TrainingIsLoaded(BaseActionsValidator):

    def _validate(self):
        if g_eventDispatcher.isTrainingLoaded():
            return ValidationResult(False)
        return super(TrainingIsLoaded, self)._validate()


class TrainingIntroActionsValidator(ActionsValidatorComposite):

    def __init__(self, entity):
        validators = [
         TrainingIsLoaded(entity),
         CurrentVehicleActionsValidator(entity)]
        super(TrainingIntroActionsValidator, self).__init__(entity, validators)


class TrainingActionsValidator(TrainingIntroActionsValidator):

    def __init__(self, entity):
        super(TrainingActionsValidator, self).__init__(entity)
        self.addValidator(LegacyVehicleValid(entity))