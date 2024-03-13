from frameworks.wulf import ViewModel

class RewardCurrencyTooltipViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(RewardCurrencyTooltipViewModel, self).__init__(properties=properties, commands=commands)

    def getCurrencyType(self):
        return self._getString(0)

    def setCurrencyType(self, value):
        self._setString(0, value)

    def getHasBonus(self):
        return self._getBool(1)

    def setHasBonus(self, value):
        self._setBool(1, value)

    def _initialize(self):
        super(RewardCurrencyTooltipViewModel, self)._initialize()
        self._addStringProperty('currencyType', '')
        self._addBoolProperty('hasBonus', False)