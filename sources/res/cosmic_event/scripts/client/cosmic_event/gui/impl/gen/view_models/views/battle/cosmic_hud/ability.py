from enum import Enum
from frameworks.wulf import ViewModel

class AbilityTypeEnum(Enum):
    NONE = 'none'
    SHELL = 'shell'
    ACCELERATION = 'acceleration'
    SHIELD = 'shield'
    BLACKHOLE = 'black_hole'
    RAPIDSHELLING = 'rapid_shelling'
    OVERCHARGE = 'overcharge'


class Ability(ViewModel):
    __slots__ = ()

    def __init__(self, properties=5, commands=0):
        super(Ability, self).__init__(properties=properties, commands=commands)

    def getType(self):
        return AbilityTypeEnum(self._getString(0))

    def setType(self, value):
        self._setString(0, value.value)

    def getReloadTimeLeft(self):
        return self._getReal(1)

    def setReloadTimeLeft(self, value):
        self._setReal(1, value)

    def getReloadTime(self):
        return self._getReal(2)

    def setReloadTime(self, value):
        self._setReal(2, value)

    def getIsActive(self):
        return self._getBool(3)

    def setIsActive(self, value):
        self._setBool(3, value)

    def getKeyBind(self):
        return self._getString(4)

    def setKeyBind(self, value):
        self._setString(4, value)

    def _initialize(self):
        super(Ability, self)._initialize()
        self._addStringProperty('type')
        self._addRealProperty('reloadTimeLeft', 0.0)
        self._addRealProperty('reloadTime', 0.0)
        self._addBoolProperty('isActive', False)
        self._addStringProperty('keyBind', '')