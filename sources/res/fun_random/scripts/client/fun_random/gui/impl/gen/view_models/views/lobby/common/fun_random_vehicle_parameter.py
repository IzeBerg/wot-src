from frameworks.wulf import ViewModel

class FunRandomVehicleParameter(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(FunRandomVehicleParameter, self).__init__(properties=properties, commands=commands)

    def getParameterName(self):
        return self._getString(0)

    def setParameterName(self, value):
        self._setString(0, value)

    def getIcon(self):
        return self._getString(1)

    def setIcon(self, value):
        self._setString(1, value)

    def _initialize(self):
        super(FunRandomVehicleParameter, self)._initialize()
        self._addStringProperty('parameterName', '')
        self._addStringProperty('icon', '')