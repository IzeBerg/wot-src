from frameworks.wulf import ViewModel

class BuyAndExchangeBottomContentType(ViewModel):
    __slots__ = ()
    DEAL_PANEL = 'dealPanel'
    EXCHANGE_PANEL = 'exchangePanel'

    def __init__(self, properties=0, commands=0):
        super(BuyAndExchangeBottomContentType, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(BuyAndExchangeBottomContentType, self)._initialize()