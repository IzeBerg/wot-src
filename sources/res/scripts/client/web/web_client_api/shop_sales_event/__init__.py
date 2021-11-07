from web.web_client_api import w2capi
from web.web_client_api.shop_sales_event.commands import ShopSalesEventWebApiMixin

@w2capi(name='shop_sales', key='action')
class ShopSalesEventWebApi(ShopSalesEventWebApiMixin):
    pass