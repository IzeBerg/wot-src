from frameworks.wulf import ViewModel

class TimerTooltipViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(TimerTooltipViewModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(TimerTooltipViewModel, self)._initialize()