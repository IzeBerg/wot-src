from gui.impl.gen.view_models.views.lobby.tank_setup.common.base_ammunition_slot import BaseAmmunitionSlot
from gui.impl.gen.view_models.views.lobby.tank_setup.common.specializations_model import SpecializationsModel

class OptDeviceAmmunitionSlot(BaseAmmunitionSlot):
    __slots__ = ()

    def __init__(self, properties=11, commands=0):
        super(OptDeviceAmmunitionSlot, self).__init__(properties=properties, commands=commands)

    @property
    def specializations(self):
        return self._getViewModel(8)

    def getActiveSpecsMask(self):
        return self._getNumber(9)

    def setActiveSpecsMask(self, value):
        self._setNumber(9, value)

    def getIsIncompatible(self):
        return self._getBool(10)

    def setIsIncompatible(self, value):
        self._setBool(10, value)

    def _initialize(self):
        super(OptDeviceAmmunitionSlot, self)._initialize()
        self._addViewModelProperty('specializations', SpecializationsModel())
        self._addNumberProperty('activeSpecsMask', 0)
        self._addBoolProperty('isIncompatible', False)