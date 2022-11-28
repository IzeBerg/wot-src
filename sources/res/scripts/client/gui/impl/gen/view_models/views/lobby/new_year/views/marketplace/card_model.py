from frameworks.wulf import ViewModel

class CardModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=4, commands=0):
        super(CardModel, self).__init__(properties=properties, commands=commands)

    def getKitIndex(self):
        return self._getNumber(0)

    def setKitIndex(self, value):
        self._setNumber(0, value)

    def getKitState(self):
        return self._getString(1)

    def setKitState(self, value):
        self._setString(1, value)

    def getKitName(self):
        return self._getString(2)

    def setKitName(self, value):
        self._setString(2, value)

    def getDiscount(self):
        return self._getNumber(3)

    def setDiscount(self, value):
        self._setNumber(3, value)

    def _initialize(self):
        super(CardModel, self)._initialize()
        self._addNumberProperty('kitIndex', 0)
        self._addStringProperty('kitState', '')
        self._addStringProperty('kitName', '')
        self._addNumberProperty('discount', 0)