from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from halloween.gui.impl.gen.view_models.views.lobby.bundle_bonus_model import BundleBonusModel
from halloween.gui.impl.gen.view_models.views.lobby.bundle_price_model import BundlePriceModel

class BundleModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=6, commands=0):
        super(BundleModel, self).__init__(properties=properties, commands=commands)

    @property
    def price(self):
        return self._getViewModel(0)

    @staticmethod
    def getPriceType():
        return BundlePriceModel

    def getId(self):
        return self._getString(1)

    def setId(self, value):
        self._setString(1, value)

    def getBundleName(self):
        return self._getString(2)

    def setBundleName(self, value):
        self._setString(2, value)

    def getDate(self):
        return self._getString(3)

    def setDate(self, value):
        self._setString(3, value)

    def getCanBeBoughtTimes(self):
        return self._getNumber(4)

    def setCanBeBoughtTimes(self, value):
        self._setNumber(4, value)

    def getBonuses(self):
        return self._getArray(5)

    def setBonuses(self, value):
        self._setArray(5, value)

    @staticmethod
    def getBonusesType():
        return BundleBonusModel

    def _initialize(self):
        super(BundleModel, self)._initialize()
        self._addViewModelProperty('price', BundlePriceModel())
        self._addStringProperty('id', '')
        self._addStringProperty('bundleName', '')
        self._addStringProperty('date', '')
        self._addNumberProperty('canBeBoughtTimes', 0)
        self._addArrayProperty('bonuses', Array())