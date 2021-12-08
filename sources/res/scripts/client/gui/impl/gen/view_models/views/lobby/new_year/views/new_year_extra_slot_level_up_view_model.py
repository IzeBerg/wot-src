from frameworks.wulf import ViewModel

class NewYearExtraSlotLevelUpViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(NewYearExtraSlotLevelUpViewModel, self).__init__(properties=properties, commands=commands)

    def getMinLevel(self):
        return self._getNumber(0)

    def setMinLevel(self, value):
        self._setNumber(0, value)

    def getMaxLevel(self):
        return self._getNumber(1)

    def setMaxLevel(self, value):
        self._setNumber(1, value)

    def _initialize(self):
        super(NewYearExtraSlotLevelUpViewModel, self)._initialize()
        self._addNumberProperty('minLevel', 0)
        self._addNumberProperty('maxLevel', 0)