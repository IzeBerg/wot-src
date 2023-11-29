from frameworks.wulf import ViewModel

class NyLevelInfo(ViewModel):
    __slots__ = ()

    def __init__(self, properties=3, commands=0):
        super(NyLevelInfo, self).__init__(properties=properties, commands=commands)

    def getLevel(self):
        return self._getNumber(0)

    def setLevel(self, value):
        self._setNumber(0, value)

    def getInitialPoints(self):
        return self._getNumber(1)

    def setInitialPoints(self, value):
        self._setNumber(1, value)

    def getFinalPoints(self):
        return self._getNumber(2)

    def setFinalPoints(self, value):
        self._setNumber(2, value)

    def _initialize(self):
        super(NyLevelInfo, self)._initialize()
        self._addNumberProperty('level', 0)
        self._addNumberProperty('initialPoints', 0)
        self._addNumberProperty('finalPoints', 0)