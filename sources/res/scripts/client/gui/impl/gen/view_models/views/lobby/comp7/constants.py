from frameworks.wulf import ViewModel

class Constants(ViewModel):
    __slots__ = ()
    NOT_AVAILABLE_STATISTIC_VALUE = -1

    def __init__(self, properties=0, commands=0):
        super(Constants, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(Constants, self)._initialize()