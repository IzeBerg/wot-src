from frameworks.wulf import Array
from frameworks.wulf import ViewModel

class SeniorityAwardsMultiOpenRendererModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(SeniorityAwardsMultiOpenRendererModel, self).__init__(properties=properties, commands=commands)

    def getIndx(self):
        return self._getNumber(0)

    def setIndx(self, value):
        self._setNumber(0, value)

    def getRewards(self):
        return self._getArray(1)

    def setRewards(self, value):
        self._setArray(1, value)

    def _initialize(self):
        super(SeniorityAwardsMultiOpenRendererModel, self)._initialize()
        self._addNumberProperty('indx', 0)
        self._addArrayProperty('rewards', Array())