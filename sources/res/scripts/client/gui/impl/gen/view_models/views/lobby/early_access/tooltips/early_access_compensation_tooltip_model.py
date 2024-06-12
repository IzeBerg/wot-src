from frameworks.wulf import ViewModel

class EarlyAccessCompensationTooltipModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(EarlyAccessCompensationTooltipModel, self).__init__(properties=properties, commands=commands)

    def getTokenCreditsCompensation(self):
        return self._getNumber(0)

    def setTokenCreditsCompensation(self, value):
        self._setNumber(0, value)

    def _initialize(self):
        super(EarlyAccessCompensationTooltipModel, self)._initialize()
        self._addNumberProperty('tokenCreditsCompensation', 0)