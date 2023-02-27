from gui.impl.gen import R
from frameworks.wulf import ViewModel

class VehicleModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(VehicleModel, self).__init__(properties=properties, commands=commands)

    def getIcon(self):
        return self._getResource(0)

    def setIcon(self, value):
        self._setResource(0, value)

    def getName(self):
        return self._getString(1)

    def setName(self, value):
        self._setString(1, value)

    def _initialize(self):
        super(VehicleModel, self)._initialize()
        self._addResourceProperty('icon', R.invalid())
        self._addStringProperty('name', '')