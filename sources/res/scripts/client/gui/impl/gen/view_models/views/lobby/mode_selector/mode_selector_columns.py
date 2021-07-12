from frameworks.wulf import ViewModel

class ModeSelectorColumns(ViewModel):
    __slots__ = ()
    COLUMN_0 = 0
    COLUMN_1 = 1
    COLUMN_2 = 2
    COLUMN_3 = 3

    def __init__(self, properties=0, commands=0):
        super(ModeSelectorColumns, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(ModeSelectorColumns, self)._initialize()