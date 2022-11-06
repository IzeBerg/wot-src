from gui.prb_control.entities.base.actions_validator import BaseActionsValidator, ActionsValidatorComposite
from gui.prb_control.entities.base.pre_queue.actions_validator import PreQueueActionsValidator
from gui.prb_control.items import ValidationResult
from helpers import dependency
from skeletons.gui.game_control import IDemoAccCompletionController

class BootcampStateValidator(BaseActionsValidator):

    def _validate(self):
        demoAccController = dependency.instance(IDemoAccCompletionController)
        if demoAccController.isInDemoAccRegistration:
            return ValidationResult(False)
        return super(BootcampStateValidator, self)._validate()


class BootcampActionsValidator(PreQueueActionsValidator):

    def _createStateValidator(self, entity):
        baseValidator = super(BootcampActionsValidator, self)._createStateValidator(entity)
        return ActionsValidatorComposite(entity, [
         baseValidator,
         BootcampStateValidator(entity)])