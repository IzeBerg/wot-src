from frameworks.wulf import ViewModel

class WelcomeScreenModel(ViewModel):
    __slots__ = ('onClose', )

    def __init__(self, properties=0, commands=1):
        super(WelcomeScreenModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(WelcomeScreenModel, self)._initialize()
        self.onClose = self._addCommand('onClose')