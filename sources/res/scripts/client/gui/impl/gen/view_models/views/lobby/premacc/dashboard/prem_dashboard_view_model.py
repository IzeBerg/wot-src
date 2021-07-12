from frameworks.wulf import ViewModel

class PremDashboardViewModel(ViewModel):
    __slots__ = ('onCloseAction', 'onInitialized')

    def __init__(self, properties=0, commands=2):
        super(PremDashboardViewModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(PremDashboardViewModel, self)._initialize()
        self.onCloseAction = self._addCommand('onCloseAction')
        self.onInitialized = self._addCommand('onInitialized')