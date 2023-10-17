from enum import Enum
from frameworks.wulf import ViewModel

class VehicleTypes(Enum):
    NONE = 'none'
    LIGHTTANK = 'lightTank'
    MEDIUMTANK = 'mediumTank'
    HEAVYTANK = 'heavyTank'
    SPG = 'SPG'
    AT_SPG = 'AT-SPG'


class VehicleStates(Enum):
    DEFAULT = 'default'
    LOCKED = 'locked'
    INBATTLE = 'inBattle'
    INPLATOON = 'inPlatoon'


class VehicleTitleViewModel(ViewModel):
    __slots__ = ('onTasksClick', 'onPacksClick')

    def __init__(self, properties=4, commands=2):
        super(VehicleTitleViewModel, self).__init__(properties=properties, commands=commands)

    def getName(self):
        return self._getString(0)

    def setName(self, value):
        self._setString(0, value)

    def getDescription(self):
        return self._getString(1)

    def setDescription(self, value):
        self._setString(1, value)

    def getVehicleType(self):
        return VehicleTypes(self._getString(2))

    def setVehicleType(self, value):
        self._setString(2, value.value)

    def getVehicleState(self):
        return VehicleStates(self._getString(3))

    def setVehicleState(self, value):
        self._setString(3, value.value)

    def _initialize(self):
        super(VehicleTitleViewModel, self)._initialize()
        self._addStringProperty('name', '')
        self._addStringProperty('description', '')
        self._addStringProperty('vehicleType')
        self._addStringProperty('vehicleState')
        self.onTasksClick = self._addCommand('onTasksClick')
        self.onPacksClick = self._addCommand('onPacksClick')