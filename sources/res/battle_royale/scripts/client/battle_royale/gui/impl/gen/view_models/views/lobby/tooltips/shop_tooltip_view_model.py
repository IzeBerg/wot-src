from frameworks.wulf import ViewModel

class ShopTooltipViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(ShopTooltipViewModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(ShopTooltipViewModel, self)._initialize()