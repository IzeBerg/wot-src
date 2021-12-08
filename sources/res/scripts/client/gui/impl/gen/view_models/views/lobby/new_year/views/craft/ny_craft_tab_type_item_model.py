from frameworks.wulf import ViewModel

class NyCraftTabTypeItemModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(NyCraftTabTypeItemModel, self).__init__(properties=properties, commands=commands)

    def getGroupName(self):
        return self._getString(0)

    def setGroupName(self, value):
        self._setString(0, value)

    def getType(self):
        return self._getString(1)

    def setType(self, value):
        self._setString(1, value)

    def _initialize(self):
        super(NyCraftTabTypeItemModel, self)._initialize()
        self._addStringProperty('groupName', '')
        self._addStringProperty('type', '')