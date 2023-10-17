from frameworks.wulf import ViewModel

class BundleBonusModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=3, commands=0):
        super(BundleBonusModel, self).__init__(properties=properties, commands=commands)

    def getId(self):
        return self._getString(0)

    def setId(self, value):
        self._setString(0, value)

    def getName(self):
        return self._getString(1)

    def setName(self, value):
        self._setString(1, value)

    def getValue(self):
        return self._getString(2)

    def setValue(self, value):
        self._setString(2, value)

    def _initialize(self):
        super(BundleBonusModel, self)._initialize()
        self._addStringProperty('id', '')
        self._addStringProperty('name', '')
        self._addStringProperty('value', '')