from frameworks.wulf import ViewModel

class BattlePassGoldMissionTooltipViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(BattlePassGoldMissionTooltipViewModel, self).__init__(properties=properties, commands=commands)

    def getCount(self):
        return self._getNumber(0)

    def setCount(self, value):
        self._setNumber(0, value)

    def getDays(self):
        return self._getNumber(1)

    def setDays(self, value):
        self._setNumber(1, value)

    def _initialize(self):
        super(BattlePassGoldMissionTooltipViewModel, self)._initialize()
        self._addNumberProperty('count', 0)
        self._addNumberProperty('days', 0)