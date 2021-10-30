from frameworks.wulf import ViewModel

class LootBoxCompensationTooltipTypes(ViewModel):
    __slots__ = ()
    BASE = 'base'
    VEHICLE = 'vehicle'
    CREW_SKINS = 'crewSkin'

    def __init__(self, properties=0, commands=0):
        super(LootBoxCompensationTooltipTypes, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(LootBoxCompensationTooltipTypes, self)._initialize()