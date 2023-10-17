from frameworks.wulf import ViewModel

class StyleCardViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=9, commands=0):
        super(StyleCardViewModel, self).__init__(properties=properties, commands=commands)

    def getId(self):
        return self._getString(0)

    def setId(self, value):
        self._setString(0, value)

    def getName(self):
        return self._getString(1)

    def setName(self, value):
        self._setString(1, value)

    def getIcon(self):
        return self._getString(2)

    def setIcon(self, value):
        self._setString(2, value)

    def getLabel(self):
        return self._getString(3)

    def setLabel(self, value):
        self._setString(3, value)

    def getDescription(self):
        return self._getString(4)

    def setDescription(self, value):
        self._setString(4, value)

    def getIsHistorical(self):
        return self._getBool(5)

    def setIsHistorical(self, value):
        self._setBool(5, value)

    def getInventoryCount(self):
        return self._getNumber(6)

    def setInventoryCount(self, value):
        self._setNumber(6, value)

    def getPriceValue(self):
        return self._getNumber(7)

    def setPriceValue(self, value):
        self._setNumber(7, value)

    def getPriceType(self):
        return self._getString(8)

    def setPriceType(self, value):
        self._setString(8, value)

    def _initialize(self):
        super(StyleCardViewModel, self)._initialize()
        self._addStringProperty('id', '')
        self._addStringProperty('name', '')
        self._addStringProperty('icon', '')
        self._addStringProperty('label', '')
        self._addStringProperty('description', '')
        self._addBoolProperty('isHistorical', False)
        self._addNumberProperty('inventoryCount', 0)
        self._addNumberProperty('priceValue', 0)
        self._addStringProperty('priceType', '')