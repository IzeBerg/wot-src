from gui.prb_control.entities.base.pre_queue.vehicles_watcher import BaseVehiclesWatcher
from gui.shared.utils.requesters import REQ_CRITERIA
from helpers import dependency
from skeletons.gui.shared import IItemsCache

class HalloweenVehiclesWatcher(BaseVehiclesWatcher):
    itemsCache = dependency.descriptor(IItemsCache)

    def _getUnsuitableVehicles(self, onClear=False):
        return self.itemsCache.items.getVehicles(REQ_CRITERIA.INVENTORY | ~REQ_CRITERIA.VEHICLE.EVENT_BATTLE).itervalues()