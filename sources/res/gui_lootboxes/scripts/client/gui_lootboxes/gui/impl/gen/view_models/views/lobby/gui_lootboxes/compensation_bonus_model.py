from gui.impl.gen.view_models.common.missions.bonuses.item_bonus_model import ItemBonusModel

class CompensationBonusModel(ItemBonusModel):
    __slots__ = ()

    def __init__(self, properties=10, commands=0):
        super(CompensationBonusModel, self).__init__(properties=properties, commands=commands)

    def getCompensatedBonus(self):
        return self._getString(9)

    def setCompensatedBonus(self, value):
        self._setString(9, value)

    def _initialize(self):
        super(CompensationBonusModel, self)._initialize()
        self._addStringProperty('compensatedBonus', '')