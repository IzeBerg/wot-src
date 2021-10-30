from frameworks.wulf import Array
from gui.impl.gen import R
from frameworks.wulf import ViewModel

class CrewBookLackItemModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=5, commands=0):
        super(CrewBookLackItemModel, self).__init__(properties=properties, commands=commands)

    def getIcon(self):
        return self._getResource(0)

    def setIcon(self, value):
        self._setResource(0, value)

    def getTitle(self):
        return self._getResource(1)

    def setTitle(self, value):
        self._setResource(1, value)

    def getDescription(self):
        return self._getResource(2)

    def setDescription(self, value):
        self._setResource(2, value)

    def getDescriptionFmtArgs(self):
        return self._getArray(3)

    def setDescriptionFmtArgs(self, value):
        self._setArray(3, value)

    def getHasArrow(self):
        return self._getBool(4)

    def setHasArrow(self, value):
        self._setBool(4, value)

    def _initialize(self):
        super(CrewBookLackItemModel, self)._initialize()
        self._addResourceProperty('icon', R.invalid())
        self._addResourceProperty('title', R.invalid())
        self._addResourceProperty('description', R.invalid())
        self._addArrayProperty('descriptionFmtArgs', Array())
        self._addBoolProperty('hasArrow', True)