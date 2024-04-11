from frameworks.wulf import ViewModel

class MoneyItemViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(MoneyItemViewModel, self).__init__(properties=properties, commands=commands)

    def getType(self):
        return self._getString(0)

    def setType(self, value):
        self._setString(0, value)

    def getCount(self):
        return self._getNumber(1)

    def setCount(self, value):
        self._setNumber(1, value)

    def _initialize(self):
        super(MoneyItemViewModel, self)._initialize()
        self._addStringProperty('type', '')
        self._addNumberProperty('count', 0)