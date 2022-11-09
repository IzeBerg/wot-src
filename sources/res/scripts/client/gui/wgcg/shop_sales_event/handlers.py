from gui.wgcg.base.handlers import RequestHandlers
from gui.wgcg.settings import WebRequestDataType

class ShopSalesEventRequestHandlers(RequestHandlers):

    def get(self):
        handlers = {WebRequestDataType.SHOP_SALES_EVENT_FETCH_FAVORITES: self.__fetchFavorites}
        return handlers

    def __fetchFavorites(self, ctx, callback):
        reqCtx = self._requester.doRequestEx(ctx, callback, ('shop_sales_event', 'shop_sales_event_fetch_favorites'))
        return reqCtx