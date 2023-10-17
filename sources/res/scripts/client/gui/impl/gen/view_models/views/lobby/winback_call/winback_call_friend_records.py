from frameworks.wulf import ViewModel

class WinbackCallFriendRecords(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(WinbackCallFriendRecords, self).__init__(properties=properties, commands=commands)

    def getType(self):
        return self._getString(0)

    def setType(self, value):
        self._setString(0, value)

    def getValue(self):
        return self._getNumber(1)

    def setValue(self, value):
        self._setNumber(1, value)

    def _initialize(self):
        super(WinbackCallFriendRecords, self)._initialize()
        self._addStringProperty('type', '')
        self._addNumberProperty('value', 0)