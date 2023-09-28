from frameworks.wulf import ViewModel
from frontline.gui.impl.gen.view_models.views.lobby.views.vehicles_slide_model import VehiclesSlideModel

class WelcomeViewModel(ViewModel):
    __slots__ = ('onClose', )

    def __init__(self, properties=1, commands=1):
        super(WelcomeViewModel, self).__init__(properties=properties, commands=commands)

    @property
    def vehiclesSlide(self):
        return self._getViewModel(0)

    @staticmethod
    def getVehiclesSlideType():
        return VehiclesSlideModel

    def _initialize(self):
        super(WelcomeViewModel, self)._initialize()
        self._addViewModelProperty('vehiclesSlide', VehiclesSlideModel())
        self.onClose = self._addCommand('onClose')