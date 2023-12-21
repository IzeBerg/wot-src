from frameworks.wulf import ViewModel

class SeniorityAwardsTooltipConstants(ViewModel):
    __slots__ = ()
    TOOLTIP_VEHICLE_REWARD = 'TOOLTIP_VEHICLE_REWARD'
    TOOLTIP_VEHICLE_ROLES = 'vehicleRoles'

    def __init__(self, properties=0, commands=0):
        super(SeniorityAwardsTooltipConstants, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(SeniorityAwardsTooltipConstants, self)._initialize()