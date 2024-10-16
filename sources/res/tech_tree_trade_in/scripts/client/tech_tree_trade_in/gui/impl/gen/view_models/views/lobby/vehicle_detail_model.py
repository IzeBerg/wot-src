from gui.impl.gen.view_models.common.vehicle_info_model import VehicleInfoModel

class VehicleDetailModel(VehicleInfoModel):
    __slots__ = ()

    def __init__(self, properties=9, commands=0):
        super(VehicleDetailModel, self).__init__(properties=properties, commands=commands)

    def getVehicleState(self):
        return self._getString(7)

    def setVehicleState(self, value):
        self._setString(7, value)

    def getIcon(self):
        return self._getString(8)

    def setIcon(self, value):
        self._setString(8, value)

    def _initialize(self):
        super(VehicleDetailModel, self)._initialize()
        self._addStringProperty('vehicleState', '')
        self._addStringProperty('icon', '')