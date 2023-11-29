from gui.impl.gen.view_models.common.missions.bonuses.icon_bonus_model import IconBonusModel

class RewardsModel(IconBonusModel):
    __slots__ = ()

    def __init__(self, properties=9, commands=0):
        super(RewardsModel, self).__init__(properties=properties, commands=commands)

    def getIsReceived(self):
        return self._getBool(8)

    def setIsReceived(self, value):
        self._setBool(8, value)

    def _initialize(self):
        super(RewardsModel, self)._initialize()
        self._addBoolProperty('isReceived', False)