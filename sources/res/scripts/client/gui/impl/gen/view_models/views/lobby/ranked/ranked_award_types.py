from frameworks.wulf import ViewModel

class RankedAwardTypes(ViewModel):
    __slots__ = ()
    SMALL = 'small'
    MEDIUM = 'medium'
    BIG = 'big'
    LARGE = 'large'

    def __init__(self, properties=0, commands=0):
        super(RankedAwardTypes, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(RankedAwardTypes, self)._initialize()