from gui.wgcg.base.handlers import RequestHandlers
from gui.wgcg.settings import WebRequestDataType

class AgateRequestHandlers(RequestHandlers):

    def get(self):
        handlers = {WebRequestDataType.AGATE_INVENTORY_ENTITLEMENTS: self.__getInventoryEntitlements}
        return handlers

    def __getInventoryEntitlements(self, ctx, callback):
        return self._requester.doRequestEx(ctx, callback, ('agate', 'get_inventory_entitlements'), entitlement_codes=ctx.getEntitlementCodes())