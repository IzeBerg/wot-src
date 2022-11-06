from frameworks.wulf import ViewModel

class SetupTabModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(SetupTabModel, self).__init__(properties=properties, commands=commands)

    def getName(self):
        return self._getString(0)

    def setName(self, value):
        self._setString(0, value)

    def getNewItemsCount(self):
        return self._getNumber(1)

    def setNewItemsCount(self, value):
        self._setNumber(1, value)

    def _initialize(self):
        super(SetupTabModel, self)._initialize()
        self._addStringProperty('name', '')
        self._addNumberProperty('newItemsCount', 0)