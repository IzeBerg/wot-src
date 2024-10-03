from frameworks.wulf import ViewModel

class WtLootboxesTooltipViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(WtLootboxesTooltipViewModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(WtLootboxesTooltipViewModel, self)._initialize()