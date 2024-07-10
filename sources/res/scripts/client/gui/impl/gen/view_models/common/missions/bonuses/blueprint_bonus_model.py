from gui.impl.gen.view_models.common.missions.bonuses.icon_bonus_model import IconBonusModel

class BlueprintBonusModel(IconBonusModel):
    __slots__ = ()

    def __init__(self, properties=10, commands=0):
        super(BlueprintBonusModel, self).__init__(properties=properties, commands=commands)

    def getType(self):
        return self._getString(9)

    def setType(self, value):
        self._setString(9, value)

    def _initialize(self):
        super(BlueprintBonusModel, self)._initialize()
        self._addStringProperty('type', '')