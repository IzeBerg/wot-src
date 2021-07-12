from Event import Event
from skeletons.gui.shared.utils import IItemsRequester, requesters

class IItemsCache(requesters.IRequester):
    onSyncStarted = None
    onSyncCompleted = None

    @property
    def waitForSync(self):
        raise NotImplementedError

    @property
    def items(self):
        raise NotImplementedError

    @property
    def compatVehiclesCache(self):
        raise NotImplementedError

    def init(self):
        raise NotImplementedError

    def fini(self):
        raise NotImplementedError

    def update(self, updateReason, diff=None, notify=True, callback=None):
        raise NotImplementedError

    def onDisconnected(self):
        raise NotImplementedError