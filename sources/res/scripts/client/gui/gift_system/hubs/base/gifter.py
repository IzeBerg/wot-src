import typing
from account_helpers import isLongDisconnectedFromCenter
from adisp import adisp_async, adisp_process
from gui.gift_system.constants import GifterResponseState
from gui.gift_system.hubs.subsystems import BaseHubSubsystem
from gui.wgcg.gift_system.contexts import GiftSystemSendGiftCtx
from helpers import dependency
from skeletons.gui.web import IWebController
if typing.TYPE_CHECKING:
    from helpers.server_settings import GiftEventConfig

class IGiftEventGifter(BaseHubSubsystem):

    def getActiveRequest(self):
        raise NotImplementedError

    def getRequestRestriction(self):
        raise NotImplementedError

    @adisp_async
    @adisp_process
    def sendGift(self, entitlementCode, receiverID, metaInfo, callback):
        raise NotImplementedError


class GiftEventBaseGifter(IGiftEventGifter):
    __slots__ = ('__requestCtx', '__responseCallback')
    __webController = dependency.descriptor(IWebController)

    def __init__(self, eventSettings, responseCallback):
        super(GiftEventBaseGifter, self).__init__(eventSettings)
        self.__responseCallback = responseCallback
        self.__requestCtx = None
        return

    def destroy(self):
        self.__responseCallback = None
        super(GiftEventBaseGifter, self).destroy()
        return

    def getActiveRequest(self):
        return self.__requestCtx

    def getRequestRestriction(self):
        if not self._isRequestsEnabled():
            return GifterResponseState.REQUESTS_DISABLED
        else:
            if isLongDisconnectedFromCenter():
                return GifterResponseState.CENTER_DISCONNECTED
            if not self.__webController.isAvailable():
                return GifterResponseState.WGCG_NOT_AVAILABLE
            if self.__requestCtx is not None:
                return GifterResponseState.REQUEST_IN_PROGRESS
            return

    @adisp_async
    @adisp_process
    def sendGift(self, entitlementCode, receiverID, metaInfo, callback=None):
        requestCtx = GiftSystemSendGiftCtx(entitlementCode, receiverID, metaInfo)
        responseData = yield self.__doExternalRequest(requestCtx)
        if callback is not None:
            callback(responseData)
        return

    def _isRequestsEnabled(self):
        return self._settings.isEnabled

    @adisp_async
    @adisp_process
    def __doExternalRequest(self, requestCtx, callback):
        clientRestriction = self.getRequestRestriction()
        if clientRestriction is not None:
            callback(requestCtx.getDataObj(clientRestriction))
            return
        else:
            self.__requestCtx = requestCtx
            result = yield self.__webController.sendRequest(requestCtx)
            resultState = GifterResponseState.WEB_SUCCESS if result.isSuccess() else GifterResponseState.WEB_FAILURE
            resultData = requestCtx.getDataObj(resultState, result.data)
            self.__requestCtx = None
            callback(resultData)
            if self.__responseCallback is not None:
                self.__responseCallback(resultData)
            return