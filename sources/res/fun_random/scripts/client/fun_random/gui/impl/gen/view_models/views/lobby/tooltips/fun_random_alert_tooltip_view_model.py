from frameworks.wulf import ViewModel

class FunRandomAlertTooltipViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(FunRandomAlertTooltipViewModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(FunRandomAlertTooltipViewModel, self)._initialize()