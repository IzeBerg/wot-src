from frameworks.wulf import ViewModel

class TooltipConstants(ViewModel):
    __slots__ = ()
    SKILL = 'crewPerkGf'
    COMMANDER_BONUS = 'commanderBonus'
    ACHIEVEMENT = 'achievement'
    SKIN = 'crewSkin'
    TANKMAN = 'tankman'
    TANKMAN_NOT_RECRUITED = 'tankmanNotRecruited'

    def __init__(self, properties=0, commands=0):
        super(TooltipConstants, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(TooltipConstants, self)._initialize()