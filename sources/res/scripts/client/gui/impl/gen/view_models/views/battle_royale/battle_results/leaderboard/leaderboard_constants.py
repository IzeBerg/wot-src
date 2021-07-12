from frameworks.wulf import ViewModel

class LeaderboardConstants(ViewModel):
    __slots__ = ()
    LIST_TYPE_BR_SOLO = 'listBrSolo'
    LIST_TYPE_BR_PLATOON = 'listBrPlatoon'
    ROW_TYPE_BR_PLAYER = 'rowBrPlayer'
    ROW_TYPE_BR_PLATOON = 'rowBrPlatoon'
    ROW_TYPE_BR_ENEMY = 'rowBrEnemy'

    def __init__(self, properties=0, commands=0):
        super(LeaderboardConstants, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(LeaderboardConstants, self)._initialize()