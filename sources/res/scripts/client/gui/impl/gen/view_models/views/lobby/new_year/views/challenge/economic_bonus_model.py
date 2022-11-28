from gui.impl.gen.view_models.views.lobby.new_year.components.ny_economic_bonus_model import NyEconomicBonusModel

class EconomicBonusModel(NyEconomicBonusModel):
    __slots__ = ()

    def __init__(self, properties=3, commands=0):
        super(EconomicBonusModel, self).__init__(properties=properties, commands=commands)

    def getMaxBonus(self):
        return self._getReal(2)

    def setMaxBonus(self, value):
        self._setReal(2, value)

    def _initialize(self):
        super(EconomicBonusModel, self)._initialize()
        self._addRealProperty('maxBonus', 0.0)