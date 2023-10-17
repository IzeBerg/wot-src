from halloween.gui.impl.gen.view_models.views.lobby.vehicle_title_view_model import VehicleTitleViewModel
from gui.impl.gen.view_models.views.selectable_view_model import SelectableViewModel

class HangarViewModel(SelectableViewModel):
    __slots__ = ('onEscPressed', 'onAboutClick', 'onShopClick', 'onMetaClick', 'onExitClick',
                 'onDragging', 'onComparisonClick')

    def __init__(self, properties=5, commands=9):
        super(HangarViewModel, self).__init__(properties=properties, commands=commands)

    @property
    def vehicleTitle(self):
        return self._getViewModel(0)

    @staticmethod
    def getVehicleTitleType():
        return VehicleTitleViewModel

    def getIsLoadedSetup(self):
        return self._getBool(1)

    def setIsLoadedSetup(self, value):
        self._setBool(1, value)

    def getCurrentProgress(self):
        return self._getNumber(2)

    def setCurrentProgress(self, value):
        self._setNumber(2, value)

    def getMaxProgress(self):
        return self._getNumber(3)

    def setMaxProgress(self, value):
        self._setNumber(3, value)

    def getIsCompleted(self):
        return self._getBool(4)

    def setIsCompleted(self, value):
        self._setBool(4, value)

    def _initialize(self):
        super(HangarViewModel, self)._initialize()
        self._addViewModelProperty('vehicleTitle', VehicleTitleViewModel())
        self._addBoolProperty('isLoadedSetup', False)
        self._addNumberProperty('currentProgress', 0)
        self._addNumberProperty('maxProgress', 0)
        self._addBoolProperty('isCompleted', False)
        self.onEscPressed = self._addCommand('onEscPressed')
        self.onAboutClick = self._addCommand('onAboutClick')
        self.onShopClick = self._addCommand('onShopClick')
        self.onMetaClick = self._addCommand('onMetaClick')
        self.onExitClick = self._addCommand('onExitClick')
        self.onDragging = self._addCommand('onDragging')
        self.onComparisonClick = self._addCommand('onComparisonClick')