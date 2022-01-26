from frameworks.wulf import ViewModel

class LunarNyPopoverModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(LunarNyPopoverModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(LunarNyPopoverModel, self)._initialize()