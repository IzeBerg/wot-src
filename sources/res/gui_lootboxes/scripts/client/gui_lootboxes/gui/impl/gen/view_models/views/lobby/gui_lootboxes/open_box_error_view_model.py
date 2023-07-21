from frameworks.wulf import ViewModel

class OpenBoxErrorViewModel(ViewModel):
    __slots__ = ('toHangar', )

    def __init__(self, properties=0, commands=1):
        super(OpenBoxErrorViewModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(OpenBoxErrorViewModel, self)._initialize()
        self.toHangar = self._addCommand('toHangar')