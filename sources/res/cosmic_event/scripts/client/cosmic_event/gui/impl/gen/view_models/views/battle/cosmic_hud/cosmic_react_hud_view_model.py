from frameworks.wulf import ViewModel

class CosmicReactHudViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(CosmicReactHudViewModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(CosmicReactHudViewModel, self)._initialize()