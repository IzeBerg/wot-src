from frameworks.wulf import ViewModel

class NyCraftStates(ViewModel):
    __slots__ = ()
    CRAFT_REGULAR = 0
    CRAFT_MEGA = 1
    CRAFT_REGULAR_WITH_FILLER = 2

    def __init__(self, properties=0, commands=0):
        super(NyCraftStates, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(NyCraftStates, self)._initialize()