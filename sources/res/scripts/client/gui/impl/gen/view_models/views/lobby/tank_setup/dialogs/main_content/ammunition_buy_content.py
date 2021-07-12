from frameworks.wulf import Array
from gui.impl.gen.view_models.views.lobby.common.multiple_items_content_model import MultipleItemsContentModel

class AmmunitionBuyContent(MultipleItemsContentModel):
    __slots__ = ()

    def __init__(self, properties=3, commands=0):
        super(AmmunitionBuyContent, self).__init__(properties=properties, commands=commands)

    def getLacksItem(self):
        return self._getArray(2)

    def setLacksItem(self, value):
        self._setArray(2, value)

    def _initialize(self):
        super(AmmunitionBuyContent, self)._initialize()
        self._addArrayProperty('lacksItem', Array())