from frameworks.wulf import ViewModel

class EntryPointTooltipModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(EntryPointTooltipModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(EntryPointTooltipModel, self)._initialize()