from frameworks.wulf import Array
from gui.impl.gen.view_models.views.lobby.tank_setup.sub_views.base_setup_model import BaseSetupModel
from gui.impl.gen.view_models.views.lobby.tank_setup.sub_views.opt_device_filter_model import OptDeviceFilterModel
from gui.impl.gen.view_models.views.lobby.tank_setup.sub_views.opt_device_slot_model import OptDeviceSlotModel

class OptDevicesSetupModel(BaseSetupModel):
    __slots__ = ('onIntroPassed', )

    def __init__(self, properties=9, commands=8):
        super(OptDevicesSetupModel, self).__init__(properties=properties, commands=commands)

    @property
    def filter(self):
        return self._getViewModel(5)

    @staticmethod
    def getFilterType():
        return OptDeviceFilterModel

    def getSlots(self):
        return self._getArray(6)

    def setSlots(self, value):
        self._setArray(6, value)

    @staticmethod
    def getSlotsType():
        return OptDeviceSlotModel

    def getWithIntroduction(self):
        return self._getBool(7)

    def setWithIntroduction(self, value):
        self._setBool(7, value)

    def getIntroductionType(self):
        return self._getString(8)

    def setIntroductionType(self, value):
        self._setString(8, value)

    def _initialize(self):
        super(OptDevicesSetupModel, self)._initialize()
        self._addViewModelProperty('filter', OptDeviceFilterModel())
        self._addArrayProperty('slots', Array())
        self._addBoolProperty('withIntroduction', False)
        self._addStringProperty('introductionType', '')
        self.onIntroPassed = self._addCommand('onIntroPassed')