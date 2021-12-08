from frameworks.wulf import ViewModel

class NyMenuGiftTooltipModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(NyMenuGiftTooltipModel, self).__init__(properties=properties, commands=commands)

    def getIsBalanceAllowed(self):
        return self._getBool(0)

    def setIsBalanceAllowed(self, value):
        self._setBool(0, value)

    def getPostStampsCount(self):
        return self._getNumber(1)

    def setPostStampsCount(self, value):
        self._setNumber(1, value)

    def _initialize(self):
        super(NyMenuGiftTooltipModel, self)._initialize()
        self._addBoolProperty('isBalanceAllowed', False)
        self._addNumberProperty('postStampsCount', 0)