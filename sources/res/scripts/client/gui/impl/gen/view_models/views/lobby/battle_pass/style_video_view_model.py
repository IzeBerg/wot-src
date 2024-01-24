from frameworks.wulf import ViewModel

class StyleVideoViewModel(ViewModel):
    __slots__ = ('onClose', 'onError')

    def __init__(self, properties=2, commands=2):
        super(StyleVideoViewModel, self).__init__(properties=properties, commands=commands)

    def getChapter(self):
        return self._getNumber(0)

    def setChapter(self, value):
        self._setNumber(0, value)

    def getLevel(self):
        return self._getNumber(1)

    def setLevel(self, value):
        self._setNumber(1, value)

    def _initialize(self):
        super(StyleVideoViewModel, self)._initialize()
        self._addNumberProperty('chapter', 0)
        self._addNumberProperty('level', 0)
        self.onClose = self._addCommand('onClose')
        self.onError = self._addCommand('onError')