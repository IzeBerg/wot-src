from frameworks.wulf import ViewModel

class ExtendedTextTooltipModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(ExtendedTextTooltipModel, self).__init__(properties=properties, commands=commands)

    def getText(self):
        return self._getString(0)

    def setText(self, value):
        self._setString(0, value)

    def getStringifyKwargs(self):
        return self._getString(1)

    def setStringifyKwargs(self, value):
        self._setString(1, value)

    def _initialize(self):
        super(ExtendedTextTooltipModel, self)._initialize()
        self._addStringProperty('text', '')
        self._addStringProperty('stringifyKwargs', '')