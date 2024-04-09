from frameworks.wulf import ViewModel

class BrCoinTooltipViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(BrCoinTooltipViewModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(BrCoinTooltipViewModel, self)._initialize()