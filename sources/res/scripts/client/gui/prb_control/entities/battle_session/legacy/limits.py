from gui.prb_control.entities.base.limits import LimitsCollection, VehicleIsValid, VehiclesLevelLimit, TeamIsValid

class BattleSessionLimits(LimitsCollection):

    def __init__(self, entity):
        super(BattleSessionLimits, self).__init__(entity, (
         VehicleIsValid(),), (
         VehiclesLevelLimit(),
         TeamIsValid()))