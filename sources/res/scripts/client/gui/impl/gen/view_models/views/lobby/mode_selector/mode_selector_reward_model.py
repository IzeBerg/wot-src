from gui.impl.gen import R
from frameworks.wulf import ViewModel

class ModeSelectorRewardModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=5, commands=0):
        super(ModeSelectorRewardModel, self).__init__(properties=properties, commands=commands)

    def getIconName(self):
        return self._getString(0)

    def setIconName(self, value):
        self._setString(0, value)

    def getName(self):
        return self._getResource(1)

    def setName(self, value):
        self._setResource(1, value)

    def getDescription(self):
        return self._getString(2)

    def setDescription(self, value):
        self._setString(2, value)

    def getVehicleLevel(self):
        return self._getString(3)

    def setVehicleLevel(self, value):
        self._setString(3, value)

    def getVehicleType(self):
        return self._getString(4)

    def setVehicleType(self, value):
        self._setString(4, value)

    def _initialize(self):
        super(ModeSelectorRewardModel, self)._initialize()
        self._addStringProperty('iconName', '')
        self._addResourceProperty('name', R.invalid())
        self._addStringProperty('description', '')
        self._addStringProperty('vehicleLevel', '')
        self._addStringProperty('vehicleType', '')