from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from halloween.gui.impl.gen.view_models.views.lobby.widgets.hangar_carousel_vehicle_view_model import HangarCarouselVehicleViewModel

class HangarCarouselViewModel(ViewModel):
    __slots__ = ('onChangeVehicle', )

    def __init__(self, properties=2, commands=1):
        super(HangarCarouselViewModel, self).__init__(properties=properties, commands=commands)

    def getSelectedVehicle(self):
        return self._getNumber(0)

    def setSelectedVehicle(self, value):
        self._setNumber(0, value)

    def getVehicles(self):
        return self._getArray(1)

    def setVehicles(self, value):
        self._setArray(1, value)

    @staticmethod
    def getVehiclesType():
        return HangarCarouselVehicleViewModel

    def _initialize(self):
        super(HangarCarouselViewModel, self)._initialize()
        self._addNumberProperty('selectedVehicle', 0)
        self._addArrayProperty('vehicles', Array())
        self.onChangeVehicle = self._addCommand('onChangeVehicle')