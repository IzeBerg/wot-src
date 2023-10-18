from frameworks.wulf import ViewModel

class EquipmentPriceModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=3, commands=0):
        super(EquipmentPriceModel, self).__init__(properties=properties, commands=commands)

    def getType(self):
        return self._getString(0)

    def setType(self, value):
        self._setString(0, value)

    def getAmount(self):
        return self._getNumber(1)

    def setAmount(self, value):
        self._setNumber(1, value)

    def getPrice(self):
        return self._getNumber(2)

    def setPrice(self, value):
        self._setNumber(2, value)

    def _initialize(self):
        super(EquipmentPriceModel, self)._initialize()
        self._addStringProperty('type', '')
        self._addNumberProperty('amount', 0)
        self._addNumberProperty('price', 0)