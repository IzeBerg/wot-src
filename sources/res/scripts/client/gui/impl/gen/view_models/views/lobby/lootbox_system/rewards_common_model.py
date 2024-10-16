from frameworks.wulf import ViewModel

class RewardsCommonModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(RewardsCommonModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(RewardsCommonModel, self)._initialize()