from gui.impl.gen.view_models.views.lobby.comp7.base_product_model import BaseProductModel
from gui.impl.gen.view_models.views.lobby.comp7.comp7_bonus_model import Comp7BonusModel

class RewardProductModel(BaseProductModel):
    __slots__ = ()

    def __init__(self, properties=10, commands=0):
        super(RewardProductModel, self).__init__(properties=properties, commands=commands)

    @property
    def reward(self):
        return self._getViewModel(9)

    @staticmethod
    def getRewardType():
        return Comp7BonusModel

    def _initialize(self):
        super(RewardProductModel, self)._initialize()
        self._addViewModelProperty('reward', Comp7BonusModel())