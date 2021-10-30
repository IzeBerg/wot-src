from frameworks.wulf import ViewModel

class VehicleItemModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=6, commands=0):
        super(VehicleItemModel, self).__init__(properties=properties, commands=commands)

    def getVehicleType(self):
        return self._getString(0)

    def setVehicleType(self, value):
        self._setString(0, value)

    def getVehicleLevel(self):
        return self._getNumber(1)

    def setVehicleLevel(self, value):
        self._setNumber(1, value)

    def getVehicleName(self):
        return self._getString(2)

    def setVehicleName(self, value):
        self._setString(2, value)

    def getVehicleBonus(self):
        return self._getNumber(3)

    def setVehicleBonus(self, value):
        self._setNumber(3, value)

    def getVehicleTop(self):
        return self._getNumber(4)

    def setVehicleTop(self, value):
        self._setNumber(4, value)

    def getTextResource(self):
        return self._getString(5)

    def setTextResource(self, value):
        self._setString(5, value)

    def _initialize(self):
        super(VehicleItemModel, self)._initialize()
        self._addStringProperty('vehicleType', '')
        self._addNumberProperty('vehicleLevel', 0)
        self._addStringProperty('vehicleName', '')
        self._addNumberProperty('vehicleBonus', 0)
        self._addNumberProperty('vehicleTop', 0)
        self._addStringProperty('textResource', '')