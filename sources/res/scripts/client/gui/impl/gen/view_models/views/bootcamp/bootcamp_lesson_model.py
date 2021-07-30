from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from gui.impl.gen.view_models.views.bootcamp.bootcamp_reward_item_model import BootcampRewardItemModel

class BootcampLessonModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=6, commands=0):
        super(BootcampLessonModel, self).__init__(properties=properties, commands=commands)

    def getLessonNumber(self):
        return self._getNumber(0)

    def setLessonNumber(self, value):
        self._setNumber(0, value)

    def getCompleted(self):
        return self._getBool(1)

    def setCompleted(self, value):
        self._setBool(1, value)

    def getCurrent(self):
        return self._getBool(2)

    def setCurrent(self, value):
        self._setBool(2, value)

    def getTooltipId(self):
        return self._getNumber(3)

    def setTooltipId(self, value):
        self._setNumber(3, value)

    def getRewardsTaken(self):
        return self._getBool(4)

    def setRewardsTaken(self, value):
        self._setBool(4, value)

    def getRewards(self):
        return self._getArray(5)

    def setRewards(self, value):
        self._setArray(5, value)

    def _initialize(self):
        super(BootcampLessonModel, self)._initialize()
        self._addNumberProperty('lessonNumber', 0)
        self._addBoolProperty('completed', False)
        self._addBoolProperty('current', False)
        self._addNumberProperty('tooltipId', 0)
        self._addBoolProperty('rewardsTaken', False)
        self._addArrayProperty('rewards', Array())