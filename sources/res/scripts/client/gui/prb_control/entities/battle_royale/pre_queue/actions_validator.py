from CurrentVehicle import g_currentVehicle
from gui.prb_control.entities.base.actions_validator import BaseActionsValidator, ActionsValidatorComposite
from gui.prb_control.entities.base.pre_queue.actions_validator import PreQueueActionsValidator
from gui.prb_control.items import ValidationResult
from gui.prb_control.settings import PRE_QUEUE_RESTRICTION
from gui.ranked_battles.constants import PrimeTimeStatus
from helpers import dependency
from skeletons.gui.game_control import IBattleRoyaleController

class BattleRoyaleValidator(BaseActionsValidator):

    def _validate(self):
        brController = dependency.instance(IBattleRoyaleController)
        status, _, _ = brController.getPrimeTimeStatus()
        if g_currentVehicle.isOnlyForBattleRoyaleBattles() and status != PrimeTimeStatus.AVAILABLE:
            return ValidationResult(False, PRE_QUEUE_RESTRICTION.MODE_DISABLED)
        return super(BattleRoyaleValidator, self)._validate()


class BattleRoyaleActionsValidator(PreQueueActionsValidator):

    def _createStateValidator(self, entity):
        baseValidator = super(BattleRoyaleActionsValidator, self)._createStateValidator(entity)
        return ActionsValidatorComposite(entity, [
         baseValidator,
         BattleRoyaleValidator(entity)])