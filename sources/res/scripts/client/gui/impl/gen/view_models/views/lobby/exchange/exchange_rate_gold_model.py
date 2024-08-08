from gui.impl.gen.view_models.views.lobby.exchange.exchange_rate_base_model import ExchangeRateBaseModel

class ExchangeRateGoldModel(ExchangeRateBaseModel):
    __slots__ = ()

    def __init__(self, properties=9, commands=4):
        super(ExchangeRateGoldModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(ExchangeRateGoldModel, self)._initialize()