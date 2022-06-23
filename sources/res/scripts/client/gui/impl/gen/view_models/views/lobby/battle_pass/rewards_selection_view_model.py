from gui.impl.gen.view_models.views.lobby.common.selectable_reward_base_model import SelectableRewardBaseModel

class RewardsSelectionViewModel(SelectableRewardBaseModel):
    __slots__ = ()

    def __init__(self, properties=4, commands=0):
        super(RewardsSelectionViewModel, self).__init__(properties=properties, commands=commands)

    def getLevel(self):
        return self._getNumber(1)

    def setLevel(self, value):
        self._setNumber(1, value)

    def getChapterID(self):
        return self._getNumber(2)

    def setChapterID(self, value):
        self._setNumber(2, value)

    def getFinalReward(self):
        return self._getString(3)

    def setFinalReward(self, value):
        self._setString(3, value)

    def _initialize(self):
        super(RewardsSelectionViewModel, self)._initialize()
        self._addNumberProperty('level', 0)
        self._addNumberProperty('chapterID', 0)
        self._addStringProperty('finalReward', '')