from gui.impl.gen.view_models.views.lobby.tank_setup.sub_views.base_slot_model import BaseSlotModel

class ConsumableSlotModel(BaseSlotModel):
    __slots__ = ()

    def __init__(self, properties=23, commands=0):
        super(ConsumableSlotModel, self).__init__(properties=properties, commands=commands)

    def getDescription(self):
        return self._getString(19)

    def setDescription(self, value):
        self._setString(19, value)

    def getIsBuiltIn(self):
        return self._getBool(20)

    def setIsBuiltIn(self, value):
        self._setBool(20, value)

    def getItemName(self):
        return self._getString(21)

    def setItemName(self, value):
        self._setString(21, value)

    def getIsBuyMoreDisabled(self):
        return self._getBool(22)

    def setIsBuyMoreDisabled(self, value):
        self._setBool(22, value)

    def _initialize(self):
        super(ConsumableSlotModel, self)._initialize()
        self._addStringProperty('description', '')
        self._addBoolProperty('isBuiltIn', False)
        self._addStringProperty('itemName', '')
        self._addBoolProperty('isBuyMoreDisabled', False)