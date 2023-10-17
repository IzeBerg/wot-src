from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from gui.impl.gen.view_models.common.missions.bonuses.item_bonus_model import ItemBonusModel

class WinbackCallRewardsViewModel(ViewModel):
    __slots__ = ('onClose', )

    def __init__(self, properties=1, commands=1):
        super(WinbackCallRewardsViewModel, self).__init__(properties=properties, commands=commands)

    def getRewards(self):
        return self._getArray(0)

    def setRewards(self, value):
        self._setArray(0, value)

    @staticmethod
    def getRewardsType():
        return ItemBonusModel

    def _initialize(self):
        super(WinbackCallRewardsViewModel, self)._initialize()
        self._addArrayProperty('rewards', Array())
        self.onClose = self._addCommand('onClose')