from frameworks.wulf import ViewModel

class SimpleEfficiencyModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(SimpleEfficiencyModel, self).__init__(properties=properties, commands=commands)

    def getParamName(self):
        return self._getString(0)

    def setParamName(self, value):
        self._setString(0, value)

    def getRank(self):
        return self._getNumber(1)

    def setRank(self, value):
        self._setNumber(1, value)

    def _initialize(self):
        super(SimpleEfficiencyModel, self)._initialize()
        self._addStringProperty('paramName', '')
        self._addNumberProperty('rank', 0)