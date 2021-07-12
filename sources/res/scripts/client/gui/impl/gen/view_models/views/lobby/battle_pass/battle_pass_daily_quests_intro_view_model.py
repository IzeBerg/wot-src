from frameworks.wulf import ViewModel

class BattlePassDailyQuestsIntroViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(BattlePassDailyQuestsIntroViewModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(BattlePassDailyQuestsIntroViewModel, self)._initialize()