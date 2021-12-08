from gui.impl.gen.view_models.ui_kit.list_model import ListModel
from gui.impl.gen.view_models.windows.reward_window_content_model import RewardWindowContentModel

class LootBoxRewardWindowContentModel(RewardWindowContentModel):
    __slots__ = ()

    def __init__(self, properties=7, commands=3):
        super(LootBoxRewardWindowContentModel, self).__init__(properties=properties, commands=commands)

    @property
    def rewardsList(self):
        return self._getViewModel(3)

    def getRewardsCount(self):
        return self._getNumber(4)

    def setRewardsCount(self, value):
        self._setNumber(4, value)

    def getLootboxType(self):
        return self._getString(5)

    def setLootboxType(self, value):
        self._setString(5, value)

    def getIsFree(self):
        return self._getBool(6)

    def setIsFree(self, value):
        self._setBool(6, value)

    def _initialize(self):
        super(LootBoxRewardWindowContentModel, self)._initialize()
        self._addViewModelProperty('rewardsList', ListModel())
        self._addNumberProperty('rewardsCount', 0)
        self._addStringProperty('lootboxType', '')
        self._addBoolProperty('isFree', False)