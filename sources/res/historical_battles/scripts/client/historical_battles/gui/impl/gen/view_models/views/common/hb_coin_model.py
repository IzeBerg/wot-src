from frameworks.wulf import ViewModel

class HbCoinModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(HbCoinModel, self).__init__(properties=properties, commands=commands)

    def getAmount(self):
        return self._getNumber(0)

    def setAmount(self, value):
        self._setNumber(0, value)

    def getType(self):
        return self._getString(1)

    def setType(self, value):
        self._setString(1, value)

    def _initialize(self):
        super(HbCoinModel, self)._initialize()
        self._addNumberProperty('amount', 0)
        self._addStringProperty('type', '')