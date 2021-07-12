from frameworks.wulf import ViewModel

class BattlePassCoinTooltipViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(BattlePassCoinTooltipViewModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(BattlePassCoinTooltipViewModel, self)._initialize()