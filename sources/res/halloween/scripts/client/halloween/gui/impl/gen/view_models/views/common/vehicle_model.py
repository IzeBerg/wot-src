from gui.impl.gen.view_models.common.vehicle_info_model import VehicleInfoModel

class VehicleModel(VehicleInfoModel):
    __slots__ = ()

    def __init__(self, properties=8, commands=0):
        super(VehicleModel, self).__init__(properties=properties, commands=commands)

    def getVehicleCD(self):
        return self._getNumber(7)

    def setVehicleCD(self, value):
        self._setNumber(7, value)

    def _initialize(self):
        super(VehicleModel, self)._initialize()
        self._addNumberProperty('vehicleCD', 0)