from frameworks.wulf import ViewModel

class CurrencyItemModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=3, commands=0):
        super(CurrencyItemModel, self).__init__(properties=properties, commands=commands)

    def getValue(self):
        return self._getString(0)

    def setValue(self, value):
        self._setString(0, value)

    def getCurrency(self):
        return self._getString(1)

    def setCurrency(self, value):
        self._setString(1, value)

    def getSpecialTooltip(self):
        return self._getString(2)

    def setSpecialTooltip(self, value):
        self._setString(2, value)

    def _initialize(self):
        super(CurrencyItemModel, self)._initialize()
        self._addStringProperty('value', '--')
        self._addStringProperty('currency', '')
        self._addStringProperty('specialTooltip', '')