from enum import IntEnum
from frameworks.wulf import ViewModel
from gui.impl.wrappers.user_list_model import UserListModel
from gui.impl.gen.view_models.views.lobby.battle_pass.reward_item_model import RewardItemModel

class PackageType(IntEnum):
    BATTLEPASS = 0
    ANYLEVELS = 1
    SHOPOFFER = 2


class BattlePassBuyRewardsViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=7, commands=0):
        super(BattlePassBuyRewardsViewModel, self).__init__(properties=properties, commands=commands)

    @property
    def nowRewards(self):
        return self._getViewModel(0)

    @staticmethod
    def getNowRewardsType():
        return RewardItemModel

    @property
    def futureRewards(self):
        return self._getViewModel(1)

    @staticmethod
    def getFutureRewardsType():
        return RewardItemModel

    def getFromLevel(self):
        return self._getNumber(2)

    def setFromLevel(self, value):
        self._setNumber(2, value)

    def getToLevel(self):
        return self._getNumber(3)

    def setToLevel(self, value):
        self._setNumber(3, value)

    def getPackageState(self):
        return PackageType(self._getNumber(4))

    def setPackageState(self, value):
        self._setNumber(4, value.value)

    def getChapterID(self):
        return self._getNumber(5)

    def setChapterID(self, value):
        self._setNumber(5, value)

    def getFinalReward(self):
        return self._getString(6)

    def setFinalReward(self, value):
        self._setString(6, value)

    def _initialize(self):
        super(BattlePassBuyRewardsViewModel, self)._initialize()
        self._addViewModelProperty('nowRewards', UserListModel())
        self._addViewModelProperty('futureRewards', UserListModel())
        self._addNumberProperty('fromLevel', 0)
        self._addNumberProperty('toLevel', 0)
        self._addNumberProperty('packageState')
        self._addNumberProperty('chapterID', 0)
        self._addStringProperty('finalReward', '')