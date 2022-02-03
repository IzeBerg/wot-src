from frameworks.wulf import ViewModel

class BattlePassNoChapterTooltipViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(BattlePassNoChapterTooltipViewModel, self).__init__(properties=properties, commands=commands)

    def getPoints(self):
        return self._getNumber(0)

    def setPoints(self, value):
        self._setNumber(0, value)

    def _initialize(self):
        super(BattlePassNoChapterTooltipViewModel, self)._initialize()
        self._addNumberProperty('points', 0)