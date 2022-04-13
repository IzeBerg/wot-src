from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from gui.impl.gen.view_models.common.missions.bonuses.icon_bonus_model import IconBonusModel

class LeaderboardRewardsViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=3, commands=0):
        super(LeaderboardRewardsViewModel, self).__init__(properties=properties, commands=commands)

    def getMinRank(self):
        return self._getNumber(0)

    def setMinRank(self, value):
        self._setNumber(0, value)

    def getMaxRank(self):
        return self._getNumber(1)

    def setMaxRank(self, value):
        self._setNumber(1, value)

    def getBonuses(self):
        return self._getArray(2)

    def setBonuses(self, value):
        self._setArray(2, value)

    def _initialize(self):
        super(LeaderboardRewardsViewModel, self)._initialize()
        self._addNumberProperty('minRank', 0)
        self._addNumberProperty('maxRank', 0)
        self._addArrayProperty('bonuses', Array())