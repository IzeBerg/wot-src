from gui.impl.gen.view_models.views.lobby.tank_setup.sub_views.base_slot_model import BaseSlotModel

class ConsumableSlotModel(BaseSlotModel):
    __slots__ = ()

    def __init__(self, properties=25, commands=0):
        super(ConsumableSlotModel, self).__init__(properties=properties, commands=commands)

    def getDescription(self):
        return self._getString(20)

    def setDescription(self, value):
        self._setString(20, value)

    def getIsBuiltIn(self):
        return self._getBool(21)

    def setIsBuiltIn(self, value):
        self._setBool(21, value)

    def getItemName(self):
        return self._getString(22)

    def setItemName(self, value):
        self._setString(22, value)

    def getIsBuyMoreDisabled(self):
        return self._getBool(23)

    def setIsBuyMoreDisabled(self, value):
        self._setBool(23, value)

    def getIsBuyMoreHidden(self):
        return self._getBool(24)

    def setIsBuyMoreHidden(self, value):
        self._setBool(24, value)

    def _initialize(self):
        super(ConsumableSlotModel, self)._initialize()
        self._addStringProperty('description', '')
        self._addBoolProperty('isBuiltIn', False)
        self._addStringProperty('itemName', '')
        self._addBoolProperty('isBuyMoreDisabled', False)
        self._addBoolProperty('isBuyMoreHidden', False)