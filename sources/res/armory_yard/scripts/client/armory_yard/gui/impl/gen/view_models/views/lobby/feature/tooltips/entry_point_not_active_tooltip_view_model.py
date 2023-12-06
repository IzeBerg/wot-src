from frameworks.wulf import ViewModel

class EntryPointNotActiveTooltipViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(EntryPointNotActiveTooltipViewModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(EntryPointNotActiveTooltipViewModel, self)._initialize()