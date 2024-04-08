from frameworks.wulf import ViewModel

class ReservesIntroViewModel(ViewModel):
    __slots__ = ('onClose', 'onDetailsClicked')

    def __init__(self, properties=0, commands=2):
        super(ReservesIntroViewModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(ReservesIntroViewModel, self)._initialize()
        self.onClose = self._addCommand('onClose')
        self.onDetailsClicked = self._addCommand('onDetailsClicked')