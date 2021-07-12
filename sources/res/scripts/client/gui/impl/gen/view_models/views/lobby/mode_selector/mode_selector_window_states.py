from frameworks.wulf import ViewModel

class ModeSelectorWindowStates(ViewModel):
    __slots__ = ()
    NORMAL = 0
    BOOTCAMP = 1

    def __init__(self, properties=0, commands=0):
        super(ModeSelectorWindowStates, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(ModeSelectorWindowStates, self)._initialize()