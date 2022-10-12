from frameworks.wulf import ViewModel

class EntryPointModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(EntryPointModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(EntryPointModel, self)._initialize()