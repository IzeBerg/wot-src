from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from gui.impl.gen.view_models.common.missions.bonuses.icon_bonus_model import IconBonusModel

class ProgressionModelV2(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(ProgressionModelV2, self).__init__(properties=properties, commands=commands)

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

    def _initialize(self):
        super(ProgressionModelV2, self)._initialize()
        self._addArrayProperty('bonuses', Array())
        self._addNumberProperty('eventPoints', 0)