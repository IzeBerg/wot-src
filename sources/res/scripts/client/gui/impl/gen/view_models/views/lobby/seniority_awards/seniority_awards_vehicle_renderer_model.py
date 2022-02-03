from frameworks.wulf import ViewModel

class SeniorityAwardsVehicleRendererModel(ViewModel):
    __slots__ = ()
    TOOLTIP_VEHICLE_REWARD = 'TOOLTIP_VEHICLE_REWARD'

    def __init__(self, properties=3, commands=0):
        super(SeniorityAwardsVehicleRendererModel, self).__init__(properties=properties, commands=commands)

    def getVehicleCD(self):
        return self._getString(0)

    def setVehicleCD(self, value):
        self._setString(0, value)

    def getImgSource(self):
        return self._getString(1)

    def setImgSource(self, value):
        self._setString(1, value)

    def getVehicleName(self):
        return self._getString(2)

    def setVehicleName(self, value):
        self._setString(2, value)

    def _initialize(self):
        super(SeniorityAwardsVehicleRendererModel, self)._initialize()
        self._addStringProperty('vehicleCD', '')
        self._addStringProperty('imgSource', '')
        self._addStringProperty('vehicleName', '')