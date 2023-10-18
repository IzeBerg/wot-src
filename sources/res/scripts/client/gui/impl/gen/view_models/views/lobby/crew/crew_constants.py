from frameworks.wulf import ViewModel

class CrewConstants(ViewModel):
    __slots__ = ()
    DONT_SHOW_LEVEL = -1

    def __init__(self, properties=0, commands=0):
        super(CrewConstants, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(CrewConstants, self)._initialize()