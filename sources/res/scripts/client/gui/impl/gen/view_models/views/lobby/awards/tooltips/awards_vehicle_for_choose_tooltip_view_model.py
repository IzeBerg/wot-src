from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from gui.impl.gen.view_models.common.vehicle_info_model import VehicleInfoModel

class AwardsVehicleForChooseTooltipViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(AwardsVehicleForChooseTooltipViewModel, self).__init__(properties=properties, commands=commands)

    def getVehiclesList(self):
        return self._getArray(0)

    def setVehiclesList(self, value):
        self._setArray(0, value)

    @staticmethod
    def getVehiclesListType():
        return VehicleInfoModel

    def _initialize(self):
        super(AwardsVehicleForChooseTooltipViewModel, self)._initialize()
        self._addArrayProperty('vehiclesList', Array())