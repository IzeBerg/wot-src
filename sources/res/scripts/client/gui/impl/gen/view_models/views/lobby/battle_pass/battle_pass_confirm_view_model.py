from frameworks.wulf import ViewModel

class BattlePassConfirmViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(BattlePassConfirmViewModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(BattlePassConfirmViewModel, self)._initialize()