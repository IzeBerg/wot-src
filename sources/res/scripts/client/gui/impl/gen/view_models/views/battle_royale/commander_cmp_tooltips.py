from frameworks.wulf import ViewModel

class CommanderCmpTooltips(ViewModel):
    __slots__ = ()
    TOOLTIP_SIXTH_SENSE_SKILL = 'commander_sixthSense'
    TOOLTIP_EXPERT_SKILL = 'commander_expert'
    TOOLTIP_TANKMAN = 'battleRoyaleTankman'

    def __init__(self, properties=0, commands=0):
        super(CommanderCmpTooltips, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(CommanderCmpTooltips, self)._initialize()