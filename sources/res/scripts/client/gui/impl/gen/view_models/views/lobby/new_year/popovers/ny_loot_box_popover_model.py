from frameworks.wulf import ViewModel

class NyLootBoxPopoverModel(ViewModel):
    __slots__ = ('onEventBtnClick', 'onBuyBtnClick')

    def __init__(self, properties=1, commands=2):
        super(NyLootBoxPopoverModel, self).__init__(properties=properties, commands=commands)

    def getIsBuyAvailable(self):
        return self._getBool(0)

    def setIsBuyAvailable(self, value):
        self._setBool(0, value)

    def _initialize(self):
        super(NyLootBoxPopoverModel, self)._initialize()
        self._addBoolProperty('isBuyAvailable', True)
        self.onEventBtnClick = self._addCommand('onEventBtnClick')
        self.onBuyBtnClick = self._addCommand('onBuyBtnClick')