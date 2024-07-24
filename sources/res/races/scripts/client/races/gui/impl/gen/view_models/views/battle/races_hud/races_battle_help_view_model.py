from frameworks.wulf import ViewModel

class RacesBattleHelpViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(RacesBattleHelpViewModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(RacesBattleHelpViewModel, self)._initialize()