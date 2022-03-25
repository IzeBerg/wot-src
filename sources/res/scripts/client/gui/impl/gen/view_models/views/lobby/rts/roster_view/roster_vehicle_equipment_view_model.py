from gui.impl.gen import R
from frameworks.wulf import ViewModel

class RosterVehicleEquipmentViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(RosterVehicleEquipmentViewModel, self).__init__(properties=properties, commands=commands)

    def getIntCd(self):
        return self._getNumber(0)

    def setIntCd(self, value):
        self._setNumber(0, value)

    def getImage(self):
        return self._getResource(1)

    def setImage(self, value):
        self._setResource(1, value)

    def _initialize(self):
        super(RosterVehicleEquipmentViewModel, self)._initialize()
        self._addNumberProperty('intCd', 0)
        self._addResourceProperty('image', R.invalid())