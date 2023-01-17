from frameworks.wulf import Array
from frameworks.wulf import ViewModel

class BattleAbilityByRankModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(BattleAbilityByRankModel, self).__init__(properties=properties, commands=commands)

    def getName(self):
        return self._getString(0)

    def setName(self, value):
        self._setString(0, value)

    def getRankValues(self):
        return self._getArray(1)

    def setRankValues(self, value):
        self._setArray(1, value)

    @staticmethod
    def getRankValuesType():
        return unicode

    def _initialize(self):
        super(BattleAbilityByRankModel, self)._initialize()
        self._addStringProperty('name', '')
        self._addArrayProperty('rankValues', Array())