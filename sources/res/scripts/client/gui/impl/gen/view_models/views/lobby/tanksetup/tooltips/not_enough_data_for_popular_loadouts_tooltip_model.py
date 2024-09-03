from gui.impl.gen.view_models.views.lobby.common.vehicle_model import VehicleModel

class NotEnoughDataForPopularLoadoutsTooltipModel(VehicleModel):
    __slots__ = ()

    def __init__(self, properties=9, commands=0):
        super(NotEnoughDataForPopularLoadoutsTooltipModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(NotEnoughDataForPopularLoadoutsTooltipModel, self)._initialize()