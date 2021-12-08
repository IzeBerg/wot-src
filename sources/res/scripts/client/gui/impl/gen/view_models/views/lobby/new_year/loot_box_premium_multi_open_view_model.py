from frameworks.wulf import ViewModel

class LootBoxPremiumMultiOpenViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(LootBoxPremiumMultiOpenViewModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(LootBoxPremiumMultiOpenViewModel, self)._initialize()