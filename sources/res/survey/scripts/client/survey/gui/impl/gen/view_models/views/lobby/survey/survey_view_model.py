from frameworks.wulf import ViewModel

class SurveyViewModel(ViewModel):
    __slots__ = ('onAccept', 'onExit')

    def __init__(self, properties=1, commands=2):
        super(SurveyViewModel, self).__init__(properties=properties, commands=commands)

    def getResult(self):
        return self._getNumber(0)

    def setResult(self, value):
        self._setNumber(0, value)

    def _initialize(self):
        super(SurveyViewModel, self)._initialize()
        self._addNumberProperty('result', 0)
        self.onAccept = self._addCommand('onAccept')
        self.onExit = self._addCommand('onExit')