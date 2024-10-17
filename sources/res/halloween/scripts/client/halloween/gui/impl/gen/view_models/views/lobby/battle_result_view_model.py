from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from halloween.gui.impl.gen.view_models.views.common.bonus_item_view_model import BonusItemViewModel
from halloween.gui.impl.gen.view_models.views.lobby.battle_info_model import BattleInfoModel
from halloween.gui.impl.gen.view_models.views.lobby.player_info_model import PlayerInfoModel

class BattleResultViewModel(ViewModel):
    __slots__ = ('onClose', )

    def __init__(self, properties=8, commands=1):
        super(BattleResultViewModel, self).__init__(properties=properties, commands=commands)

    @property
    def battleInfo(self):
        return self._getViewModel(0)

    @staticmethod
    def getBattleInfoType():
        return BattleInfoModel

    @property
    def playerInfo(self):
        return self._getViewModel(1)

    @staticmethod
    def getPlayerInfoType():
        return PlayerInfoModel

    def getCurrentPhase(self):
        return self._getNumber(2)

    def setCurrentPhase(self, value):
        self._setNumber(2, value)

    def getIsBossDefeated(self):
        return self._getBool(3)

    def setIsBossDefeated(self, value):
        self._setBool(3, value)

    def getDifficultyLevel(self):
        return self._getNumber(4)

    def setDifficultyLevel(self, value):
        self._setNumber(4, value)

    def getTime(self):
        return self._getNumber(5)

    def setTime(self, value):
        self._setNumber(5, value)

    def getBestTime(self):
        return self._getNumber(6)

    def setBestTime(self, value):
        self._setNumber(6, value)

    def getRewards(self):
        return self._getArray(7)

    def setRewards(self, value):
        self._setArray(7, value)

    @staticmethod
    def getRewardsType():
        return BonusItemViewModel

    def _initialize(self):
        super(BattleResultViewModel, self)._initialize()
        self._addViewModelProperty('battleInfo', BattleInfoModel())
        self._addViewModelProperty('playerInfo', PlayerInfoModel())
        self._addNumberProperty('currentPhase', 0)
        self._addBoolProperty('isBossDefeated', False)
        self._addNumberProperty('difficultyLevel', 0)
        self._addNumberProperty('time', 0)
        self._addNumberProperty('bestTime', 0)
        self._addArrayProperty('rewards', Array())
        self.onClose = self._addCommand('onClose')