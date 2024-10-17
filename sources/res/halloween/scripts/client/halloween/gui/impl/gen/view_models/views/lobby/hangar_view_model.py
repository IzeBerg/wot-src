from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from halloween.gui.impl.gen.view_models.views.lobby.artefact_types_view_model import ArtefactTypesViewModel
from halloween.gui.impl.gen.view_models.views.lobby.progress_view_model import ProgressViewModel
from halloween.gui.impl.gen.view_models.views.lobby.vehicle_title_view_model import VehicleTitleViewModel

class HangarViewModel(ViewModel):
    __slots__ = ('onEscPressed', 'onAboutClick', 'onShopClick', 'onMetaClick', 'onExitClick',
                 'onViewLoaded', 'onSlide', 'onPreview', 'onTasksClick', 'onPacksClick',
                 'onComparisonClick', 'onLeaderboardClick')

    def __init__(self, properties=12, commands=12):
        super(HangarViewModel, self).__init__(properties=properties, commands=commands)

    @property
    def mainGiftVehicle(self):
        return self._getViewModel(0)

    @staticmethod
    def getMainGiftVehicleType():
        return VehicleTitleViewModel

    @property
    def vehicleTitle(self):
        return self._getViewModel(1)

    @staticmethod
    def getVehicleTitleType():
        return VehicleTitleViewModel

    @property
    def progress(self):
        return self._getViewModel(2)

    @staticmethod
    def getProgressType():
        return ProgressViewModel

    def getIsLoadedSetup(self):
        return self._getBool(3)

    def setIsLoadedSetup(self, value):
        self._setBool(3, value)

    def getSelectedSlide(self):
        return self._getNumber(4)

    def setSelectedSlide(self, value):
        self._setNumber(4, value)

    def getSlidesCount(self):
        return self._getNumber(5)

    def setSlidesCount(self, value):
        self._setNumber(5, value)

    def getIsVehicleLocked(self):
        return self._getBool(6)

    def setIsVehicleLocked(self, value):
        self._setBool(6, value)

    def getLockedMissionIndex(self):
        return self._getNumber(7)

    def setLockedMissionIndex(self, value):
        self._setNumber(7, value)

    def getIsVehicleInBattle(self):
        return self._getBool(8)

    def setIsVehicleInBattle(self, value):
        self._setBool(8, value)

    def getIsDefenseMode(self):
        return self._getBool(9)

    def setIsDefenseMode(self, value):
        self._setBool(9, value)

    def getShowRandomLable(self):
        return self._getBool(10)

    def setShowRandomLable(self, value):
        self._setBool(10, value)

    def getArtefacts(self):
        return self._getArray(11)

    def setArtefacts(self, value):
        self._setArray(11, value)

    @staticmethod
    def getArtefactsType():
        return ArtefactTypesViewModel

    def _initialize(self):
        super(HangarViewModel, self)._initialize()
        self._addViewModelProperty('mainGiftVehicle', VehicleTitleViewModel())
        self._addViewModelProperty('vehicleTitle', VehicleTitleViewModel())
        self._addViewModelProperty('progress', ProgressViewModel())
        self._addBoolProperty('isLoadedSetup', False)
        self._addNumberProperty('selectedSlide', 0)
        self._addNumberProperty('slidesCount', 0)
        self._addBoolProperty('isVehicleLocked', False)
        self._addNumberProperty('lockedMissionIndex', 0)
        self._addBoolProperty('isVehicleInBattle', False)
        self._addBoolProperty('isDefenseMode', False)
        self._addBoolProperty('showRandomLable', False)
        self._addArrayProperty('artefacts', Array())
        self.onEscPressed = self._addCommand('onEscPressed')
        self.onAboutClick = self._addCommand('onAboutClick')
        self.onShopClick = self._addCommand('onShopClick')
        self.onMetaClick = self._addCommand('onMetaClick')
        self.onExitClick = self._addCommand('onExitClick')
        self.onViewLoaded = self._addCommand('onViewLoaded')
        self.onSlide = self._addCommand('onSlide')
        self.onPreview = self._addCommand('onPreview')
        self.onTasksClick = self._addCommand('onTasksClick')
        self.onPacksClick = self._addCommand('onPacksClick')
        self.onComparisonClick = self._addCommand('onComparisonClick')
        self.onLeaderboardClick = self._addCommand('onLeaderboardClick')