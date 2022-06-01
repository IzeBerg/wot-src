from frameworks.wulf import ViewModel

class DragonBoatIntroViewModel(ViewModel):
    __slots__ = ('onClose', 'onAccept')

    def __init__(self, properties=0, commands=2):
        super(DragonBoatIntroViewModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(DragonBoatIntroViewModel, self)._initialize()
        self.onClose = self._addCommand('onClose')
        self.onAccept = self._addCommand('onAccept')