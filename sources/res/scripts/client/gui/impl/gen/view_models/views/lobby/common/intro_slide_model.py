from gui.impl.gen import R
from frameworks.wulf import ViewModel

class IntroSlideModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=3, commands=0):
        super(IntroSlideModel, self).__init__(properties=properties, commands=commands)

    def getIcon(self):
        return self._getResource(0)

    def setIcon(self, value):
        self._setResource(0, value)

    def getTitle(self):
        return self._getResource(1)

    def setTitle(self, value):
        self._setResource(1, value)

    def getDescription(self):
        return self._getString(2)

    def setDescription(self, value):
        self._setString(2, value)

    def _initialize(self):
        super(IntroSlideModel, self)._initialize()
        self._addResourceProperty('icon', R.invalid())
        self._addResourceProperty('title', R.invalid())
        self._addStringProperty('description', '')