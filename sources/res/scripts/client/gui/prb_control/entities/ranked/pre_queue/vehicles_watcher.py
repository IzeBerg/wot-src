import typing
from itertools import chain
from constants import MAX_VEHICLE_LEVEL, MIN_VEHICLE_LEVEL
from gui.prb_control.entities.base.pre_queue.vehicles_watcher import RestrictedVehiclesWatcher
from gui.shared.utils.requesters import REQ_CRITERIA
from skeletons.gui.lobby_context import ILobbyContext
from skeletons.gui.shared import IItemsCache
from helpers import dependency, server_settings
if typing.TYPE_CHECKING:
    from gui.shared.gui_items.Vehicle import Vehicle

class RankedVehiclesWatcher(RestrictedVehiclesWatcher):
    __itemsCache = dependency.descriptor(IItemsCache)
    __lobbyContext = dependency.descriptor(ILobbyContext)

    def start(self):
        super(RankedVehiclesWatcher, self).start()
        self.__lobbyContext.getServerSettings().onServerSettingsChange += self.__onServerSettingsChanged

    def stop(self):
        self.__lobbyContext.getServerSettings().onServerSettingsChange -= self.__onServerSettingsChanged
        super(RankedVehiclesWatcher, self).stop()

    def _getUnsuitableVehicles(self, onClear=False):
        allVehs = self.__itemsCache.items.getVehicles(REQ_CRITERIA.INVENTORY).itervalues()
        config = self.__lobbyContext.getServerSettings().rankedBattles
        vehLevels = range(MIN_VEHICLE_LEVEL, config.minLevel) + range(config.maxLevel + 1, MAX_VEHICLE_LEVEL + 1)
        baseVehs = super(RankedVehiclesWatcher, self)._getUnsuitableVehicles(onClear)
        vehs = self.__itemsCache.items.getVehicles(REQ_CRITERIA.INVENTORY | REQ_CRITERIA.VEHICLE.LEVELS(vehLevels)).itervalues()
        if not onClear:
            return chain(vehs, baseVehs, self._getUnsuitableVehiclesBase())
        return allVehs

    def _getForbiddenVehicleClasses(self):
        return self.__lobbyContext.getServerSettings().rankedBattles.forbiddenClassTags

    def _getForbiddenVehicleTypes(self):
        return self.__lobbyContext.getServerSettings().rankedBattles.forbiddenVehTypes

    @server_settings.serverSettingsChangeListener('ranked_config')
    def __onServerSettingsChanged(self, diff):
        self._update()