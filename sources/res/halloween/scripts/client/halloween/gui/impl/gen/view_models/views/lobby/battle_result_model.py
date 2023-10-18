from frameworks.wulf import ViewModel

class BattleResultModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(BattleResultModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(BattleResultModel, self)._initialize()