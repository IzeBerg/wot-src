from frameworks.wulf import ViewModel

class AmmunitionPanelConstants(ViewModel):
    __slots__ = ()
    NO_GROUP = 0
    EQUIPMENT_AND_SHELLS = 1
    OPTIONAL_DEVICES_AND_BOOSTERS = 2

    def __init__(self, properties=0, commands=0):
        super(AmmunitionPanelConstants, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(AmmunitionPanelConstants, self)._initialize()