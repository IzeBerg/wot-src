from frameworks.wulf import ViewModel

class TabModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(TabModel, self).__init__(properties=properties, commands=commands)

    def getCollectionName(self):
        return self._getString(0)

    def setCollectionName(self, value):
        self._setString(0, value)

    def getHasNewItems(self):
        return self._getBool(1)

    def setHasNewItems(self, value):
        self._setBool(1, value)

    def _initialize(self):
        super(TabModel, self)._initialize()
        self._addStringProperty('collectionName', '')
        self._addBoolProperty('hasNewItems', False)