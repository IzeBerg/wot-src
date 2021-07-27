from frameworks.wulf import ViewModel

class CraftmachineEntryPointViewModel(ViewModel):
    __slots__ = ('onActionClick', )

    def __init__(self, properties=2, commands=1):
        super(CraftmachineEntryPointViewModel, self).__init__(properties=properties, commands=commands)

    def getStartDate(self):
        return self._getNumber(0)

    def setStartDate(self, value):
        self._setNumber(0, value)

    def getEndDate(self):
        return self._getNumber(1)

    def setEndDate(self, value):
        self._setNumber(1, value)

    def _initialize(self):
        super(CraftmachineEntryPointViewModel, self)._initialize()
        self._addNumberProperty('startDate', -1)
        self._addNumberProperty('endDate', -1)
        self.onActionClick = self._addCommand('onActionClick')