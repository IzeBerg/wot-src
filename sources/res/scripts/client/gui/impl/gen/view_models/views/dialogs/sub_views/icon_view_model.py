from gui.impl.gen import R
from frameworks.wulf import ViewModel

class IconViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(IconViewModel, self).__init__(properties=properties, commands=commands)

    def getPath(self):
        return self._getResource(0)

    def setPath(self, value):
        self._setResource(0, value)

    def _initialize(self):
        super(IconViewModel, self)._initialize()
        self._addResourceProperty('path', R.invalid())