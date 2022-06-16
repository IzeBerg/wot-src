from frameworks.wulf import ViewModel
from gui.impl.gen.view_models.views.lobby.resource_well.vehicle_counter_model import VehicleCounterModel

class NoVehiclesConfirmModel(ViewModel):
    __slots__ = ('showHangar', )

    def __init__(self, properties=1, commands=1):
        super(NoVehiclesConfirmModel, self).__init__(properties=properties, commands=commands)

    @property
    def vehicleCounter(self):
        return self._getViewModel(0)

    def _initialize(self):
        super(NoVehiclesConfirmModel, self)._initialize()
        self._addViewModelProperty('vehicleCounter', VehicleCounterModel())
        self.showHangar = self._addCommand('showHangar')