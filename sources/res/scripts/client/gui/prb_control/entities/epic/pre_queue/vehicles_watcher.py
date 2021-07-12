from itertools import chain
from constants import MAX_VEHICLE_LEVEL, MIN_VEHICLE_LEVEL
from gui.prb_control.entities.base.pre_queue.vehicles_watcher import BaseVehiclesWatcher
from gui.shared.gui_items.Vehicle import Vehicle
from gui.shared.utils.requesters import REQ_CRITERIA
from skeletons.gui.lobby_context import ILobbyContext
from skeletons.gui.shared import IItemsCache
from helpers import dependency

class EpicVehiclesWatcher(BaseVehiclesWatcher):
    itemsCache = dependency.descriptor(IItemsCache)
    lobbyContext = dependency.descriptor(ILobbyContext)

    def _getUnsuitableVehicles(self, onClear=False):
        config = self.lobbyContext.getServerSettings().epicBattles
        vehLevels = list(set(range(MIN_VEHICLE_LEVEL, MAX_VEHICLE_LEVEL + 1)) - set(config.validVehicleLevels))
        vehs = self.itemsCache.items.getVehicles(REQ_CRITERIA.INVENTORY | REQ_CRITERIA.VEHICLE.LEVELS(vehLevels)).itervalues()
        eventVehs = self.itemsCache.items.getVehicles(REQ_CRITERIA.INVENTORY | REQ_CRITERIA.VEHICLE.EVENT_BATTLE).itervalues()
        return chain(vehs, eventVehs)