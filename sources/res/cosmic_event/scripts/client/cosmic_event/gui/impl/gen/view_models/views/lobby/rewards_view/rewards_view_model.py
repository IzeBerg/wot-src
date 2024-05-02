from frameworks.wulf import Array
from gui.impl.gen import R
from frameworks.wulf import ViewModel
from gui.impl.gen.view_models.common.missions.bonuses.bonus_model import BonusModel
from cosmic_event.gui.impl.gen.view_models.views.lobby.cosmic_lobby_view.announcer_model import AnnouncerModel

class RewardsViewModel(ViewModel):
    __slots__ = ('onCloseButtonClick', 'onContinueButtonClick')

    def __init__(self, properties=7, commands=2):
        super(RewardsViewModel, self).__init__(properties=properties, commands=commands)

    @property
    def announcer(self):
        return self._getViewModel(0)

    @staticmethod
    def getAnnouncerType():
        return AnnouncerModel

    def getSubtitle(self):
        return self._getResource(1)

    def setSubtitle(self, value):
        self._setResource(1, value)

    def getTitle(self):
        return self._getResource(2)

    def setTitle(self, value):
        self._setResource(2, value)

    def getInfoText(self):
        return self._getResource(3)

    def setInfoText(self, value):
        self._setResource(3, value)

    def getProgressionStage(self):
        return self._getNumber(4)

    def setProgressionStage(self, value):
        self._setNumber(4, value)

    def getHeroAsset(self):
        return self._getResource(5)

    def setHeroAsset(self, value):
        self._setResource(5, value)

    def getRewards(self):
        return self._getArray(6)

    def setRewards(self, value):
        self._setArray(6, value)

    @staticmethod
    def getRewardsType():
        return BonusModel

    def _initialize(self):
        super(RewardsViewModel, self)._initialize()
        self._addViewModelProperty('announcer', AnnouncerModel())
        self._addResourceProperty('subtitle', R.invalid())
        self._addResourceProperty('title', R.invalid())
        self._addResourceProperty('infoText', R.invalid())
        self._addNumberProperty('progressionStage', 0)
        self._addResourceProperty('heroAsset', R.invalid())
        self._addArrayProperty('rewards', Array())
        self.onCloseButtonClick = self._addCommand('onCloseButtonClick')
        self.onContinueButtonClick = self._addCommand('onContinueButtonClick')