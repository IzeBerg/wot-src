from gui.impl.gen.view_models.views.lobby.common.buy_and_exchange_bottom_content_type import BuyAndExchangeBottomContentType

class ConfirmBottomContentType(BuyAndExchangeBottomContentType):
    __slots__ = ()
    SAVE_SLOTS_CONTENT = 'saveSlotsContent'

    def __init__(self, properties=0, commands=0):
        super(ConfirmBottomContentType, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(ConfirmBottomContentType, self)._initialize()