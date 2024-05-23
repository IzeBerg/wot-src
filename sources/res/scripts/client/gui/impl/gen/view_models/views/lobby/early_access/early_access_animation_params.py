from frameworks.wulf import ViewModel

class EarlyAccessAnimationParams(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(EarlyAccessAnimationParams, self).__init__(properties=properties, commands=commands)

    def getStart(self):
        return self._getNumber(0)

    def setStart(self, value):
        self._setNumber(0, value)

    def getEnd(self):
        return self._getNumber(1)

    def setEnd(self, value):
        self._setNumber(1, value)

    def _initialize(self):
        super(EarlyAccessAnimationParams, self)._initialize()
        self._addNumberProperty('start', 0)
        self._addNumberProperty('end', 0)