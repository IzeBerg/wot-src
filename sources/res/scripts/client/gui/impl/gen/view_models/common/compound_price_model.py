from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from gui.impl.gen.view_models.common.price_model import PriceModel

class CompoundPriceModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(CompoundPriceModel, self).__init__(properties=properties, commands=commands)

    def getPrices(self):
        return self._getArray(0)

    def setPrices(self, value):
        self._setArray(0, value)

    def _initialize(self):
        super(CompoundPriceModel, self)._initialize()
        self._addArrayProperty('prices', Array())