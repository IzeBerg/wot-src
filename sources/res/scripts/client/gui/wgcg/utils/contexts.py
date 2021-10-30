from gui.wgcg.base.contexts import CommonWebRequestCtx
from gui.wgcg.settings import WebRequestDataType

class SPAAccountAttributeCtx(CommonWebRequestCtx):

    def __init__(self, ctx, waitingID=''):
        self.__attrPrefix = ctx.attr_prefix
        super(SPAAccountAttributeCtx, self).__init__(waitingID=waitingID)

    def getRequestType(self):
        return WebRequestDataType.SPA_GET_ACCOUNT_ATTRIBUTE

    def isAuthorizationRequired(self):
        return True

    def isClanSyncRequired(self):
        return False

    def isCaching(self):
        return False

    def getRequestedAttr(self):
        return self.__attrPrefix

    @staticmethod
    def getDataObj(incomeData):
        return incomeData

    @staticmethod
    def getDefDataObj():
        return


class PlatformFetchProductListCtx(CommonWebRequestCtx):

    def __init__(self, ctx, waitingID=''):
        self.__params = {'header': {}, 'body': {'storefront': ctx.storefront, 
                    'wgid': ctx.wgid, 
                    'language': ctx.language, 
                    'additional_data': ctx.additional_data, 
                    'country': ctx.country, 
                    'response_fields': ctx.response_fields, 
                    'product_codes': ctx.product_codes, 
                    'response_fields_profile': ctx.response_fields_profile, 
                    'category': ctx.category}}
        super(PlatformFetchProductListCtx, self).__init__(waitingID=waitingID)

    def getRequestType(self):
        return WebRequestDataType.PLATFORM_FETCH_PRODUCT_LIST

    def isAuthorizationRequired(self):
        return True

    def isClanSyncRequired(self):
        return False

    def isCaching(self):
        return False

    def getParams(self):
        return self.__params

    @staticmethod
    def getDataObj(incomeData):
        return incomeData

    @staticmethod
    def getDefDataObj():
        return