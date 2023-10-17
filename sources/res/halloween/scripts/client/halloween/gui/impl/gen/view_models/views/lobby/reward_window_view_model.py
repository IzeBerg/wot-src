from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from halloween.gui.impl.gen.view_models.views.lobby.bonus_item_view_model import BonusItemViewModel

class RewardWindowViewModel(ViewModel):
    __slots__ = ('onClose', )

    def __init__(self, properties=2, commands=1):
        super(RewardWindowViewModel, self).__init__(properties=properties, commands=commands)

    def getDifficulty(self):
        return self._getNumber(0)

    def setDifficulty(self, value):
        self._setNumber(0, value)

    def getRewards(self):
        return self._getArray(1)

    def setRewards(self, value):
        self._setArray(1, value)

    @staticmethod
    def getRewardsType():
        return BonusItemViewModel

    def _initialize(self):
        super(RewardWindowViewModel, self)._initialize()
        self._addNumberProperty('difficulty', 0)
        self._addArrayProperty('rewards', Array())
        self.onClose = self._addCommand('onClose')