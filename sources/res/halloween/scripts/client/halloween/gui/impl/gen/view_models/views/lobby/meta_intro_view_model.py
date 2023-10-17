from frameworks.wulf import ViewModel

class MetaIntroViewModel(ViewModel):
    __slots__ = ('onClose', )

    def __init__(self, properties=1, commands=1):
        super(MetaIntroViewModel, self).__init__(properties=properties, commands=commands)

    def getId(self):
        return self._getString(0)

    def setId(self, value):
        self._setString(0, value)

    def _initialize(self):
        super(MetaIntroViewModel, self)._initialize()
        self._addStringProperty('id', '')
        self.onClose = self._addCommand('onClose')