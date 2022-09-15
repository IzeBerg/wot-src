from frameworks.wulf import ViewModel

class Ranks(ViewModel):
    __slots__ = ()
    FIRST = 1
    SECOND = 2
    THIRD = 3
    FOURTH = 4
    FIFTH = 5
    SIXTH = 6
    SEVENTH = 7

    def __init__(self, properties=0, commands=0):
        super(Ranks, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(Ranks, self)._initialize()