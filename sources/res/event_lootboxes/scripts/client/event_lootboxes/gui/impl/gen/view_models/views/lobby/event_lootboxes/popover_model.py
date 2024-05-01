from frameworks.wulf import ViewModel

class PopoverModel(ViewModel):
    __slots__ = ('onOpenBtnClick', 'onBuyBtnClick')

    def __init__(self, properties=12, commands=2):
        super(PopoverModel, self).__init__(properties=properties, commands=commands)

    def getEventExpireTime(self):
        return self._getNumber(0)

    def setEventExpireTime(self, value):
        self._setNumber(0, value)

    def getCount(self):
        return self._getNumber(1)

    def setCount(self, value):
        self._setNumber(1, value)

    def getIsOpenAvailable(self):
        return self._getBool(2)

    def setIsOpenAvailable(self, value):
        self._setBool(2, value)

    def getIsBuyAvailable(self):
        return self._getBool(3)

    def setIsBuyAvailable(self, value):
        self._setBool(3, value)

    def getMainRewardBoxesLeft(self):
        return self._getNumber(4)

    def setMainRewardBoxesLeft(self, value):
        self._setNumber(4, value)

    def getMaxBoxesAvailableToBuy(self):
        return self._getNumber(5)

    def setMaxBoxesAvailableToBuy(self, value):
        self._setNumber(5, value)

    def getBoxesAvailableToBuy(self):
        return self._getNumber(6)

    def setBoxesAvailableToBuy(self, value):
        self._setNumber(6, value)

    def getGuaranteedLimit(self):
        return self._getNumber(7)

    def setGuaranteedLimit(self, value):
        self._setNumber(7, value)

    def getBuyingEnableTime(self):
        return self._getNumber(8)

    def setBuyingEnableTime(self, value):
        self._setNumber(8, value)

    def getIsLastEventDay(self):
        return self._getBool(9)

    def setIsLastEventDay(self, value):
        self._setBool(9, value)

    def getHasErrors(self):
        return self._getBool(10)

    def setHasErrors(self, value):
        self._setBool(10, value)

    def getUseExternalShop(self):
        return self._getBool(11)

    def setUseExternalShop(self, value):
        self._setBool(11, value)

    def _initialize(self):
        super(PopoverModel, self)._initialize()
        self._addNumberProperty('eventExpireTime', 0)
        self._addNumberProperty('count', 0)
        self._addBoolProperty('isOpenAvailable', True)
        self._addBoolProperty('isBuyAvailable', True)
        self._addNumberProperty('mainRewardBoxesLeft', 0)
        self._addNumberProperty('maxBoxesAvailableToBuy', 0)
        self._addNumberProperty('boxesAvailableToBuy', 0)
        self._addNumberProperty('guaranteedLimit', 0)
        self._addNumberProperty('buyingEnableTime', 0)
        self._addBoolProperty('isLastEventDay', False)
        self._addBoolProperty('hasErrors', False)
        self._addBoolProperty('useExternalShop', False)
        self.onOpenBtnClick = self._addCommand('onOpenBtnClick')
        self.onBuyBtnClick = self._addCommand('onBuyBtnClick')