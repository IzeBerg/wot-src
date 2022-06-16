import typing, BigWorld
from adisp import async
from gui.resource_well.resource_well_constants import RESOURCE_WELL_PDATA_KEY
from gui.shared.utils.requesters.abstract import AbstractSyncDataRequester
from skeletons.gui.shared.utils.requesters import IResourceWellRequester
if typing.TYPE_CHECKING:
    from typing import Dict

class ResourceWellRequester(AbstractSyncDataRequester, IResourceWellRequester):

    def getCurrentPoints(self):
        return self.getCacheValue('points', 0)

    def getBalance(self):
        return self.getCacheValue('balance', {})

    def getReward(self):
        return self.getCacheValue('reward', None)

    def _preprocessValidData(self, data):
        return dict(data.get(RESOURCE_WELL_PDATA_KEY, {}))

    @async
    def _requestCache(self, callback):
        BigWorld.player().resourceWell.getCache(lambda resID, value: self._response(resID, value, callback))