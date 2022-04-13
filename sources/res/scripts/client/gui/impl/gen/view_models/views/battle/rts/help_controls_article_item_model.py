from gui.impl.gen import R
from frameworks.wulf import ViewModel

class HelpControlsArticleItemModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(HelpControlsArticleItemModel, self).__init__(properties=properties, commands=commands)

    def getAction(self):
        return self._getResource(0)

    def setAction(self, value):
        self._setResource(0, value)

    def getKeyHint(self):
        return self._getString(1)

    def setKeyHint(self, value):
        self._setString(1, value)

    def _initialize(self):
        super(HelpControlsArticleItemModel, self)._initialize()
        self._addResourceProperty('action', R.invalid())
        self._addStringProperty('keyHint', '')