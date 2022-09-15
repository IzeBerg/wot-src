from frameworks.wulf import ViewModel
from gui.impl.gen.view_models.common.price_model import PriceModel

class RentPriceModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=4, commands=0):
        super(RentPriceModel, self).__init__(properties=properties, commands=commands)

    @property
    def testDrivePrice(self):
        return self._getViewModel(0)

    @staticmethod
    def getTestDrivePriceType():
        return PriceModel

    @property
    def rentPrice(self):
        return self._getViewModel(1)

    @staticmethod
    def getRentPriceType():
        return PriceModel

    def getTestDriveLabel(self):
        return self._getString(2)

    def setTestDriveLabel(self, value):
        self._setString(2, value)

    def getRentLabel(self):
        return self._getString(3)

    def setRentLabel(self, value):
        self._setString(3, value)

    def _initialize(self):
        super(RentPriceModel, self)._initialize()
        self._addViewModelProperty('testDrivePrice', PriceModel())
        self._addViewModelProperty('rentPrice', PriceModel())
        self._addStringProperty('testDriveLabel', '')
        self._addStringProperty('rentLabel', '')