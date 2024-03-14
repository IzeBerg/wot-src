from frameworks.wulf import ViewModel

class ProxyCurrencyTooltipViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(ProxyCurrencyTooltipViewModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(ProxyCurrencyTooltipViewModel, self)._initialize()