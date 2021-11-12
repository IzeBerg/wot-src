import BigWorld
from adisp import async
from gui.shared.utils.requesters.abstract import AbstractSyncDataRequester
from skeletons.gui.shared.utils.requesters import IGiftSystemRequester

class GiftSystemRequester(AbstractSyncDataRequester, IGiftSystemRequester):

    @property
    def isHistoryReady(self):
        return bool(self.getCacheValue('isReady', False))

    @async
    def _requestCache(self, callback):
        BigWorld.player().giftSystem.getCache(lambda resID, value: self._response(resID, value, callback))