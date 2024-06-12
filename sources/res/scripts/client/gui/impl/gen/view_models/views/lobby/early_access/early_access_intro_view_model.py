from frameworks.wulf import ViewModel

class EarlyAccessIntroViewModel(ViewModel):
    __slots__ = ('onClose', 'onContinue')

    def __init__(self, properties=2, commands=2):
        super(EarlyAccessIntroViewModel, self).__init__(properties=properties, commands=commands)

    def getStartDate(self):
        return self._getNumber(0)

    def setStartDate(self, value):
        self._setNumber(0, value)

    def getEndDate(self):
        return self._getNumber(1)

    def setEndDate(self, value):
        self._setNumber(1, value)

    def _initialize(self):
        super(EarlyAccessIntroViewModel, self)._initialize()
        self._addNumberProperty('startDate', 0)
        self._addNumberProperty('endDate', 0)
        self.onClose = self._addCommand('onClose')
        self.onContinue = self._addCommand('onContinue')