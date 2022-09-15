from CurrentVehicle import g_currentVehicle
from gui.periodic_battles.models import PrimeTimeStatus
from gui.prb_control.entities.base.actions_validator import BaseActionsValidator, ActionsValidatorComposite
from gui.prb_control.entities.base.pre_queue.actions_validator import PreQueueActionsValidator
from gui.prb_control.items import ValidationResult
from gui.prb_control.settings import PRE_QUEUE_RESTRICTION
from helpers import dependency
from skeletons.gui.game_control import IComp7Controller

class Comp7Validator(BaseActionsValidator):
    __comp7Ctrl = dependency.descriptor(IComp7Controller)

    def _validate(self):
        status, _, isInPrimeTime = self.__comp7Ctrl.getPrimeTimeStatus()
        if status == PrimeTimeStatus.NOT_SET:
            return ValidationResult(False, PRE_QUEUE_RESTRICTION.MODE_NOT_SET)
        if not self.__comp7Ctrl.isAvailable() or not isInPrimeTime:
            return ValidationResult(False, PRE_QUEUE_RESTRICTION.MODE_NOT_AVAILABLE)
        return super(Comp7Validator, self)._validate()


class Comp7PlayerValidator(BaseActionsValidator):
    __comp7Ctrl = dependency.descriptor(IComp7Controller)

    def _validate(self):
        if self.__comp7Ctrl.isOffline:
            return ValidationResult(False, PRE_QUEUE_RESTRICTION.MODE_OFFLINE)
        if self.__comp7Ctrl.isBanned:
            return ValidationResult(False, PRE_QUEUE_RESTRICTION.BAN_IS_SET)
        return super(Comp7PlayerValidator, self)._validate()


class Comp7VehicleValidator(BaseActionsValidator):
    __comp7Ctrl = dependency.descriptor(IComp7Controller)

    def _validate(self):
        if g_currentVehicle.isPresent():
            restriction = self.__comp7Ctrl.isSuitableVehicle(g_currentVehicle.item)
            if restriction is not None:
                return restriction
        if not self.__comp7Ctrl.hasSuitableVehicles():
            return ValidationResult(False, PRE_QUEUE_RESTRICTION.LIMIT_LEVEL, ctx={'levels': self.__comp7Ctrl.getModeSettings().levels})
        else:
            return


class Comp7ActionsValidator(PreQueueActionsValidator):

    def _createStateValidator(self, entity):
        baseValidator = super(Comp7ActionsValidator, self)._createStateValidator(entity)
        validators = [
         baseValidator,
         Comp7Validator(entity),
         Comp7PlayerValidator(entity)]
        return ActionsValidatorComposite(entity, validators=validators)

    def _createVehiclesValidator(self, entity):
        baseValidator = super(Comp7ActionsValidator, self)._createVehiclesValidator(entity)
        return ActionsValidatorComposite(entity, [
         Comp7VehicleValidator(entity),
         baseValidator])