from enum import Enum
from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from halloween.gui.impl.gen.view_models.views.lobby.battle_info_model import BattleInfoModel
from halloween.gui.impl.gen.view_models.views.lobby.bonus_item_view_model import BonusItemViewModel
from halloween.gui.impl.gen.view_models.views.lobby.player_info_model import PlayerInfoModel

class ArtifactStates(Enum):
    NOTRECEIVED = 'inProgress'
    RECEIVED = 'recive'
    OPEN = 'open'


class BattleResultViewModel(ViewModel):
    __slots__ = ('onClose', 'onGoToTasks')

    def __init__(self, properties=10, commands=2):
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

    def getTitle(self):
        return self._getString(2)

    def setTitle(self, value):
        self._setString(2, value)

    def getSubTitle(self):
        return self._getString(3)

    def setSubTitle(self, value):
        self._setString(3, value)

    def getIsBossDefeated(self):
        return self._getBool(4)

    def setIsBossDefeated(self, value):
        self._setBool(4, value)

    def getArtifact(self):
        return self._getNumber(5)

    def setArtifact(self, value):
        self._setNumber(5, value)

    def getArtifactState(self):
        return ArtifactStates(self._getString(6))

    def setArtifactState(self, value):
        self._setString(6, value.value)

    def getIsCanOpenArtifact(self):
        return self._getBool(7)

    def setIsCanOpenArtifact(self, value):
        self._setBool(7, value)

    def getIsMetaButtonVisible(self):
        return self._getBool(8)

    def setIsMetaButtonVisible(self, value):
        self._setBool(8, value)

    def getRewards(self):
        return self._getArray(9)

    def setRewards(self, value):
        self._setArray(9, value)

    @staticmethod
    def getRewardsType():
        return BonusItemViewModel

    def _initialize(self):
        super(BattleResultViewModel, self)._initialize()
        self._addViewModelProperty('battleInfo', BattleInfoModel())
        self._addViewModelProperty('playerInfo', PlayerInfoModel())
        self._addStringProperty('title', '')
        self._addStringProperty('subTitle', '')
        self._addBoolProperty('isBossDefeated', False)
        self._addNumberProperty('artifact', 0)
        self._addStringProperty('artifactState')
        self._addBoolProperty('isCanOpenArtifact', False)
        self._addBoolProperty('isMetaButtonVisible', False)
        self._addArrayProperty('rewards', Array())
        self.onClose = self._addCommand('onClose')
        self.onGoToTasks = self._addCommand('onGoToTasks')