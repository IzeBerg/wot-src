from gui.impl.gen import R
from frameworks.wulf import ViewModel

class CommanderCmpPerkModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(CommanderCmpPerkModel, self).__init__(properties=properties, commands=commands)

    def getIcon(self):
        return self._getResource(0)

    def setIcon(self, value):
        self._setResource(0, value)

    def getTooltipID(self):
        return self._getString(1)

    def setTooltipID(self, value):
        self._setString(1, value)

    def _initialize(self):
        super(CommanderCmpPerkModel, self)._initialize()
        self._addResourceProperty('icon', R.invalid())
        self._addStringProperty('tooltipID', '')