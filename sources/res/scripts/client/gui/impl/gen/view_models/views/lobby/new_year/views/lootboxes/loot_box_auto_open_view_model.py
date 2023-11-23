from frameworks.wulf import ViewModel
from gui.impl.wrappers.user_list_model import UserListModel
from gui.impl.gen.view_models.views.lobby.new_year.views.lootboxes.loot_box_reward_row_model import LootBoxRewardRowModel

class LootBoxAutoOpenViewModel(ViewModel):
    __slots__ = ('onOkBtnClick', 'onCloseBtnClick')

    def __init__(self, properties=4, commands=2):
        super(LootBoxAutoOpenViewModel, self).__init__(properties=properties, commands=commands)

    @property
    def rewardRows(self):
        return self._getViewModel(0)

    @staticmethod
    def getRewardRowsType():
        return LootBoxRewardRowModel

    def getSmallBoxesQuantity(self):
        return self._getNumber(1)

    def setSmallBoxesQuantity(self, value):
        self._setNumber(1, value)

    def getBigBoxesQuantity(self):
        return self._getNumber(2)

    def setBigBoxesQuantity(self, value):
        self._setNumber(2, value)

    def getGiftsQuantity(self):
        return self._getNumber(3)

    def setGiftsQuantity(self, value):
        self._setNumber(3, value)

    def _initialize(self):
        super(LootBoxAutoOpenViewModel, self)._initialize()
        self._addViewModelProperty('rewardRows', UserListModel())
        self._addNumberProperty('smallBoxesQuantity', 0)
        self._addNumberProperty('bigBoxesQuantity', 0)
        self._addNumberProperty('giftsQuantity', 0)
        self.onOkBtnClick = self._addCommand('onOkBtnClick')
        self.onCloseBtnClick = self._addCommand('onCloseBtnClick')