from frameworks.wulf import ViewModel

class ExchangeRateModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(ExchangeRateModel, self).__init__(properties=properties, commands=commands)

    def getGoldRateValue(self):
        return self._getNumber(0)

    def setGoldRateValue(self, value):
        self._setNumber(0, value)

    def getResourceRateValue(self):
        return self._getNumber(1)

    def setResourceRateValue(self, value):
        self._setNumber(1, value)

    def _initialize(self):
        super(ExchangeRateModel, self)._initialize()
        self._addNumberProperty('goldRateValue', 1)
        self._addNumberProperty('resourceRateValue', 1)