from frameworks.wulf import ViewModel

class NyLootBoxItemPopoverModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=3, commands=0):
        super(NyLootBoxItemPopoverModel, self).__init__(properties=properties, commands=commands)

    def getType(self):
        return self._getString(0)

    def setType(self, value):
        self._setString(0, value)

    def getIsExternalBuy(self):
        return self._getBool(1)

    def setIsExternalBuy(self, value):
        self._setBool(1, value)

    def getIsEnabled(self):
        return self._getBool(2)

    def setIsEnabled(self, value):
        self._setBool(2, value)

    def _initialize(self):
        super(NyLootBoxItemPopoverModel, self)._initialize()
        self._addStringProperty('type', '')
        self._addBoolProperty('isExternalBuy', False)
        self._addBoolProperty('isEnabled', True)