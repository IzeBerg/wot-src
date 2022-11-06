from frameworks.wulf import ViewModel

class NeedRepairContent(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(NeedRepairContent, self).__init__(properties=properties, commands=commands)

    def getRepairPercentage(self):
        return self._getNumber(0)

    def setRepairPercentage(self, value):
        self._setNumber(0, value)

    def getFreeAutoRepair(self):
        return self._getBool(1)

    def setFreeAutoRepair(self, value):
        self._setBool(1, value)

    def _initialize(self):
        super(NeedRepairContent, self)._initialize()
        self._addNumberProperty('repairPercentage', 0)
        self._addBoolProperty('freeAutoRepair', False)