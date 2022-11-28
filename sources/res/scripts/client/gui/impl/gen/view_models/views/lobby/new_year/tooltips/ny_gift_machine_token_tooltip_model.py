from frameworks.wulf import ViewModel

class NyGiftMachineTokenTooltipModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(NyGiftMachineTokenTooltipModel, self).__init__(properties=properties, commands=commands)

    def getTokenCount(self):
        return self._getNumber(0)

    def setTokenCount(self, value):
        self._setNumber(0, value)

    def _initialize(self):
        super(NyGiftMachineTokenTooltipModel, self)._initialize()
        self._addNumberProperty('tokenCount', 0)