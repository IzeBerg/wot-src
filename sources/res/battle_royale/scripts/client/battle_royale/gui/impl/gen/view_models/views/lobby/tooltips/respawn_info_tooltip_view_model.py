from frameworks.wulf import ViewModel

class RespawnInfoTooltipViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(RespawnInfoTooltipViewModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(RespawnInfoTooltipViewModel, self)._initialize()