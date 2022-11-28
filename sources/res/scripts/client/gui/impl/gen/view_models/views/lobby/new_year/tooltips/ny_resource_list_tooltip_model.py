from frameworks.wulf import ViewModel

class NyResourceListTooltipModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(NyResourceListTooltipModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(NyResourceListTooltipModel, self)._initialize()