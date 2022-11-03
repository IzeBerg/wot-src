from fun_random.gui.feature.util.fun_mixins import FunSubModesWatcher
from fun_random.gui.feature.util.fun_wrappers import hasDesiredSubMode
from gui.prb_control.entities.base.actions_validator import ActionsValidatorComposite
from gui.prb_control.entities.base.squad.actions_validator import SquadActionsValidator, SquadVehiclesValidator
from gui.prb_control.entities.random.squad.actions_validator import BalancedSquadVehiclesValidator, SPGForbiddenSquadVehiclesValidator, BalancedSquadSlotsValidator, ScoutForbiddenSquadVehiclesValidator
from gui.periodic_battles.prb_control.actions_validator import SquadPrimeTimeValidator

class _FunRandomSquadStateValidator(SquadPrimeTimeValidator, FunSubModesWatcher):

    def _getController(self):
        return self.getDesiredSubMode()


class _FunRandomSquadVehicleValidator(SquadVehiclesValidator, FunSubModesWatcher):

    @hasDesiredSubMode()
    def _isVehicleSuitableForMode(self, vehicle):
        validationResult = self.getDesiredSubMode().isSuitableVehicle(vehicle, isSquad=True)
        return validationResult or super(_FunRandomSquadVehicleValidator, self)._isVehicleSuitableForMode(vehicle)


class FunRandomActionsValidator(SquadActionsValidator):

    def _createStateValidator(self, entity):
        return _FunRandomSquadStateValidator(entity)

    def _createSlotsValidator(self, entity):
        baseValidator = super(FunRandomActionsValidator, self)._createSlotsValidator(entity)
        return ActionsValidatorComposite(entity, validators=[baseValidator, BalancedSquadSlotsValidator(entity)])

    def _createVehiclesValidator(self, entity):
        return ActionsValidatorComposite(entity, validators=[
         _FunRandomSquadVehicleValidator(entity),
         BalancedSquadVehiclesValidator(entity),
         SPGForbiddenSquadVehiclesValidator(entity),
         ScoutForbiddenSquadVehiclesValidator(entity)])