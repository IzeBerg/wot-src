from gui.impl.gen.view_models.common.missions.bonuses.item_bonus_model import ItemBonusModel

class CustomizationBonusModel(ItemBonusModel):
    __slots__ = ()

    def __init__(self, properties=12, commands=0):
        super(CustomizationBonusModel, self).__init__(properties=properties, commands=commands)

    def getCustomizationID(self):
        return self._getNumber(9)

    def setCustomizationID(self, value):
        self._setNumber(9, value)

    def getItem(self):
        return self._getString(10)

    def setItem(self, value):
        self._setString(10, value)

    def getIcon(self):
        return self._getString(11)

    def setIcon(self, value):
        self._setString(11, value)

    def _initialize(self):
        super(CustomizationBonusModel, self)._initialize()
        self._addNumberProperty('customizationID', 0)
        self._addStringProperty('item', '')
        self._addStringProperty('icon', '')