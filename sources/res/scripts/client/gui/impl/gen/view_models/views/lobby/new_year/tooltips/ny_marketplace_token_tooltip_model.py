from frameworks.wulf import ViewModel

class NyMarketplaceTokenTooltipModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(NyMarketplaceTokenTooltipModel, self).__init__(properties=properties, commands=commands)

    def getMarketplaceIsActive(self):
        return self._getBool(0)

    def setMarketplaceIsActive(self, value):
        self._setBool(0, value)

    def _initialize(self):
        super(NyMarketplaceTokenTooltipModel, self)._initialize()
        self._addBoolProperty('marketplaceIsActive', False)