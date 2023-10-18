from gui.prb_control.settings import PRE_QUEUE_RESTRICTION
from helpers import dependency
from CurrentVehicle import g_currentVehicle
from gui.prb_control.entities.base.pre_queue.actions_validator import PreQueueActionsValidator
from gui.prb_control.items import ValidationResult
from gui.prb_control.entities.base.actions_validator import BaseActionsValidator, ActionsValidatorComposite
from halloween.skeletons.halloween_controller import IHalloweenController

class HalloweenStateValidator(BaseActionsValidator):
    __halloweenBattleCtrl = dependency.descriptor(IHalloweenController)

    def _validate(self):
        if not self.__halloweenBattleCtrl.isBattlesEnabled():
            return ValidationResult(False, PRE_QUEUE_RESTRICTION.MODE_NOT_AVAILABLE)
        vehicle = g_currentVehicle.item
        if vehicle and not self.__halloweenBattleCtrl.hasAccessToVehicle(vehicle.intCD):
            return ValidationResult(False, PRE_QUEUE_RESTRICTION.VEHICLE_WILL_BE_UNLOCKED)
        return super(HalloweenStateValidator, self)._validate()


class HalloweenVehicleValidator(BaseActionsValidator):

    def _validate(self):
        vehicle = g_currentVehicle.item
        if vehicle is None:
            return ValidationResult(False)
        else:
            return super(HalloweenVehicleValidator, self)._validate()


class HalloweenActionsValidator(PreQueueActionsValidator):

    def _createVehiclesValidator(self, entity):
        baseValidator = super(HalloweenActionsValidator, self)._createVehiclesValidator(entity)
        return ActionsValidatorComposite(entity, [
         HalloweenVehicleValidator(entity),
         HalloweenStateValidator(entity),
         baseValidator])