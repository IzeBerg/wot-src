from CurrentVehicle import g_currentVehicle
from gui.prb_control.entities.base.pre_queue.actions_validator import InQueueValidator
from gui.prb_control.items import ValidationResult
from gui.prb_control.entities.base.actions_validator import BaseActionsValidator, ActionsValidatorComposite
from helpers import dependency
from story_mode.skeletons.story_mode_controller import IStoryModeController

class StoryModeVehicleValidator(BaseActionsValidator):

    def _validate(self):
        vehicle = g_currentVehicle.item
        if vehicle is None:
            return ValidationResult(False)
        else:
            return super(StoryModeVehicleValidator, self)._validate()


class StoryModeStateValidator(BaseActionsValidator):

    def _validate(self):
        ctrl = dependency.instance(IStoryModeController)
        if not ctrl.isEnabled():
            return ValidationResult(False)
        return super(StoryModeStateValidator, self)._validate()


class StoryModeActionsValidator(ActionsValidatorComposite):

    def __init__(self, entity):
        validators = [
         StoryModeVehicleValidator(entity),
         StoryModeStateValidator(entity),
         InQueueValidator(entity)]
        super(StoryModeActionsValidator, self).__init__(entity, validators)