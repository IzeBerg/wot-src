import logging
from BWUtil import AsyncReturn
from Event import Event
from adisp import process
from async import async, await_callback
from gui.entitlements.entitlement_common import ENTITLEMENTS, iterConsumers
from gui.entitlements.entitlement_model import AgateEntitlementsModel
from gui.wgcg.agate.contexts import InventoryEntitlementsCtx
from gui.wgcg.states import WebControllerStates
from helpers import dependency
from shared_utils import nextTick
from skeletons.gui.game_control import IEntitlementsController
from skeletons.gui.web import IWebController
_logger = logging.getLogger(__name__)

class EntitlementsController(IEntitlementsController):
    __slots__ = ('__cache', '__cacheWaitSync', '__lastFailedEntitlements')
    __webController = dependency.descriptor(IWebController)

    def __init__(self):
        super(EntitlementsController, self).__init__()
        self.__cache = None
        self.__cacheWaitSync = False
        self.__lastFailedEntitlements = set()
        self.onCacheUpdated = Event()
        return

    def onDisconnected(self):
        self.__cache = None
        self.__cacheWaitSync = False
        self.__lastFailedEntitlements.clear()
        return

    def onAvatarBecomePlayer(self):
        self.__cache = None
        self.__cacheWaitSync = False
        self.__lastFailedEntitlements.clear()
        return

    def onLobbyInited(self, event):
        self.__lastFailedEntitlements.clear()
        if self.__webController.getStateID() == WebControllerStates.STATE_NOT_DEFINED:
            self.__webController.invalidate()
        self.__sendRequest(ENTITLEMENTS, self.__onResponse)

    def fini(self):
        self.onCacheUpdated.clear()

    def isCacheInited(self):
        return self.__cache is not None

    def getBalanceEntitlementFromCache(self, code):
        if self.isCacheInited():
            return self.__cache.getBalanceEntitlement(code)
        else:
            return

    def getConsumedEntitlementFromCache(self, code):
        if self.isCacheInited():
            return self.__cache.getHoldConsumedEntitlement(code)
        else:
            return

    def getGrantedEntitlementFromCache(self, code):
        if self.isCacheInited():
            return self.__cache.getHoldGrantedEntitlement(code)
        else:
            return

    def updateCache(self, codes):
        self.__sendRequest(codes, self.__onResponse)

    def isCodesWasFailedInLastRequest(self, codes):
        return not self.__lastFailedEntitlements.isdisjoint(codes)

    @async
    def forceUpdateCache(self, codes):
        result = yield await_callback(self.__sendRequest)(codes)
        raise AsyncReturn(result)

    @nextTick
    @process
    def __sendRequest(self, codes, callback):
        if self.__cacheWaitSync or not any(c.isConsumesEntitlements for c in iterConsumers()):
            callback(False)
            return
        else:
            if self.__webController.isAvailable():
                try:
                    self.__cacheWaitSync = True
                    response = yield self.__webController.sendRequest(ctx=InventoryEntitlementsCtx(entitlementCodes=codes))
                finally:
                    self.__cacheWaitSync = False

                if response.isSuccess():
                    result = InventoryEntitlementsCtx.getDataObj(response.data)
                    if self.__cache is not None:
                        self.__cache.update(codes, result.get('data', {}))
                        self.__lastFailedEntitlements.difference_update(codes)
                    else:
                        self.__cache = AgateEntitlementsModel(result.get('data', {}))
                else:
                    if self.__cache is not None:
                        self.__lastFailedEntitlements.update(codes)
                    _logger.warning('Failed to get entitlements data. Code: %s.', response.getCode())
                callback(response.isSuccess())
            else:
                _logger.warning("Failed to get entitlements data. Web controller isn't available")
                callback(False)
            return

    def __onResponse(self, *_):
        self.onCacheUpdated()