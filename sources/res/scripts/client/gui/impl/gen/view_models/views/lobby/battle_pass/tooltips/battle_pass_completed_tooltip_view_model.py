from frameworks.wulf import ViewModel

class BattlePassCompletedTooltipViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(BattlePassCompletedTooltipViewModel, self).__init__(properties=properties, commands=commands)

    def getIsBattlePassPurchased(self):
        return self._getBool(0)

    def setIsBattlePassPurchased(self, value):
        self._setBool(0, value)

    def getNotChosenRewardCount(self):
        return self._getNumber(1)

    def setNotChosenRewardCount(self, value):
        self._setNumber(1, value)

    def _initialize(self):
        super(BattlePassCompletedTooltipViewModel, self)._initialize()
        self._addBoolProperty('isBattlePassPurchased', False)
        self._addNumberProperty('notChosenRewardCount', 0)