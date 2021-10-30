from frameworks.wulf import ViewModel

class BattlePassStyleInfoTooltipViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(BattlePassStyleInfoTooltipViewModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(BattlePassStyleInfoTooltipViewModel, self)._initialize()