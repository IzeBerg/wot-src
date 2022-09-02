from frameworks.wulf import ViewModel

class ModeSelectorCardTypes(ViewModel):
    __slots__ = ()
    DEFAULT = 0
    RANDOM = 1
    RANKED = 2
    MAPBOX = 3
    EPIC_BATTLE = 4
    BATTLE_ROYALE = 5

    def __init__(self, properties=0, commands=0):
        super(ModeSelectorCardTypes, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(ModeSelectorCardTypes, self)._initialize()