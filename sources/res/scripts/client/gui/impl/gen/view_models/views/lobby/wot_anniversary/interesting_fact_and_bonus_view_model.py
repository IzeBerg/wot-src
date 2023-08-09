from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from gui.impl.gen.view_models.views.lobby.wot_anniversary.reward_item_model import RewardItemModel

class InterestingFactAndBonusViewModel(ViewModel):
    __slots__ = ('onOpenEventInfo', )

    def __init__(self, properties=4, commands=1):
        super(InterestingFactAndBonusViewModel, self).__init__(properties=properties, commands=commands)

    def getCurrentDay(self):
        return self._getNumber(0)

    def setCurrentDay(self, value):
        self._setNumber(0, value)

    def getTotalDays(self):
        return self._getNumber(1)

    def setTotalDays(self, value):
        self._setNumber(1, value)

    def getCardsUrls(self):
        return self._getArray(2)

    def setCardsUrls(self, value):
        self._setArray(2, value)

    @staticmethod
    def getCardsUrlsType():
        return unicode

    def getRewards(self):
        return self._getArray(3)

    def setRewards(self, value):
        self._setArray(3, value)

    @staticmethod
    def getRewardsType():
        return RewardItemModel

    def _initialize(self):
        super(InterestingFactAndBonusViewModel, self)._initialize()
        self._addNumberProperty('currentDay', 1)
        self._addNumberProperty('totalDays', 10)
        self._addArrayProperty('cardsUrls', Array())
        self._addArrayProperty('rewards', Array())
        self.onOpenEventInfo = self._addCommand('onOpenEventInfo')