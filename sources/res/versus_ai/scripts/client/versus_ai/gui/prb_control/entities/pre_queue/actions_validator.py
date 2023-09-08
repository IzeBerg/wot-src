from CurrentVehicle import g_currentVehicle
from gui.prb_control.entities.base.pre_queue.actions_validator import PreQueueActionsValidator
from gui.prb_control.items import ValidationResult
from gui.prb_control.entities.base.actions_validator import CurrentVehicleActionsValidator, ActionsValidatorComposite
from gui.prb_control.settings import PRE_QUEUE_RESTRICTION, PREBATTLE_RESTRICTION
from helpers import dependency
from skeletons.gui.lobby_context import ILobbyContext

class VersusAIVehicleValidator(CurrentVehicleActionsValidator):

    def _validate(self):
        vehicle = g_currentVehicle.item
        result = self.validateForVersusAI(vehicle)
        if result is not None:
            return result
        else:
            return super(VersusAIVehicleValidator, self)._validate()

    @staticmethod
    def validateForVersusAI(vehicle):
        if vehicle is None:
            return ValidationResult(False, PREBATTLE_RESTRICTION.VEHICLE_NOT_PRESENT)
        else:
            lobbyContext = dependency.instance(ILobbyContext)
            config = lobbyContext.getServerSettings().versusAIConfig
            if vehicle.level not in config.levels:
                return ValidationResult(False, PRE_QUEUE_RESTRICTION.LIMIT_LEVEL, {'levels': config.levels})
            if vehicle.tags & config.forbiddenVehicleTags:
                return ValidationResult(False, PREBATTLE_RESTRICTION.VEHICLE_NOT_SUPPORTED)
            return


class VersusAIActionsValidator(PreQueueActionsValidator):

    def _createVehiclesValidator(self, entity):
        baseValidator = super(VersusAIActionsValidator, self)._createVehiclesValidator(entity)
        return ActionsValidatorComposite(entity, [
         VersusAIVehicleValidator(entity),
         baseValidator])