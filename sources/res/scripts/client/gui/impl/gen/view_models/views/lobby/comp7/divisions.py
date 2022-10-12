from frameworks.wulf import ViewModel

class Divisions(ViewModel):
    __slots__ = ()
    NONE = 0
    A = 1
    B = 2
    C = 3
    D = 4

    def __init__(self, properties=0, commands=0):
        super(Divisions, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(Divisions, self)._initialize()