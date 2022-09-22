from gui.impl.gen.view_models.common.missions.bonuses.bonus_model import BonusModel

class WtCompensationBonusModel(BonusModel):
    __slots__ = ()

    def __init__(self, properties=8, commands=0):
        super(WtCompensationBonusModel, self).__init__(properties=properties, commands=commands)

    def getCompensationSource(self):
        return self._getString(7)

    def setCompensationSource(self, value):
        self._setString(7, value)

    def _initialize(self):
        super(WtCompensationBonusModel, self)._initialize()
        self._addStringProperty('compensationSource', '')