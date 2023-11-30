from frameworks.wulf import ViewModel

class NyFriendsTooltip(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(NyFriendsTooltip, self).__init__(properties=properties, commands=commands)

    def getType(self):
        return self._getString(0)

    def setType(self, value):
        self._setString(0, value)

    def getPayload(self):
        return self._getString(1)

    def setPayload(self, value):
        self._setString(1, value)

    def _initialize(self):
        super(NyFriendsTooltip, self)._initialize()
        self._addStringProperty('type', '')
        self._addStringProperty('payload', '')