from frameworks.wulf import ViewModel

class CrewMembersTooltipModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(CrewMembersTooltipModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(CrewMembersTooltipModel, self)._initialize()