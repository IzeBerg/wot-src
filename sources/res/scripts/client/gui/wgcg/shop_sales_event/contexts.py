from gui.wgcg.base.contexts import CommonWebRequestCtx
from gui.wgcg.settings import WebRequestDataType

class ShopSalesEventFetchFavoritesCtx(CommonWebRequestCtx):

    def getRequestType(self):
        return WebRequestDataType.SHOP_SALES_EVENT_FETCH_FAVORITES

    def isAuthorizationRequired(self):
        return True

    def isClanSyncRequired(self):
        return False

    def isCaching(self):
        return False