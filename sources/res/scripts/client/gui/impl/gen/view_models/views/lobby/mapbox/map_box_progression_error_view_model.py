from frameworks.wulf import ViewModel

class MapBoxProgressionErrorViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(MapBoxProgressionErrorViewModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(MapBoxProgressionErrorViewModel, self)._initialize()