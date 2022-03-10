from frameworks.wulf import ViewModel

class PremDashboardViewModel(ViewModel):
    __slots__ = ('onCloseAction', 'onInitialized')

    def __init__(self, properties=1, commands=2):
        super(PremDashboardViewModel, self).__init__(properties=properties, commands=commands)

    def getInterfaceScale(self):
        return self._getNumber(0)

    def setInterfaceScale(self, value):
        self._setNumber(0, value)

    def _initialize(self):
        super(PremDashboardViewModel, self)._initialize()
        self._addNumberProperty('interfaceScale', 0)
        self.onCloseAction = self._addCommand('onCloseAction')
        self.onInitialized = self._addCommand('onInitialized')