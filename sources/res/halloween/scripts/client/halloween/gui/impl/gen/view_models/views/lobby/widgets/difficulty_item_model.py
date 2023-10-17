from enum import Enum
from frameworks.wulf import ViewModel

class StateEnum(Enum):
    DEFAULT = 'default'
    SELECTED = 'selected'
    LOCKED = 'locked'


class DifficultyItemModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(DifficultyItemModel, self).__init__(properties=properties, commands=commands)

    def getLevel(self):
        return self._getNumber(0)

    def setLevel(self, value):
        self._setNumber(0, value)

    def getState(self):
        return StateEnum(self._getString(1))

    def setState(self, value):
        self._setString(1, value.value)

    def _initialize(self):
        super(DifficultyItemModel, self)._initialize()
        self._addNumberProperty('level', 0)
        self._addStringProperty('state')