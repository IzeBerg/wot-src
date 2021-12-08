from frameworks.wulf import ViewModel
from gui.impl.gen.view_models.views.lobby.new_year.views.rewards_info.ny_collections_rewards_model import NyCollectionsRewardsModel
from gui.impl.gen.view_models.views.lobby.new_year.views.rewards_info.ny_levels_rewards_model import NyLevelsRewardsModel

class NyRewardsInfoViewModel(ViewModel):
    __slots__ = ('onFadeInDone', )

    def __init__(self, properties=4, commands=1):
        super(NyRewardsInfoViewModel, self).__init__(properties=properties, commands=commands)

    @property
    def levelsRewards(self):
        return self._getViewModel(0)

    @property
    def collectionsRewards(self):
        return self._getViewModel(1)

    def getIsLevelsRewardsOpened(self):
        return self._getBool(2)

    def setIsLevelsRewardsOpened(self, value):
        self._setBool(2, value)

    def getIsFaded(self):
        return self._getBool(3)

    def setIsFaded(self, value):
        self._setBool(3, value)

    def _initialize(self):
        super(NyRewardsInfoViewModel, self)._initialize()
        self._addViewModelProperty('levelsRewards', NyLevelsRewardsModel())
        self._addViewModelProperty('collectionsRewards', NyCollectionsRewardsModel())
        self._addBoolProperty('isLevelsRewardsOpened', False)
        self._addBoolProperty('isFaded', False)
        self.onFadeInDone = self._addCommand('onFadeInDone')