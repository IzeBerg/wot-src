from frameworks.wulf import ViewModel

class BundlePriceModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=4, commands=0):
        super(BundlePriceModel, self).__init__(properties=properties, commands=commands)

    def getPrice(self):
        return self._getNumber(0)

    def setPrice(self, value):
        self._setNumber(0, value)

    def getDiscount(self):
        return self._getNumber(1)

    def setDiscount(self, value):
        self._setNumber(1, value)

    def getFullPrice(self):
        return self._getNumber(2)

    def setFullPrice(self, value):
        self._setNumber(2, value)

    def getCurrency(self):
        return self._getString(3)

    def setCurrency(self, value):
        self._setString(3, value)

    def _initialize(self):
        super(BundlePriceModel, self)._initialize()
        self._addNumberProperty('price', 0)
        self._addNumberProperty('discount', 0)
        self._addNumberProperty('fullPrice', 0)
        self._addStringProperty('currency', 'gold')