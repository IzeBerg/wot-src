from frameworks.wulf import Array
from frameworks.wulf import ViewModel

class RankItemModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(RankItemModel, self).__init__(properties=properties, commands=commands)

    def getRankName(self):
        return self._getString(0)

    def setRankName(self, value):
        self._setString(0, value)

    def getRankPoints(self):
        return self._getArray(1)

    def setRankPoints(self, value):
        self._setArray(1, value)

    @staticmethod
    def getRankPointsType():
        return int

    def _initialize(self):
        super(RankItemModel, self)._initialize()
        self._addStringProperty('rankName', '')
        self._addArrayProperty('rankPoints', Array())