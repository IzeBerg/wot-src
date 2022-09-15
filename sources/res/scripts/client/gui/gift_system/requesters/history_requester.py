import BigWorld
from adisp import adisp_async
from constants import REQUEST_COOLDOWN
from gui.gift_system.requesters.base_requester import GiftSystemBaseRequester

class GiftSystemHistoryRequester(GiftSystemBaseRequester):
    __slots__ = ()

    def _getInvokeDelay(self):
        return REQUEST_COOLDOWN.SYNC_GIFTS

    @adisp_async
    def _doExternalRequest(self, reqEventIds, callback):
        BigWorld.player().giftSystem.requestGiftsHistory(reqEventIds, callback)