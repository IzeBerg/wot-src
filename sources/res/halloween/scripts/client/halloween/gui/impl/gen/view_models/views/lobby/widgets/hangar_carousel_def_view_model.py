from enum import Enum
from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from halloween.gui.impl.gen.view_models.views.lobby.widgets.hangar_carousel_filter_view_model import HangarCarouselFilterViewModel

class VehicleStates(Enum):
    DEFAULT = 'default'
    LOCKED = 'locked'
    INBATTLE = 'inBattle'
    INPLATOON = 'inPlatoon'
    CREWINCOMPLETE = 'crewIncomplete'
    RENTED = 'rented'
    SUSPENDED = 'suspended'
    REPAIR = 'repair'
    UNTRAINEDCREW = 'untrainedCrew'
    LOWEFFICIENCY = 'lowEfficiency'
    UNSUITABLE = 'unsuitable'


class HangarCarouselDefViewModel(ViewModel):
    __slots__ = ('onChangeVehicle', )
    HALLOWEEN_CAROUSEL_VEHICLE_TOOLTIP_DEF = 'halloweenCarouselVehicleDef'

    def __init__(self, properties=4, commands=1):
        super(HangarCarouselDefViewModel, self).__init__(properties=properties, commands=commands)

    @property
    def filter(self):
        return self._getViewModel(0)

    @staticmethod
    def getFilterType():
        return HangarCarouselFilterViewModel

    def getSelectedVehicle(self):
        return self._getNumber(1)

    def setSelectedVehicle(self, value):
        self._setNumber(1, value)

    def getVehicles(self):
        return self._getString(2)

    def setVehicles(self, value):
        self._setString(2, value)

    def getOrderedNations(self):
        return self._getArray(3)

    def setOrderedNations(self, value):
        self._setArray(3, value)

    @staticmethod
    def getOrderedNationsType():
        return unicode

    def _initialize(self):
        super(HangarCarouselDefViewModel, self)._initialize()
        self._addViewModelProperty('filter', HangarCarouselFilterViewModel())
        self._addNumberProperty('selectedVehicle', 0)
        self._addStringProperty('vehicles', '')
        self._addArrayProperty('orderedNations', Array())
        self.onChangeVehicle = self._addCommand('onChangeVehicle')