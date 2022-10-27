from gui.impl.gen.view_models.views.lobby.tank_setup.sub_views.base_slot_model import BaseSlotModel

class HwConsumableSlotModel(BaseSlotModel):
    __slots__ = ()

    def __init__(self, properties=22, commands=0):
        super(HwConsumableSlotModel, self).__init__(properties=properties, commands=commands)

    def getDescription(self):
        return self._getString(18)

    def setDescription(self, value):
        self._setString(18, value)

    def getIsBuiltIn(self):
        return self._getBool(19)

    def setIsBuiltIn(self, value):
        self._setBool(19, value)

    def getItemName(self):
        return self._getString(20)

    def setItemName(self, value):
        self._setString(20, value)

    def getIsBuyMoreDisabled(self):
        return self._getBool(21)

    def setIsBuyMoreDisabled(self, value):
        self._setBool(21, value)

    def _initialize(self):
        super(HwConsumableSlotModel, self)._initialize()
        self._addStringProperty('description', '')
        self._addBoolProperty('isBuiltIn', False)
        self._addStringProperty('itemName', '')
        self._addBoolProperty('isBuyMoreDisabled', False)