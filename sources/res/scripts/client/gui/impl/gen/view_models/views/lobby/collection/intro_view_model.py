from frameworks.wulf import ViewModel

class IntroViewModel(ViewModel):
    __slots__ = ('onClose', )

    def __init__(self, properties=0, commands=1):
        super(IntroViewModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(IntroViewModel, self)._initialize()
        self.onClose = self._addCommand('onClose')