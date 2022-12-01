from frameworks.wulf import ViewModel

class NyReplacementTimerTooltipModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(NyReplacementTimerTooltipModel, self).__init__(properties=properties, commands=commands)

    def getTimeTill(self):
        return self._getNumber(0)

    def setTimeTill(self, value):
        self._setNumber(0, value)

    def _initialize(self):
        super(NyReplacementTimerTooltipModel, self)._initialize()
        self._addNumberProperty('timeTill', 0)