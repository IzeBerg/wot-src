from gui.impl.gen import R
from frameworks.wulf import ViewModel

class NoBonusPlaceholderModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(NoBonusPlaceholderModel, self).__init__(properties=properties, commands=commands)

    def getText(self):
        return self._getString(0)

    def setText(self, value):
        self._setString(0, value)

    def getIcon(self):
        return self._getResource(1)

    def setIcon(self, value):
        self._setResource(1, value)

    def _initialize(self):
        super(NoBonusPlaceholderModel, self)._initialize()
        self._addStringProperty('text', '')
        self._addResourceProperty('icon', R.invalid())