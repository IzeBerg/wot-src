from enum import Enum
from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from gui.impl.gen.view_models.views.lobby.new_year.views.challenge.progress_reward_item_model import ProgressRewardItemModel

class Type(Enum):
    CHALLENGE = 'challenge'
    QUEST = 'quest'


class ChallengeRewardViewModel(ViewModel):
    __slots__ = ('onStylePreview', )
    LOW_GRAPHICS_PRESET = 4

    def __init__(self, properties=6, commands=1):
        super(ChallengeRewardViewModel, self).__init__(properties=properties, commands=commands)

    def getCompletedQuests(self):
        return self._getNumber(0)

    def setCompletedQuests(self, value):
        self._setNumber(0, value)

    def getRewards(self):
        return self._getArray(1)

    def setRewards(self, value):
        self._setArray(1, value)

    @staticmethod
    def getRewardsType():
        return ProgressRewardItemModel

    def getRecommendedGraphicsPreset(self):
        return self._getNumber(2)

    def setRecommendedGraphicsPreset(self, value):
        self._setNumber(2, value)

    def getType(self):
        return Type(self._getString(3))

    def setType(self, value):
        self._setString(3, value.value)

    def getCelebrity(self):
        return self._getString(4)

    def setCelebrity(self, value):
        self._setString(4, value)

    def getIsDiscountSelected(self):
        return self._getBool(5)

    def setIsDiscountSelected(self, value):
        self._setBool(5, value)

    def _initialize(self):
        super(ChallengeRewardViewModel, self)._initialize()
        self._addNumberProperty('completedQuests', 0)
        self._addArrayProperty('rewards', Array())
        self._addNumberProperty('recommendedGraphicsPreset', 0)
        self._addStringProperty('type')
        self._addStringProperty('celebrity', '')
        self._addBoolProperty('isDiscountSelected', False)
        self.onStylePreview = self._addCommand('onStylePreview')