from gui.impl.gen.view_models.views.lobby.demount_kit.item_price_dialog_model import ItemPriceDialogModel

class OptionalDeviceDialogModel(ItemPriceDialogModel):
    __slots__ = ()

    def __init__(self, properties=17, commands=3):
        super(OptionalDeviceDialogModel, self).__init__(properties=properties, commands=commands)

    def getSpecialType(self):
        return self._getString(16)

    def setSpecialType(self, value):
        self._setString(16, value)

    def _initialize(self):
        super(OptionalDeviceDialogModel, self)._initialize()
        self._addStringProperty('specialType', '')