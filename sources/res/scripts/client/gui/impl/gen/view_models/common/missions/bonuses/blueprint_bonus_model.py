from gui.impl.gen.view_models.common.missions.bonuses.icon_bonus_model import IconBonusModel

class BlueprintBonusModel(IconBonusModel):
    __slots__ = ()

    def __init__(self, properties=9, commands=0):
        super(BlueprintBonusModel, self).__init__(properties=properties, commands=commands)

    def getType(self):
        return self._getString(8)

    def setType(self, value):
        self._setString(8, value)

    def _initialize(self):
        super(BlueprintBonusModel, self)._initialize()
        self._addStringProperty('type', '')