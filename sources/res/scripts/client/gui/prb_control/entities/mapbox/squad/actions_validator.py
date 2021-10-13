from gui.prb_control.entities.base.actions_validator import ActionsValidatorComposite
from gui.prb_control.entities.base.squad.actions_validator import SquadActionsValidator, SquadVehiclesValidator
from gui.prb_control.entities.base.unit.actions_validator import CommanderValidator
from gui.prb_control.entities.random.squad.actions_validator import BalancedSquadVehiclesValidator, SPGForbiddenSquadVehiclesValidator
from gui.prb_control.items import ValidationResult
from gui.prb_control.settings import UNIT_RESTRICTION
from gui.prb_control.entities.base.unit.actions_validator import UnitStateValidator
from helpers import dependency
from skeletons.gui.game_control import IMapboxController
from gui.periodic_battles.models import PrimeTimeStatus

class _MapboxVehicleValidator(SquadVehiclesValidator):

    def _isValidMode(self, vehicle):
        return not vehicle.isEvent


class _MapboxStateValidator(UnitStateValidator):

    def _validate(self):
        mapboxCtrl = dependency.instance(IMapboxController)
        status, _, _ = mapboxCtrl.getPrimeTimeStatus()
        if status != PrimeTimeStatus.AVAILABLE:
            return ValidationResult(False, UNIT_RESTRICTION.UNIT_INACTIVE_PERIPHERY_UNDEF)
        return super(_MapboxStateValidator, self)._validate()


class _UnitSlotsValidator(CommanderValidator):

    def _validate(self):
        stats = self._entity.getStats()
        pInfo = self._entity.getPlayerInfo()
        if stats.occupiedSlotsCount > 1 and not pInfo.isReady:
            return ValidationResult(False, UNIT_RESTRICTION.COMMANDER_VEHICLE_NOT_SELECTED)


class MapboxSquadActionsValidator(SquadActionsValidator):

    def _createVehiclesValidator(self, entity):
        return ActionsValidatorComposite(entity, validators=[
         BalancedSquadVehiclesValidator(entity),
         _MapboxVehicleValidator(entity),
         SPGForbiddenSquadVehiclesValidator(entity)])

    def _createStateValidator(self, entity):
        return _MapboxStateValidator(entity)

    def _createSlotsValidator(self, entity):
        baseValidator = super(MapboxSquadActionsValidator, self)._createSlotsValidator(entity)
        return ActionsValidatorComposite(entity, validators=[
         baseValidator,
         _UnitSlotsValidator(entity)])