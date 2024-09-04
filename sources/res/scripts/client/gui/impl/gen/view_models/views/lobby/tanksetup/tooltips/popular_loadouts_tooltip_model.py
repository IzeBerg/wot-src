from frameworks.wulf import ViewModel

class PopularLoadoutsTooltipModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(PopularLoadoutsTooltipModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(PopularLoadoutsTooltipModel, self)._initialize()