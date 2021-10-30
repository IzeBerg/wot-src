from frameworks.wulf import ViewModel

class InfoViewModel(ViewModel):
    __slots__ = ('onClose', )

    def __init__(self, properties=0, commands=1):
        super(InfoViewModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(InfoViewModel, self)._initialize()
        self.onClose = self._addCommand('onClose')