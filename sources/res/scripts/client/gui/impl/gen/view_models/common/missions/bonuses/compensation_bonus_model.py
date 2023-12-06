from gui.impl.gen.view_models.common.missions.bonuses.bonus_model import BonusModel

class CompensationBonusModel(BonusModel):
    __slots__ = ()

    def __init__(self, properties=8, commands=0):
        super(CompensationBonusModel, self).__init__(properties=properties, commands=commands)

    @property
    def compensatedItem(self):
        return self._getViewModel(7)

    @staticmethod
    def getCompensatedItemType():
        return BonusModel

    def _initialize(self):
        super(CompensationBonusModel, self)._initialize()
        self._addViewModelProperty('compensatedItem', BonusModel())