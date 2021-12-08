from frameworks.wulf import ViewModel

class TooltipConstants(ViewModel):
    __slots__ = ()
    SUBTITLE = 'TOOLTIP_SUBTITLE_ID'
    REWARD = 'TOOLTIP_REWARD_ID'

    def __init__(self, properties=0, commands=0):
        super(TooltipConstants, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(TooltipConstants, self)._initialize()