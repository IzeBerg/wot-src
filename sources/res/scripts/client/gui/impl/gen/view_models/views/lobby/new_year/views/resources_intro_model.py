from frameworks.wulf import ViewModel

class ResourcesIntroModel(ViewModel):
    __slots__ = ('onClose', )

    def __init__(self, properties=0, commands=1):
        super(ResourcesIntroModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(ResourcesIntroModel, self)._initialize()
        self.onClose = self._addCommand('onClose')