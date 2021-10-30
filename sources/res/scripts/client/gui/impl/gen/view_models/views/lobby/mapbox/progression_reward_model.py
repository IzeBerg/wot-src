from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from gui.impl.gen.view_models.views.lobby.mapbox.reward_item_model import RewardItemModel

class ProgressionRewardModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(ProgressionRewardModel, self).__init__(properties=properties, commands=commands)

    def getNumBattles(self):
        return self._getNumber(0)

    def setNumBattles(self, value):
        self._setNumber(0, value)

    def getRewards(self):
        return self._getArray(1)

    def setRewards(self, value):
        self._setArray(1, value)

    def _initialize(self):
        super(ProgressionRewardModel, self)._initialize()
        self._addNumberProperty('numBattles', 0)
        self._addArrayProperty('rewards', Array())