from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from halloween.gui.impl.gen.view_models.views.lobby.bonus_item_view_model import BonusItemViewModel

class RewardsTooltipViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(RewardsTooltipViewModel, self).__init__(properties=properties, commands=commands)

    def getRewards(self):
        return self._getArray(0)

    def setRewards(self, value):
        self._setArray(0, value)

    @staticmethod
    def getRewardsType():
        return BonusItemViewModel

    def _initialize(self):
        super(RewardsTooltipViewModel, self)._initialize()
        self._addArrayProperty('rewards', Array())