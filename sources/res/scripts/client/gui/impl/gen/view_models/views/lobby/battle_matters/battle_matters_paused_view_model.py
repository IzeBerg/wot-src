from frameworks.wulf import ViewModel

class BattleMattersPausedViewModel(ViewModel):
    __slots__ = ('gotoHangar', )

    def __init__(self, properties=0, commands=1):
        super(BattleMattersPausedViewModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(BattleMattersPausedViewModel, self)._initialize()
        self.gotoHangar = self._addCommand('gotoHangar')