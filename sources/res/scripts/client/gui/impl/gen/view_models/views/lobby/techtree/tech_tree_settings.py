from frameworks.wulf import ViewModel

class TechTreeSettings(ViewModel):
    __slots__ = ()

    def __init__(self, properties=3, commands=0):
        super(TechTreeSettings, self).__init__(properties=properties, commands=commands)

    def getRowsNumber(self):
        return self._getNumber(0)

    def setRowsNumber(self, value):
        self._setNumber(0, value)

    def getColumnsNumber(self):
        return self._getNumber(1)

    def setColumnsNumber(self, value):
        self._setNumber(1, value)

    def getPremiumRowsNumber(self):
        return self._getNumber(2)

    def setPremiumRowsNumber(self, value):
        self._setNumber(2, value)

    def _initialize(self):
        super(TechTreeSettings, self)._initialize()
        self._addNumberProperty('rowsNumber', 0)
        self._addNumberProperty('columnsNumber', 0)
        self._addNumberProperty('premiumRowsNumber', 0)