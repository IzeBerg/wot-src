from frameworks.wulf import ViewModel

class BattlePassNotStartedTooltipViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(BattlePassNotStartedTooltipViewModel, self).__init__(properties=properties, commands=commands)

    def getDate(self):
        return self._getString(0)

    def setDate(self, value):
        self._setString(0, value)

    def getSeasonNum(self):
        return self._getNumber(1)

    def setSeasonNum(self, value):
        self._setNumber(1, value)

    def _initialize(self):
        super(BattlePassNotStartedTooltipViewModel, self)._initialize()
        self._addStringProperty('date', '')
        self._addNumberProperty('seasonNum', 0)