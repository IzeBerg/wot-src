from enum import Enum, IntEnum
from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from gui.impl.gen.view_models.common.missions.bonuses.item_bonus_model import ItemBonusModel
from gui.impl.gen.view_models.views.lobby.battle_matters.battle_matters_vehicle_model import BattleMattersVehicleModel

class State(IntEnum):
    REGULAR = 0
    INTERMEDIATE = 1
    TOKEN = 2
    TOKENVEHICLE = 3
    FINAL = 4


class RewardType(Enum):
    REGULAR = 'regular'
    INTERMEDIATE = 'intermediate'
    VEHICLE = 'vehicle'


class BattleMattersRewardsViewModel(ViewModel):
    __slots__ = ('onClose', 'onNextTask', 'onShowVehicle', 'onChooseVehicle')
    ARG_REWARD_TYPE = 'type'
    ARG_REWARD_INDEX = 'tooltipId'

    def __init__(self, properties=5, commands=4):
        super(BattleMattersRewardsViewModel, self).__init__(properties=properties, commands=commands)

    def getState(self):
        return State(self._getNumber(0))

    def setState(self, value):
        self._setNumber(0, value.value)

    def getQuestNumber(self):
        return self._getNumber(1)

    def setQuestNumber(self, value):
        self._setNumber(1, value)

    def getVehicles(self):
        return self._getArray(2)

    def setVehicles(self, value):
        self._setArray(2, value)

    @staticmethod
    def getVehiclesType():
        return BattleMattersVehicleModel

    def getRegularRewards(self):
        return self._getArray(3)

    def setRegularRewards(self, value):
        self._setArray(3, value)

    @staticmethod
    def getRegularRewardsType():
        return ItemBonusModel

    def getIntermediateRewards(self):
        return self._getArray(4)

    def setIntermediateRewards(self, value):
        self._setArray(4, value)

    @staticmethod
    def getIntermediateRewardsType():
        return ItemBonusModel

    def _initialize(self):
        super(BattleMattersRewardsViewModel, self)._initialize()
        self._addNumberProperty('state')
        self._addNumberProperty('questNumber', 0)
        self._addArrayProperty('vehicles', Array())
        self._addArrayProperty('regularRewards', Array())
        self._addArrayProperty('intermediateRewards', Array())
        self.onClose = self._addCommand('onClose')
        self.onNextTask = self._addCommand('onNextTask')
        self.onShowVehicle = self._addCommand('onShowVehicle')
        self.onChooseVehicle = self._addCommand('onChooseVehicle')