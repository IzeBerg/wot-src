import logging
from functools import partial
import typing
from BWUtil import AsyncReturn
import wg_async
from adisp import adisp_process
from gui.platform.products_fetcher.fetch_result import FetchResult
from gui.platform.products_fetcher.user_subscriptions.user_subscription import UserSubscription, SubscriptionStatus, SubscriptionRequestPlatform
from gui.platform.products_fetcher.user_subscriptions.fetch_result import UserSubscriptionFetchResult
from gui.wgcg.utils.contexts import PlatformGetUserSubscriptionsCtx
from helpers import dependency
from skeletons.connection_mgr import IConnectionManager
from skeletons.gui.lobby_context import ILobbyContext
from skeletons.gui.platform.product_fetch_controller import IUserSubscriptionsFetchController
from skeletons.gui.web import IWebController
_logger = logging.getLogger(__name__)
if typing.TYPE_CHECKING:
    from typing import Union
    from gui.wgcg.web_controller import WebController
__doc__ = '\nModule takes care of player subscriptions from platform.\n\nUsers can buy two types types of subscriptions. One from Steam, one from platform.\n\nOur workflow with this subscriptions is:\n1. if player has payed wot+, we will download from platform list of his subscriptions.\n2. we will create a list of his subscriptions as list of UserSubscriptions\n   in UserSubscriptionsFetchController._fetchResult.products.\n2. we will set the state of subscription - active, cancelled.\n\nSubscriptions are updated during lobby/hangar load. Cache is set to 5 minutes.\n'

class PlatformGetUserSubscriptionsParams(object):
    _lobbyContext = dependency.descriptor(ILobbyContext)

    def __init__(self):
        serverSettings = self._lobbyContext.getServerSettings()
        self.status = [SubscriptionStatus.ACTIVE.value, SubscriptionStatus.INACTIVE.value]
        self.productCode = serverSettings.getWotPlusProductCode()
        self.platform = SubscriptionRequestPlatform.WG_PLATFORM.value

    def __repr__(self):
        return ('product_code: {product_code} status: {status}, platform: {platform}').format(product_code=self.productCode, status=self.status, platform=self.platform)


class SteamGetUserSubscriptionsParams(PlatformGetUserSubscriptionsParams):

    def __init__(self):
        super(SteamGetUserSubscriptionsParams, self).__init__()
        self.platform = SubscriptionRequestPlatform.STEAM.value


class UserSubscriptionsFetchController(IUserSubscriptionsFetchController):
    _webCtrl = dependency.descriptor(IWebController)
    _connectionMgr = dependency.descriptor(IConnectionManager)
    requestParamsList = [
     PlatformGetUserSubscriptionsParams, SteamGetUserSubscriptionsParams]
    platformFetchCtx = PlatformGetUserSubscriptionsCtx

    def __init__(self):
        super(UserSubscriptionsFetchController, self).__init__()
        self._fetchResult = UserSubscriptionFetchResult()

    def init(self):
        self._connectionMgr.onDisconnected += self._fetchResult.stop

    def fini(self):
        self._connectionMgr.onDisconnected -= self._fetchResult.stop

    @wg_async.wg_async
    def getSubscriptions(self):
        _logger.debug('Trying to fetch subscriptions')
        if self._fetchResult.isProductsReady:
            _logger.debug('Return subscriptions from cache')
            raise AsyncReturn(self._fetchResult)
        self._fetchResult.reset()
        processed = False
        for paramsClass in self.requestParamsList:
            param = paramsClass()
            requestSuccess, subscriptionsData = yield wg_async.await_callback(partial(self._requestSubscriptions, param))()
            if requestSuccess and subscriptionsData:
                _logger.debug('Subscriptions request from %s has been successfully processed.', param.platform)
                for subscriptionData in subscriptionsData:
                    userSubscription = UserSubscription(subscriptionData)
                    hasSubscription = any([ subscription.subscriptionId == userSubscription.subscriptionId for subscription in self._fetchResult.products
                                          ])
                    if not hasSubscription:
                        self._fetchResult.products.append(userSubscription)

                processed = True

        if processed:
            self._fetchResult.setProcessed()
        else:
            self._fetchResult.setFailed()
        raise AsyncReturn(self._fetchResult)

    @adisp_process
    def _requestSubscriptions(self, params, callback):
        ctx = self.platformFetchCtx(params)
        _logger.debug('Request subscriptions for params %s', params)
        response = yield self._webCtrl.sendRequest(ctx=ctx)
        data = response.getData()
        items = data.get('subscriptions') if data else None
        callback((response.isSuccess(), items))
        return

    def reset(self):
        self._fetchResult.reset()