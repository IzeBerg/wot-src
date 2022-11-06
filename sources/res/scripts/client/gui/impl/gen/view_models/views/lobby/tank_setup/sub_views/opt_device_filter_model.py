from gui.impl.gen.view_models.views.lobby.tank_setup.common.filters_model import FiltersModel

class OptDeviceFilterModel(FiltersModel):
    __slots__ = ()

    def __init__(self, properties=5, commands=2):
        super(OptDeviceFilterModel, self).__init__(properties=properties, commands=commands)

    def getSelectedCount(self):
        return self._getNumber(4)

    def setSelectedCount(self, value):
        self._setNumber(4, value)

    def _initialize(self):
        super(OptDeviceFilterModel, self)._initialize()
        self._addNumberProperty('selectedCount', 0)