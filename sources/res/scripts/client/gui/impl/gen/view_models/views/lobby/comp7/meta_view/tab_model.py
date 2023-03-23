from enum import IntEnum
from frameworks.wulf import ViewModel

class Tabs(IntEnum):
    PROGRESSION = 0
    RANKREWARDS = 1
    WEEKLYQUESTS = 2
    LEADERBOARD = 3


class TabModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(TabModel, self).__init__(properties=properties, commands=commands)

    def getName(self):
        return Tabs(self._getNumber(0))

    def setName(self, value):
        self._setNumber(0, value.value)

    def _initialize(self):
        super(TabModel, self)._initialize()
        self._addNumberProperty('name')