from frameworks.wulf import ViewModel

class IntroAmmunitionSetupViewModel(ViewModel):
    __slots__ = ('onClose', )

    def __init__(self, properties=0, commands=1):
        super(IntroAmmunitionSetupViewModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(IntroAmmunitionSetupViewModel, self)._initialize()
        self.onClose = self._addCommand('onClose')