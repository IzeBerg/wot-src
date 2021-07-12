import logging, BigWorld
from gui.battle_control.controllers.appearance_cache_ctrls.default_appearance_cache_ctrl import DefaultAppearanceCacheController
from helpers import uniprof
from items.vehicles import VehicleDescriptor
from vehicle_outfit.outfit import Outfit
from vehicle_systems import model_assembler
from vehicle_systems.camouflages import getOutfitComponent
_logger = logging.getLogger(__name__)

class EventAppearanceCacheController(DefaultAppearanceCacheController):

    def __init__(self, setup):
        super(EventAppearanceCacheController, self).__init__(setup)
        self.__spawnList = set()

    def startControl(self, battleCtx, arenaVisitor):
        super(EventAppearanceCacheController, self).startControl(battleCtx, arenaVisitor)
        self.__spawnList = set()

    def stopControl(self):
        super(EventAppearanceCacheController, self).stopControl()
        self.__spawnList = set()

    def _addListeners(self):
        avatar = BigWorld.player()
        if hasattr(avatar, 'onSpawnListUpdated'):
            avatar.onSpawnListUpdated += self.updateSpawnList

    def _removeListeners(self):
        avatar = BigWorld.player()
        if hasattr(avatar, 'onSpawnListUpdated'):
            avatar.onSpawnListUpdated -= self.updateSpawnList

    @uniprof.regionDecorator(label='EventAppearanceCacheController.updateSpawnList', scope='wrap')
    def updateSpawnList(self, spawnListData):
        toAdd = spawnListData.difference(self.__spawnList)
        toRemove = self.__spawnList.difference(spawnListData)
        for data in toAdd:
            vDesc = VehicleDescriptor(compactDescr=data.vehicleCD)
            prereqs = set()
            prereqs.add(vDesc.prerequisites())
            outfit = Outfit(component=getOutfitComponent(data.outfitCD), vehicleCD=data.vehicleCD)
            modelsSetParams = outfit.modelsSet
            compoundAssembler = model_assembler.prepareCompoundAssembler(vDesc, modelsSetParams, BigWorld.camera().spaceID)
            prereqs.add(compoundAssembler)
            self._appearanceCache.loadResources(data.vehicleCD, list(prereqs))

        for data in toRemove:
            self._appearanceCache.unloadResources(data.vehicleCD)

        self.__spawnList = spawnListData
        _logger.debug('SpawnList cache updated=%s', spawnListData)