from frameworks.wulf import ViewModel

class LeaderboardRewardTooltipViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(LeaderboardRewardTooltipViewModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(LeaderboardRewardTooltipViewModel, self)._initialize()