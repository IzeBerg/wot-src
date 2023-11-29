from frameworks.wulf import ViewModel

class BestFriendModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=3, commands=0):
        super(BestFriendModel, self).__init__(properties=properties, commands=commands)

    def getId(self):
        return self._getNumber(0)

    def setId(self, value):
        self._setNumber(0, value)

    def getIsRemoved(self):
        return self._getBool(1)

    def setIsRemoved(self, value):
        self._setBool(1, value)

    def getCooldown(self):
        return self._getNumber(2)

    def setCooldown(self, value):
        self._setNumber(2, value)

    def _initialize(self):
        super(BestFriendModel, self)._initialize()
        self._addNumberProperty('id', 0)
        self._addBoolProperty('isRemoved', False)
        self._addNumberProperty('cooldown', 0)