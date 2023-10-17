from frameworks.wulf import ViewModel

class NotEnoughKeyTooltipViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(NotEnoughKeyTooltipViewModel, self).__init__(properties=properties, commands=commands)

    def getKeyCount(self):
        return self._getNumber(0)

    def setKeyCount(self, value):
        self._setNumber(0, value)

    def _initialize(self):
        super(NotEnoughKeyTooltipViewModel, self)._initialize()
        self._addNumberProperty('keyCount', 0)