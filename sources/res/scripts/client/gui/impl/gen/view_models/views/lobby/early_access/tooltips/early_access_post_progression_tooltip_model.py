from frameworks.wulf import ViewModel

class EarlyAccessPostProgressionTooltipModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(EarlyAccessPostProgressionTooltipModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(EarlyAccessPostProgressionTooltipModel, self)._initialize()