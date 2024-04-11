from frameworks.wulf import ViewModel

class HbCoinExchangeTooltipModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(HbCoinExchangeTooltipModel, self).__init__(properties=properties, commands=commands)

    def getCountDownSeconds(self):
        return self._getNumber(0)

    def setCountDownSeconds(self, value):
        self._setNumber(0, value)

    def _initialize(self):
        super(HbCoinExchangeTooltipModel, self)._initialize()
        self._addNumberProperty('countDownSeconds', 0)