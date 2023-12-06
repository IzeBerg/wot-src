from frameworks.wulf import ViewModel

class NyMultiplierValue(ViewModel):
    __slots__ = ()

    def __init__(self, properties=3, commands=0):
        super(NyMultiplierValue, self).__init__(properties=properties, commands=commands)

    def getToys(self):
        return self._getString(0)

    def setToys(self, value):
        self._setString(0, value)

    def getMultiplier(self):
        return self._getNumber(1)

    def setMultiplier(self, value):
        self._setNumber(1, value)

    def getIsEnabled(self):
        return self._getBool(2)

    def setIsEnabled(self, value):
        self._setBool(2, value)

    def _initialize(self):
        super(NyMultiplierValue, self)._initialize()
        self._addStringProperty('toys', '1-10')
        self._addNumberProperty('multiplier', 1)
        self._addBoolProperty('isEnabled', False)