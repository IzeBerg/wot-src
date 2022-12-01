from gui.impl.gen.view_models.common.missions.bonuses.icon_bonus_model import IconBonusModel

class ChallengeRewardItemModel(IconBonusModel):
    __slots__ = ()

    def __init__(self, properties=9, commands=0):
        super(ChallengeRewardItemModel, self).__init__(properties=properties, commands=commands)

    def getIntCD(self):
        return self._getNumber(8)

    def setIntCD(self, value):
        self._setNumber(8, value)

    def _initialize(self):
        super(ChallengeRewardItemModel, self)._initialize()
        self._addNumberProperty('intCD', 0)