from frameworks.wulf import ViewModel

class Birthday2023IntroViewModel(ViewModel):
    __slots__ = ('onClose', )

    def __init__(self, properties=0, commands=1):
        super(Birthday2023IntroViewModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(Birthday2023IntroViewModel, self)._initialize()
        self.onClose = self._addCommand('onClose')