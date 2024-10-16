import typing
from gui.prb_control.entities.base.pre_queue.vehicles_watcher import BaseVehiclesWatcher
from gui.shared.utils.requesters import REQ_CRITERIA
from helpers import dependency
from skeletons.gui.shared import IItemsCache
from halloween.skeletons.halloween_controller import IHalloweenController
from halloween_common.halloween_constants import DEFENCE_FORBIDDEN_VEHICLE_TAGS

class HalloweenVehiclesWatcher(BaseVehiclesWatcher):
    itemsCache = dependency.descriptor(IItemsCache)

    def _getUnsuitableVehicles(self, onClear=False):
        return self.itemsCache.items.getVehicles(REQ_CRITERIA.INVENTORY | ~REQ_CRITERIA.VEHICLE.EVENT_BATTLE).itervalues()


class HalloweenDefenceVehiclesWatcher(BaseVehiclesWatcher):
    itemsCache = dependency.descriptor(IItemsCache)
    hwController = dependency.descriptor(IHalloweenController)

    def _getUnsuitableVehicles(self, onClear=False):
        vehConfig = self.hwController.getDefenceVehiclesConfig()
        criteria = REQ_CRITERIA.INVENTORY | REQ_CRITERIA.VEHICLE.HAS_ANY_TAG(DEFENCE_FORBIDDEN_VEHICLE_TAGS)
        if vehConfig.allowedLevels:
            criteria |= ~REQ_CRITERIA.VEHICLE.LEVELS(vehConfig.allowedLevels)
        if vehConfig.forbiddenClassTags:
            criteria |= REQ_CRITERIA.VEHICLE.CLASSES(vehConfig.forbiddenClassTags)
        if vehConfig.forbiddenVehicles:
            criteria |= REQ_CRITERIA.VEHICLE.SPECIFIC_BY_CD(vehConfig.forbiddenVehicles)
        excludeVehicles = self.itemsCache.items.getVehicles(criteria)
        for intCD in vehConfig.includeVehicles:
            excludeVehicles.pop(intCD, None)

        return excludeVehicles.itervalues()