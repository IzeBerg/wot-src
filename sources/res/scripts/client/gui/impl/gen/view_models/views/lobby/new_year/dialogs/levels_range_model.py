from frameworks.wulf import ViewModel

class LevelsRangeModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(LevelsRangeModel, self).__init__(properties=properties, commands=commands)

    def getStartLevel(self):
        return self._getNumber(0)

    def setStartLevel(self, value):
        self._setNumber(0, value)

    def getCurrentLevel(self):
        return self._getNumber(1)

    def setCurrentLevel(self, value):
        self._setNumber(1, value)

    def _initialize(self):
        super(LevelsRangeModel, self)._initialize()
        self._addNumberProperty('startLevel', 0)
        self._addNumberProperty('currentLevel', 0)