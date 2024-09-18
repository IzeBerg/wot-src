from frameworks.wulf import ViewModel

class WtEventLootboxesTooltipViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(WtEventLootboxesTooltipViewModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(WtEventLootboxesTooltipViewModel, self)._initialize()