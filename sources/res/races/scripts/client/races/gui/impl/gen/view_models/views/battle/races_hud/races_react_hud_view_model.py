from frameworks.wulf import ViewModel

class RacesReactHudViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(RacesReactHudViewModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(RacesReactHudViewModel, self)._initialize()