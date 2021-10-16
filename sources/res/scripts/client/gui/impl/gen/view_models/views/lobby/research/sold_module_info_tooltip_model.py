from frameworks.wulf import Array
from frameworks.wulf import ViewModel

class SoldModuleInfoTooltipModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(SoldModuleInfoTooltipModel, self).__init__(properties=properties, commands=commands)

    def getCompatibleTanks(self):
        return self._getArray(0)

    def setCompatibleTanks(self, value):
        self._setArray(0, value)

    def _initialize(self):
        super(SoldModuleInfoTooltipModel, self)._initialize()
        self._addArrayProperty('compatibleTanks', Array())