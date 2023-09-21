from frameworks.wulf import ViewModel

class ResultState(ViewModel):
    __slots__ = ()
    STAGE = 'stage'
    RANK = 'rank'
    RANK_LOST = 'rank_lost'
    DIVISION = 'division'
    LEAGUE = 'league'

    def __init__(self, properties=0, commands=0):
        super(ResultState, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(ResultState, self)._initialize()