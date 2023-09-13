from frameworks.wulf import ViewModel

class YearlyStatisticsModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(YearlyStatisticsModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(YearlyStatisticsModel, self)._initialize()