from frameworks.wulf import ViewModel

class CrewWelcomeScreenModel(ViewModel):
    __slots__ = ('onCloseClick', )

    def __init__(self, properties=0, commands=1):
        super(CrewWelcomeScreenModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(CrewWelcomeScreenModel, self)._initialize()
        self.onCloseClick = self._addCommand('onCloseClick')