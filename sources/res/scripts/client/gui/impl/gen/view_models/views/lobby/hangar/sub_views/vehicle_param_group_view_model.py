from enum import IntEnum
from frameworks.wulf import Array
from gui.impl.gen.view_models.views.lobby.hangar.sub_views.vehicle_param_base_view_model import VehicleParamBaseViewModel
from gui.impl.gen.view_models.views.lobby.hangar.sub_views.vehicle_param_indicator_view_model import VehicleParamIndicatorViewModel
from gui.impl.gen.view_models.views.lobby.hangar.sub_views.vehicle_param_view_model import VehicleParamViewModel

class BuffIconType(IntEnum):
    NONE = 0
    INCREASE = 1
    DECREASE = 2
    MIXED = 3


class VehicleParamGroupViewModel(VehicleParamBaseViewModel):
    __slots__ = ()

    def __init__(self, properties=12, commands=0):
        super(VehicleParamGroupViewModel, self).__init__(properties=properties, commands=commands)

    @property
    def indicator(self):
        return self._getViewModel(5)

    @staticmethod
    def getIndicatorType():
        return VehicleParamIndicatorViewModel

    def getIsOpen(self):
        return self._getBool(6)

    def setIsOpen(self, value):
        self._setBool(6, value)

    def getIsSituational(self):
        return self._getBool(7)

    def setIsSituational(self, value):
        self._setBool(7, value)

    def getBuffIconType(self):
        return BuffIconType(self._getNumber(8))

    def setBuffIconType(self, value):
        self._setNumber(8, value.value)

    def getAdditionalValue(self):
        return self._getString(9)

    def setAdditionalValue(self, value):
        self._setString(9, value)

    def getParams(self):
        return self._getArray(10)

    def setParams(self, value):
        self._setArray(10, value)

    @staticmethod
    def getParamsType():
        return VehicleParamViewModel

    def getExtraParams(self):
        return self._getArray(11)

    def setExtraParams(self, value):
        self._setArray(11, value)

    @staticmethod
    def getExtraParamsType():
        return VehicleParamViewModel

    def _initialize(self):
        super(VehicleParamGroupViewModel, self)._initialize()
        self._addViewModelProperty('indicator', VehicleParamIndicatorViewModel())
        self._addBoolProperty('isOpen', False)
        self._addBoolProperty('isSituational', False)
        self._addNumberProperty('buffIconType')
        self._addStringProperty('additionalValue', '')
        self._addArrayProperty('params', Array())
        self._addArrayProperty('extraParams', Array())