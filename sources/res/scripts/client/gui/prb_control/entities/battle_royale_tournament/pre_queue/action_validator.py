from gui.prb_control.entities.base.actions_validator import ActionsValidatorComposite
from gui.prb_control.entities.base.pre_queue.actions_validator import PreQueueActionsValidator, InQueueValidator
from gui.prb_control.items import ValidationResult

class _BattleRoyaleTournamentInQueueValidator(InQueueValidator):

    def _validate(self):
        if self._entity.isInQueue():
            return ValidationResult(True)
        return super(_BattleRoyaleTournamentInQueueValidator, self)._validate()


class BattleRoyaleTournamentActionsValidator(PreQueueActionsValidator):

    def _createStateValidator(self, entity):
        return ActionsValidatorComposite(entity, [
         _BattleRoyaleTournamentInQueueValidator(entity)])