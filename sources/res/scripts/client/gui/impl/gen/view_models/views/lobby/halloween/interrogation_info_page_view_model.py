from frameworks.wulf import ViewModel

class InterrogationInfoPageViewModel(ViewModel):
    __slots__ = ('onAccept', 'onClose')

    def __init__(self, properties=0, commands=2):
        super(InterrogationInfoPageViewModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(InterrogationInfoPageViewModel, self)._initialize()
        self.onAccept = self._addCommand('onAccept')
        self.onClose = self._addCommand('onClose')