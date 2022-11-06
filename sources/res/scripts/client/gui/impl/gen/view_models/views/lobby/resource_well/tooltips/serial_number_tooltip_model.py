from frameworks.wulf import ViewModel

class SerialNumberTooltipModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(SerialNumberTooltipModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(SerialNumberTooltipModel, self)._initialize()