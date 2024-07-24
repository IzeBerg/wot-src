from frameworks.wulf import ViewModel

class RacesF1HelperViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(RacesF1HelperViewModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(RacesF1HelperViewModel, self)._initialize()