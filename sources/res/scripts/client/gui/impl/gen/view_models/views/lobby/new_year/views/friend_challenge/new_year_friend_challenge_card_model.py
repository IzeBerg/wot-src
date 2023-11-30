from frameworks.wulf import ViewModel

class NewYearFriendChallengeCardModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(NewYearFriendChallengeCardModel, self).__init__(properties=properties, commands=commands)

    def getCurrentQuantity(self):
        return self._getNumber(0)

    def setCurrentQuantity(self, value):
        self._setNumber(0, value)

    def getTotalQuantity(self):
        return self._getNumber(1)

    def setTotalQuantity(self, value):
        self._setNumber(1, value)

    def _initialize(self):
        super(NewYearFriendChallengeCardModel, self)._initialize()
        self._addNumberProperty('currentQuantity', 0)
        self._addNumberProperty('totalQuantity', 0)