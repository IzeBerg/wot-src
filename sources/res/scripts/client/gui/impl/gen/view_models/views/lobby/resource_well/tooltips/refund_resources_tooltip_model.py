from frameworks.wulf import ViewModel

class RefundResourcesTooltipModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(RefundResourcesTooltipModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(RefundResourcesTooltipModel, self)._initialize()