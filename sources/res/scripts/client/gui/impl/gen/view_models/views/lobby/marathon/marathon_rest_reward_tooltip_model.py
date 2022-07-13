from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from gui.impl.gen.view_models.views.lobby.marathon.bonus_model import BonusModel

class MarathonRestRewardTooltipModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(MarathonRestRewardTooltipModel, self).__init__(properties=properties, commands=commands)

    def getRewards(self):
        return self._getArray(0)

    def setRewards(self, value):
        self._setArray(0, value)

    @staticmethod
    def getRewardsType():
        return BonusModel

    def _initialize(self):
        super(MarathonRestRewardTooltipModel, self)._initialize()
        self._addArrayProperty('rewards', Array())