from enum import Enum
from frameworks.wulf import ViewModel

class SupplyType(Enum):
    AT_GUN = 'at_gun'
    PILLBOX = 'pillbox'
    BUNKER = 'bunker'
    MORTAR = 'mortar'
    BARRICADES = 'barricades'
    WATCHTOWER = 'watchtower'
    FLAMETHROWER = 'flamethrower'


class RosterSupplyViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=3, commands=0):
        super(RosterSupplyViewModel, self).__init__(properties=properties, commands=commands)

    def getIntCD(self):
        return self._getNumber(0)

    def setIntCD(self, value):
        self._setNumber(0, value)

    def getType(self):
        return SupplyType(self._getString(1))

    def setType(self, value):
        self._setString(1, value.value)

    def getDefenseCount(self):
        return self._getNumber(2)

    def setDefenseCount(self, value):
        self._setNumber(2, value)

    def _initialize(self):
        super(RosterSupplyViewModel, self)._initialize()
        self._addNumberProperty('intCD', 0)
        self._addStringProperty('type')
        self._addNumberProperty('defenseCount', 0)