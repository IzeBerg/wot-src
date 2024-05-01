from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from gui.impl.gen.view_models.common.missions.bonuses.icon_bonus_model import IconBonusModel

class ProgressionModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=3, commands=0):
        super(ProgressionModel, self).__init__(properties=properties, commands=commands)

    def getBonuses(self):
        return self._getArray(0)

    def setBonuses(self, value):
        self._setArray(0, value)

    @staticmethod
    def getBonusesType():
        return IconBonusModel

    def getEventPoints(self):
        return self._getNumber(1)

    def setEventPoints(self, value):
        self._setNumber(1, value)

    def getIsRewardGranted(self):
        return self._getBool(2)

    def setIsRewardGranted(self, value):
        self._setBool(2, value)

    def _initialize(self):
        super(ProgressionModel, self)._initialize()
        self._addArrayProperty('bonuses', Array())
        self._addNumberProperty('eventPoints', 0)
        self._addBoolProperty('isRewardGranted', False)