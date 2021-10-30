from gui.impl.gen import R
from frameworks.wulf import ViewSettings
from gui.impl.gen.view_models.views.lobby.platoon.common_player_data_model import CommonPlayerDataModel
from gui.impl.pub import ViewImpl

class WTRTooltip(ViewImpl):

    def __init__(self, name, clanTag, badgeID, rating, maxDifficultyLevelMessage, isEvent, maxDifficultyLevel):
        self.__name = name
        self.__clanTag = clanTag
        self.__badgeID = badgeID
        self.__rating = rating
        self.__maxDifficultyLevelMessage = maxDifficultyLevelMessage
        self.__isEvent = isEvent
        self.__maxDifficultyLevel = maxDifficultyLevel
        settings = ViewSettings(R.views.lobby.platoon.WTRTooltip(), model=CommonPlayerDataModel())
        super(WTRTooltip, self).__init__(settings)

    @property
    def viewModel(self):
        return self.getViewModel()

    def _onLoading(self, *args, **kwargs):
        with self.viewModel.transaction() as (model):
            model.setName(self.__name)
            model.setClanTag(self.__clanTag)
            model.setBadgeID(self.__badgeID)
            model.setRating(self.__rating)
            model.setMaxDifficultyLevelMessage(self.__maxDifficultyLevelMessage)
            model.setIsEvent(self.__isEvent)
            model.setMaxDifficultyLevel(self.__maxDifficultyLevel)