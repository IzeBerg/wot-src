from gui.impl.gen.view_models.views.lobby.new_year.components.ny_vehicle_renderer_model import NyVehicleRendererModel

class NyLootBoxStatisticsVehicleModel(NyVehicleRendererModel):
    __slots__ = ()

    def __init__(self, properties=3, commands=0):
        super(NyLootBoxStatisticsVehicleModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(NyLootBoxStatisticsVehicleModel, self)._initialize()