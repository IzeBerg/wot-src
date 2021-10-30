from gui.impl.gen.view_models.views.lobby.battle_pass.reward_option_model import RewardOptionModel

class CrewBookRewardOptionModel(RewardOptionModel):
    __slots__ = ()

    def __init__(self, properties=7, commands=0):
        super(CrewBookRewardOptionModel, self).__init__(properties=properties, commands=commands)

    def getExpBonusValue(self):
        return self._getNumber(6)

    def setExpBonusValue(self, value):
        self._setNumber(6, value)

    def _initialize(self):
        super(CrewBookRewardOptionModel, self)._initialize()
        self._addNumberProperty('expBonusValue', 0)