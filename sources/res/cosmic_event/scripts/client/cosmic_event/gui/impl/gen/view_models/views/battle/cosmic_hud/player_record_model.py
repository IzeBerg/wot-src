from frameworks.wulf import ViewModel

class PlayerRecordModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=6, commands=0):
        super(PlayerRecordModel, self).__init__(properties=properties, commands=commands)

    def getName(self):
        return self._getString(0)

    def setName(self, value):
        self._setString(0, value)

    def getClanAbbrev(self):
        return self._getString(1)

    def setClanAbbrev(self, value):
        self._setString(1, value)

    def getScore(self):
        return self._getNumber(2)

    def setScore(self, value):
        self._setNumber(2, value)

    def getIsLastOffender(self):
        return self._getBool(3)

    def setIsLastOffender(self, value):
        self._setBool(3, value)

    def getIsAlive(self):
        return self._getBool(4)

    def setIsAlive(self, value):
        self._setBool(4, value)

    def getIsLeader(self):
        return self._getBool(5)

    def setIsLeader(self, value):
        self._setBool(5, value)

    def _initialize(self):
        super(PlayerRecordModel, self)._initialize()
        self._addStringProperty('name', '')
        self._addStringProperty('clanAbbrev', '')
        self._addNumberProperty('score', 0)
        self._addBoolProperty('isLastOffender', False)
        self._addBoolProperty('isAlive', True)
        self._addBoolProperty('isLeader', False)