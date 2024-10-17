from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from halloween.gui.impl.gen.view_models.views.common.buff_model import BuffModel

class FullStatsViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=4, commands=0):
        super(FullStatsViewModel, self).__init__(properties=properties, commands=commands)

    def getMissionTitle(self):
        return self._getString(0)

    def setMissionTitle(self, value):
        self._setString(0, value)

    def getMissionTask(self):
        return self._getString(1)

    def setMissionTask(self, value):
        self._setString(1, value)

    def getDifficultyLevel(self):
        return self._getNumber(2)

    def setDifficultyLevel(self, value):
        self._setNumber(2, value)

    def getPlayerBuffs(self):
        return self._getArray(3)

    def setPlayerBuffs(self, value):
        self._setArray(3, value)

    @staticmethod
    def getPlayerBuffsType():
        return BuffModel

    def _initialize(self):
        super(FullStatsViewModel, self)._initialize()
        self._addStringProperty('missionTitle', '')
        self._addStringProperty('missionTask', '')
        self._addNumberProperty('difficultyLevel', 0)
        self._addArrayProperty('playerBuffs', Array())