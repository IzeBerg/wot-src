from enum import Enum
from frameworks.wulf import ViewModel
from gui.impl.gen.view_models.common.vehicle_info_model import VehicleInfoModel

class ChapterStates(Enum):
    ACTIVE = 'active'
    PAUSED = 'paused'
    COMPLETED = 'completed'
    NOTSTARTED = 'notStarted'


class ChapterModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=9, commands=0):
        super(ChapterModel, self).__init__(properties=properties, commands=commands)

    @property
    def vehicleInfo(self):
        return self._getViewModel(0)

    def getChapterID(self):
        return self._getNumber(1)

    def setChapterID(self, value):
        self._setNumber(1, value)

    def getStyleName(self):
        return self._getString(2)

    def setStyleName(self, value):
        self._setString(2, value)

    def getCurrentLevel(self):
        return self._getNumber(3)

    def setCurrentLevel(self, value):
        self._setNumber(3, value)

    def getChapterState(self):
        return ChapterStates(self._getString(4))

    def setChapterState(self, value):
        self._setString(4, value.value)

    def getIsRegular(self):
        return self._getBool(5)

    def setIsRegular(self, value):
        self._setBool(5, value)

    def getIsVehicleInHangar(self):
        return self._getBool(6)

    def setIsVehicleInHangar(self, value):
        self._setBool(6, value)

    def getIsBought(self):
        return self._getBool(7)

    def setIsBought(self, value):
        self._setBool(7, value)

    def getLevelProgression(self):
        return self._getNumber(8)

    def setLevelProgression(self, value):
        self._setNumber(8, value)

    def _initialize(self):
        super(ChapterModel, self)._initialize()
        self._addViewModelProperty('vehicleInfo', VehicleInfoModel())
        self._addNumberProperty('chapterID', 0)
        self._addStringProperty('styleName', '')
        self._addNumberProperty('currentLevel', 0)
        self._addStringProperty('chapterState')
        self._addBoolProperty('isRegular', False)
        self._addBoolProperty('isVehicleInHangar', False)
        self._addBoolProperty('isBought', False)
        self._addNumberProperty('levelProgression', 0)