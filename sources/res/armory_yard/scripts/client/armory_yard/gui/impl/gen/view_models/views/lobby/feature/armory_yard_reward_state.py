from frameworks.wulf import ViewModel

class ArmoryYardRewardState(ViewModel):
    __slots__ = ()
    STAGE = 'stage'
    STYLE = 'style'

    def __init__(self, properties=0, commands=0):
        super(ArmoryYardRewardState, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(ArmoryYardRewardState, self)._initialize()