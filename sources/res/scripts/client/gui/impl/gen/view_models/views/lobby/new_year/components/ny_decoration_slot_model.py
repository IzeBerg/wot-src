from gui.impl.gen import R
from frameworks.wulf import ViewModel

class NyDecorationSlotModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=7, commands=0):
        super(NyDecorationSlotModel, self).__init__(properties=properties, commands=commands)

    def getToyID(self):
        return self._getNumber(0)

    def setToyID(self, value):
        self._setNumber(0, value)

    def getImageName(self):
        return self._getString(1)

    def setImageName(self, value):
        self._setString(1, value)

    def getTitle(self):
        return self._getResource(2)

    def setTitle(self, value):
        self._setResource(2, value)

    def getDescription(self):
        return self._getResource(3)

    def setDescription(self, value):
        self._setResource(3, value)

    def getIsMega(self):
        return self._getBool(4)

    def setIsMega(self, value):
        self._setBool(4, value)

    def getAtmosphereBonus(self):
        return self._getNumber(5)

    def setAtmosphereBonus(self, value):
        self._setNumber(5, value)

    def getType(self):
        return self._getString(6)

    def setType(self, value):
        self._setString(6, value)

    def _initialize(self):
        super(NyDecorationSlotModel, self)._initialize()
        self._addNumberProperty('toyID', 0)
        self._addStringProperty('imageName', '')
        self._addResourceProperty('title', R.invalid())
        self._addResourceProperty('description', R.invalid())
        self._addBoolProperty('isMega', False)
        self._addNumberProperty('atmosphereBonus', 0)
        self._addStringProperty('type', '')