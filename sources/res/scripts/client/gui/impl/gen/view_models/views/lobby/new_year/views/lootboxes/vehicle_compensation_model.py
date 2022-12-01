from gui.impl.gen.view_models.views.lobby.battle_pass.vehicle_bonus_model import VehicleBonusModel

class VehicleCompensationModel(VehicleBonusModel):
    __slots__ = ()

    def __init__(self, properties=19, commands=0):
        super(VehicleCompensationModel, self).__init__(properties=properties, commands=commands)

    @property
    def compensatedItem(self):
        return self._getViewModel(18)

    @staticmethod
    def getCompensatedItemType():
        return VehicleBonusModel

    def _initialize(self):
        super(VehicleCompensationModel, self)._initialize()
        self._addViewModelProperty('compensatedItem', VehicleBonusModel())