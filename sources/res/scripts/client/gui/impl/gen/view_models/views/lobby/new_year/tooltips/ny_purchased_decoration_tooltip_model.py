from gui.impl.gen import R
from frameworks.wulf import ViewModel

class NyPurchasedDecorationTooltipModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=7, commands=0):
        super(NyPurchasedDecorationTooltipModel, self).__init__(properties=properties, commands=commands)

    def getName(self):
        return self._getResource(0)

    def setName(self, value):
        self._setResource(0, value)

    def getDescription(self):
        return self._getResource(1)

    def setDescription(self, value):
        self._setResource(1, value)

    def getType(self):
        return self._getString(2)

    def setType(self, value):
        self._setString(2, value)

    def getIcon(self):
        return self._getResource(3)

    def setIcon(self, value):
        self._setResource(3, value)

    def getTimeTill(self):
        return self._getNumber(4)

    def setTimeTill(self, value):
        self._setNumber(4, value)

    def getRentPrice(self):
        return self._getNumber(5)

    def setRentPrice(self, value):
        self._setNumber(5, value)

    def getState(self):
        return self._getString(6)

    def setState(self, value):
        self._setString(6, value)

    def _initialize(self):
        super(NyPurchasedDecorationTooltipModel, self)._initialize()
        self._addResourceProperty('name', R.invalid())
        self._addResourceProperty('description', R.invalid())
        self._addStringProperty('type', '')
        self._addResourceProperty('icon', R.invalid())
        self._addNumberProperty('timeTill', 0)
        self._addNumberProperty('rentPrice', 0)
        self._addStringProperty('state', '')