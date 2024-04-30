from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from historical_battles.gui.impl.gen.view_models.views.common.simple_price_view_model import SimplePriceViewModel

class MultiPriceViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(MultiPriceViewModel, self).__init__(properties=properties, commands=commands)

    def getPrices(self):
        return self._getArray(0)

    def setPrices(self, value):
        self._setArray(0, value)

    @staticmethod
    def getPricesType():
        return SimplePriceViewModel

    def _initialize(self):
        super(MultiPriceViewModel, self)._initialize()
        self._addArrayProperty('prices', Array())