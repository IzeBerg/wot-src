from gui.impl.gen import R
from gui.impl.gen.view_models.views.lobby.wt_event.property_model import PropertyModel

class WtEventVehicleParamsTooltipViewModel(PropertyModel):
    __slots__ = ()

    def __init__(self, properties=3, commands=0):
        super(WtEventVehicleParamsTooltipViewModel, self).__init__(properties=properties, commands=commands)

    def getDescription(self):
        return self._getResource(2)

    def setDescription(self, value):
        self._setResource(2, value)

    def _initialize(self):
        super(WtEventVehicleParamsTooltipViewModel, self)._initialize()
        self._addResourceProperty('description', R.invalid())