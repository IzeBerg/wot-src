from frameworks.wulf import ViewModel

class ShopSalesEntryPointStates(ViewModel):
    __slots__ = ()
    STATE_LOCKED = 0
    STATE_ACTIVE = 1
    STATE_ENDED = 2
    STATE_PAUSED = 3

    def __init__(self, properties=0, commands=0):
        super(ShopSalesEntryPointStates, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(ShopSalesEntryPointStates, self)._initialize()