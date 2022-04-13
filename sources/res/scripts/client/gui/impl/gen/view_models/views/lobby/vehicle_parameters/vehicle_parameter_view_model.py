from frameworks.wulf import Array
from frameworks.wulf import ViewModel

class VehicleParameterViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(VehicleParameterViewModel, self).__init__(properties=properties, commands=commands)

    def getName(self):
        return self._getString(0)

    def setName(self, value):
        self._setString(0, value)

    def getParameterValues(self):
        return self._getArray(1)

    def setParameterValues(self, value):
        self._setArray(1, value)

    def _initialize(self):
        super(VehicleParameterViewModel, self)._initialize()
        self._addStringProperty('name', '')
        self._addArrayProperty('parameterValues', Array())