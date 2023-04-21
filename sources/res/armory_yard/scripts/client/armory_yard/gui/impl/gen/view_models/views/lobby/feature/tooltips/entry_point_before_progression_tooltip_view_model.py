from frameworks.wulf import ViewModel

class EntryPointBeforeProgressionTooltipViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(EntryPointBeforeProgressionTooltipViewModel, self).__init__(properties=properties, commands=commands)

    def getStartTimestamp(self):
        return self._getNumber(0)

    def setStartTimestamp(self, value):
        self._setNumber(0, value)

    def _initialize(self):
        super(EntryPointBeforeProgressionTooltipViewModel, self)._initialize()
        self._addNumberProperty('startTimestamp', 0)