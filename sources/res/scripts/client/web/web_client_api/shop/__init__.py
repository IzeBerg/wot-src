from web.web_client_api import w2capi
from web.web_client_api.shop.actions import ActionsWebApiMixin
from web.web_client_api.shop.boosters import BoostersInfoWebApiMixin
from web.web_client_api.shop.personal_trade import PersonalTradeWebApiMixin
from web.web_client_api.shop.stats import BalanceWebApiMixin
from web.web_client_api.shop.stock import ItemsWebApiMixin
from web.web_client_api.shop.renewable_subscription import RenewableSubWebApiMixin
from web.web_client_api.shop.telecom_rentals import TelecomRentalsWebApiMixin
from web.web_client_api.shop.trade import TradeWebApiMixin

@w2capi(name='shop', key='action')
class ShopWebApi(ActionsWebApiMixin, BalanceWebApiMixin, ItemsWebApiMixin, TradeWebApiMixin, PersonalTradeWebApiMixin, BoostersInfoWebApiMixin, RenewableSubWebApiMixin, TelecomRentalsWebApiMixin):
    pass