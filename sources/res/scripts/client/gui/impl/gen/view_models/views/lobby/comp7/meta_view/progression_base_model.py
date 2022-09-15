from frameworks.wulf import ViewModel

class ProgressionBaseModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(ProgressionBaseModel, self).__init__(properties=properties, commands=commands)

    def getCurrentItemIndex(self):
        return self._getNumber(0)

    def setCurrentItemIndex(self, value):
        self._setNumber(0, value)

    def getTopPercentage(self):
        return self._getNumber(1)

    def setTopPercentage(self, value):
        self._setNumber(1, value)

    def _initialize(self):
        super(ProgressionBaseModel, self)._initialize()
        self._addNumberProperty('currentItemIndex', 0)
        self._addNumberProperty('topPercentage', 0)