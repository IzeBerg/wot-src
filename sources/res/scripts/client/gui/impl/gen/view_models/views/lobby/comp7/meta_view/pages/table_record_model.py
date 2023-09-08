from enum import IntEnum
from frameworks.wulf import ViewModel

class Rank(IntEnum):
    FIRST = 6
    SECOND = 5
    THIRD = 4
    FOURTH = 3
    FIFTH = 2
    SIXTH = 1


class TableRecordModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=8, commands=0):
        super(TableRecordModel, self).__init__(properties=properties, commands=commands)

    def getPosition(self):
        return self._getNumber(0)

    def setPosition(self, value):
        self._setNumber(0, value)

    def getBattlesCount(self):
        return self._getNumber(1)

    def setBattlesCount(self, value):
        self._setNumber(1, value)

    def getRank(self):
        return Rank(self._getNumber(2))

    def setRank(self, value):
        self._setNumber(2, value.value)

    def getUserName(self):
        return self._getString(3)

    def setUserName(self, value):
        self._setString(3, value)

    def getClanTag(self):
        return self._getString(4)

    def setClanTag(self, value):
        self._setString(4, value)

    def getClanTagColor(self):
        return self._getString(5)

    def setClanTagColor(self, value):
        self._setString(5, value)

    def getScore(self):
        return self._getNumber(6)

    def setScore(self, value):
        self._setNumber(6, value)

    def getSpaID(self):
        return self._getNumber(7)

    def setSpaID(self, value):
        self._setNumber(7, value)

    def _initialize(self):
        super(TableRecordModel, self)._initialize()
        self._addNumberProperty('position', 0)
        self._addNumberProperty('battlesCount', 0)
        self._addNumberProperty('rank')
        self._addStringProperty('userName', '')
        self._addStringProperty('clanTag', '')
        self._addStringProperty('clanTagColor', '')
        self._addNumberProperty('score', 0)
        self._addNumberProperty('spaID', 0)