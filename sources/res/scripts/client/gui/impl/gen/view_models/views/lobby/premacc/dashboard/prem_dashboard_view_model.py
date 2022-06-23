from frameworks.wulf import ViewModel

class PremDashboardViewModel(ViewModel):
    __slots__ = ('onCloseAction', 'onInitialized')

    def __init__(self, properties=2, commands=2):
        super(PremDashboardViewModel, self).__init__(properties=properties, commands=commands)

    def getInterfaceScale(self):
        return self._getNumber(0)

    def setInterfaceScale(self, value):
        self._setNumber(0, value)

    def getIsShowParentControl(self):
        return self._getBool(1)

    def setIsShowParentControl(self, value):
        self._setBool(1, value)

    def _initialize(self):
        super(PremDashboardViewModel, self)._initialize()
        self._addNumberProperty('interfaceScale', 0)
        self._addBoolProperty('isShowParentControl', False)
        self.onCloseAction = self._addCommand('onCloseAction')
        self.onInitialized = self._addCommand('onInitialized')