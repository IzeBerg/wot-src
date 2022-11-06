from frameworks.wulf import ViewModel

class ConvertedBoosterListItem(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(ConvertedBoosterListItem, self).__init__(properties=properties, commands=commands)

    def getCount(self):
        return self._getNumber(0)

    def setCount(self, value):
        self._setNumber(0, value)

    def getDescription(self):
        return self._getString(1)

    def setDescription(self, value):
        self._setString(1, value)

    def _initialize(self):
        super(ConvertedBoosterListItem, self)._initialize()
        self._addNumberProperty('count', 0)
        self._addStringProperty('description', '')