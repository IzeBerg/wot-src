from frameworks.wulf import ViewModel

class BoxesCommonModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(BoxesCommonModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(BoxesCommonModel, self)._initialize()