from gui.impl.gen.view_models.common.price_item_model import PriceItemModel

class ProductPriceModel(PriceItemModel):
    __slots__ = ()

    def __init__(self, properties=4, commands=0):
        super(ProductPriceModel, self).__init__(properties=properties, commands=commands)

    def getDiscountValue(self):
        return self._getNumber(3)

    def setDiscountValue(self, value):
        self._setNumber(3, value)

    def _initialize(self):
        super(ProductPriceModel, self)._initialize()
        self._addNumberProperty('discountValue', 0)