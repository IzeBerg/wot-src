from frameworks.wulf import ViewModel
from gui.impl.wrappers.user_list_model import UserListModel
from gui.impl.gen.view_models.views.lobby.battle_pass.reward_item_model import RewardItemModel

class RewardLevelModel(ViewModel):
    __slots__ = ()
    DISABLED = 0
    NOT_REACHED = 1
    REACHED = 2
    NOT_CHOSEN = 3

    def __init__(self, properties=7, commands=0):
        super(RewardLevelModel, self).__init__(properties=properties, commands=commands)

    @property
    def rewardItems(self):
        return self._getViewModel(0)

    def getLevel(self):
        return self._getNumber(1)

    def setLevel(self, value):
        self._setNumber(1, value)

    def getLevelPoints(self):
        return self._getNumber(2)

    def setLevelPoints(self, value):
        self._setNumber(2, value)

    def getIsRare(self):
        return self._getBool(3)

    def setIsRare(self, value):
        self._setBool(3, value)

    def getState(self):
        return self._getNumber(4)

    def setState(self, value):
        self._setNumber(4, value)

    def getNeedTake(self):
        return self._getBool(5)

    def setNeedTake(self, value):
        self._setBool(5, value)

    def getIsRewardChoiceEnabled(self):
        return self._getBool(6)

    def setIsRewardChoiceEnabled(self, value):
        self._setBool(6, value)

    def _initialize(self):
        super(RewardLevelModel, self)._initialize()
        self._addViewModelProperty('rewardItems', UserListModel())
        self._addNumberProperty('level', 0)
        self._addNumberProperty('levelPoints', 0)
        self._addBoolProperty('isRare', False)
        self._addNumberProperty('state', -1)
        self._addBoolProperty('needTake', False)
        self._addBoolProperty('isRewardChoiceEnabled', False)