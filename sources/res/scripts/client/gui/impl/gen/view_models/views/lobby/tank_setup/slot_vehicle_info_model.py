from gui.impl.gen.view_models.common.vehicle_info_model import VehicleInfoModel

class SlotVehicleInfoModel(VehicleInfoModel):
    __slots__ = ()

    def __init__(self, properties=8, commands=0):
        super(SlotVehicleInfoModel, self).__init__(properties=properties, commands=commands)

    def getVehicleID(self):
        return self._getNumber(7)

    def setVehicleID(self, value):
        self._setNumber(7, value)

    def _initialize(self):
        super(SlotVehicleInfoModel, self)._initialize()
        self._addNumberProperty('vehicleID', 0)