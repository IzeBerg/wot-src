from frameworks.wulf import ViewModel

class DifficultyWindowViewModel(ViewModel):
    __slots__ = ('onClose', )

    def __init__(self, properties=1, commands=1):
        super(DifficultyWindowViewModel, self).__init__(properties=properties, commands=commands)

    def getLevel(self):
        return self._getNumber(0)

    def setLevel(self, value):
        self._setNumber(0, value)

    def _initialize(self):
        super(DifficultyWindowViewModel, self)._initialize()
        self._addNumberProperty('level', 0)
        self.onClose = self._addCommand('onClose')