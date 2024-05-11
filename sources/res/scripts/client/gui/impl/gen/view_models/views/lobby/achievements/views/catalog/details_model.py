from enum import Enum
from frameworks.wulf import Array
from gui.impl.gen.view_models.views.lobby.achievements.advanced_achievement_model import AdvancedAchievementModel
from gui.impl.gen.view_models.views.lobby.achievements.views.catalog.rewards_model import RewardsModel

class ProgressType(Enum):
    PERCENTAGE = 'percentage'
    STEPPED = 'stepped'


class DetailsModel(AdvancedAchievementModel):
    __slots__ = ()

    def __init__(self, properties=16, commands=0):
        super(DetailsModel, self).__init__(properties=properties, commands=commands)

    def getProgressType(self):
        return ProgressType(self._getString(14))

    def setProgressType(self, value):
        self._setString(14, value.value)

    def getRewards(self):
        return self._getArray(15)

    def setRewards(self, value):
        self._setArray(15, value)

    @staticmethod
    def getRewardsType():
        return RewardsModel

    def _initialize(self):
        super(DetailsModel, self)._initialize()
        self._addStringProperty('progressType')
        self._addArrayProperty('rewards', Array())