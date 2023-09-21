from frameworks.wulf import ViewModel

class WtEventStampTooltipViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(WtEventStampTooltipViewModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(WtEventStampTooltipViewModel, self)._initialize()