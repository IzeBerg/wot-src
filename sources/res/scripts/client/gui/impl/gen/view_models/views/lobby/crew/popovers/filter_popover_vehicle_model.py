from gui.impl.gen.view_models.views.lobby.common.vehicle_model import VehicleModel

class FilterPopoverVehicleModel(VehicleModel):
    __slots__ = ()

    def __init__(self, properties=10, commands=0):
        super(FilterPopoverVehicleModel, self).__init__(properties=properties, commands=commands)

    def getIsSelected(self):
        return self._getBool(9)

    def setIsSelected(self, value):
        self._setBool(9, value)

    def _initialize(self):
        super(FilterPopoverVehicleModel, self)._initialize()
        self._addBoolProperty('isSelected', False)