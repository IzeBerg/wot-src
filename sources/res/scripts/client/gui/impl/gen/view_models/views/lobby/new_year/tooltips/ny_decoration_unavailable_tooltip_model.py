from frameworks.wulf import ViewModel

class NyDecorationUnavailableTooltipModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(NyDecorationUnavailableTooltipModel, self).__init__(properties=properties, commands=commands)

    def getType(self):
        return self._getString(0)

    def setType(self, value):
        self._setString(0, value)

    def _initialize(self):
        super(NyDecorationUnavailableTooltipModel, self)._initialize()
        self._addStringProperty('type', '')