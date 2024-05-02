from frameworks.wulf import ViewModel

class LeavingViewModel(ViewModel):
    __slots__ = ('cancelWithEsc', 'onLeave', 'onCancel')

    def __init__(self, properties=0, commands=3):
        super(LeavingViewModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(LeavingViewModel, self)._initialize()
        self.cancelWithEsc = self._addCommand('cancelWithEsc')
        self.onLeave = self._addCommand('onLeave')
        self.onCancel = self._addCommand('onCancel')