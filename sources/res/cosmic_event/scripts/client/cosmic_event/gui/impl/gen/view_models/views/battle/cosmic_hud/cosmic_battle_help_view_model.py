from frameworks.wulf import ViewModel

class CosmicBattleHelpViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(CosmicBattleHelpViewModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(CosmicBattleHelpViewModel, self)._initialize()