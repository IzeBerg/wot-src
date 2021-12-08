from frameworks.wulf import ViewModel
from gui.impl.wrappers.user_list_model import UserListModel

class LootBoxRewardRowModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=4, commands=0):
        super(LootBoxRewardRowModel, self).__init__(properties=properties, commands=commands)

    @property
    def rewards(self):
        return self._getViewModel(0)

    def getLabel(self):
        return self._getString(1)

    def setLabel(self, value):
        self._setString(1, value)

    def getRewardsCount(self):
        return self._getNumber(2)

    def setRewardsCount(self, value):
        self._setNumber(2, value)

    def getBonusType(self):
        return self._getString(3)

    def setBonusType(self, value):
        self._setString(3, value)

    def _initialize(self):
        super(LootBoxRewardRowModel, self)._initialize()
        self._addViewModelProperty('rewards', UserListModel())
        self._addStringProperty('label', '')
        self._addNumberProperty('rewardsCount', 0)
        self._addStringProperty('bonusType', '')