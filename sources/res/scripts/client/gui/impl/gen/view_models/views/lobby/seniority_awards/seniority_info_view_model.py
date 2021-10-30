from frameworks.wulf import ViewModel

class SeniorityInfoViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(SeniorityInfoViewModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(SeniorityInfoViewModel, self)._initialize()