from frameworks.wulf import ViewModel

class EnvelopesEntryTooltipModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(EnvelopesEntryTooltipModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(EnvelopesEntryTooltipModel, self)._initialize()