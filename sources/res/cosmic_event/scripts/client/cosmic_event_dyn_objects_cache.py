import BigWorld, CGF, cosmic_prefabs
from dyn_objects_cache import DynObjectsBase, _PointsOfInterestConfig
from vehicle_systems.stricted_loading import makeCallbackWeak

class CosmicEventDynObjects(DynObjectsBase):

    def __init__(self):
        super(CosmicEventDynObjects, self).__init__()
        self.__pointsOfInterestConfig = None
        self.__cosmicShields = None
        self.__cachedPrefabs = set()
        self.__resourcesCache = None
        self.lootPrefabs = {}
        return

    def init(self, dataSection):
        super(CosmicEventDynObjects, self).init(dataSection)
        self.__pointsOfInterestConfig = _PointsOfInterestConfig({})
        self.__cachedPrefabs.update(set(self.__pointsOfInterestConfig.getPrefabs()))
        self._collectLootPrefabs()
        self._collectVehiclePrefabs()
        self._collectFragmentPrefabs()
        self._collectOtherPrefabs()
        BigWorld.loadResourceListBG(list(self.__cachedPrefabs), makeCallbackWeak(self.__onResourcesLoaded))
        CGF.cacheGameObjects(list(self.__cachedPrefabs), False)

    def clear(self):
        self.__pointsOfInterestConfig = None
        if self.__cachedPrefabs:
            CGF.clearGameObjectsCache(list(self.__cachedPrefabs))
            self.__cachedPrefabs.clear()
        super(CosmicEventDynObjects, self).clear()
        return

    def destroy(self):
        self.__resourcesCache = None
        super(CosmicEventDynObjects, self).destroy()
        return

    def getPointOfInterestConfig(self):
        return self.__pointsOfInterestConfig

    def __onResourcesLoaded(self, resourceRefs):
        self.__resourcesCache = resourceRefs

    def _collectLootPrefabs(self):
        prefabs = cosmic_prefabs.Loot.RANGE_LOOT
        self.__cachedPrefabs.update(prefabs)

    def _collectVehiclePrefabs(self):
        prefabs = cosmic_prefabs.Vehicle.RANGE
        self.__cachedPrefabs.update(prefabs)

    def _collectFragmentPrefabs(self):
        prefabs = cosmic_prefabs.Fragment.RANGE
        self.__cachedPrefabs.update(prefabs)

    def _collectOtherPrefabs(self):
        prefabs = ('content/CGFPrefabs/cosmic_event/cosmic_event_artifact_evacuation.prefab',
                   'content/CGFPrefabs/cosmic_event/cosmic_event_delivery_zone.prefab',
                   'content/CGFPrefabs/cosmic_event/cosmic_event_evacuation_zone.prefab',
                   'content/CGFPrefabs/cosmic_event/cosmic_event_fragment.prefab',
                   'content/CGFPrefabs/cosmic_event/cosmic_event_fragment_delivery_hologram.prefab',
                   'content/CGFPrefabs/cosmic_event/cosmic_event_fragment_hint.prefab',
                   'content/CGFPrefabs/cosmic_event/cosmic_event_fragment_hologram.prefab',
                   'content/CGFPrefabs/cosmic_event/cosmic_event_jump.prefab', 'content/CGFPrefabs/cosmic_event/cosmic_event_mine_explosion.prefab',
                   'content/CGFPrefabs/cosmic_event/cosmic_event_mine_spawn.prefab',
                   'content/CGFPrefabs/cosmic_event/cosmic_event_passive_shield_shockwave.prefab',
                   'content/CGFPrefabs/cosmic_event/cosmic_event_pickup_block.prefab',
                   'content/CGFPrefabs/cosmic_event/cosmic_event_pickup_jump_disappearing.prefab',
                   'content/CGFPrefabs/cosmic_event/cosmic_event_pickup_jump_spawn.prefab',
                   'content/CGFPrefabs/cosmic_event/cosmic_event_pickup_mine_disappearing.prefab',
                   'content/CGFPrefabs/cosmic_event/cosmic_event_pickup_mine_spawn.prefab',
                   'content/CGFPrefabs/cosmic_event/cosmic_event_pickup_repulsor_disappearing.prefab',
                   'content/CGFPrefabs/cosmic_event/cosmic_event_pickup_repulsor_spawn.prefab',
                   'content/CGFPrefabs/cosmic_event/cosmic_event_pickup_vortex_disappearing.prefab',
                   'content/CGFPrefabs/cosmic_event/cosmic_event_pickup_vortex_spawn.prefab',
                   'content/CGFPrefabs/cosmic_event/cosmic_event_planet.prefab',
                   'content/CGFPrefabs/cosmic_event/cosmic_event_repulsor.prefab',
                   'content/CGFPrefabs/cosmic_event/cosmic_event_repulsor_hint.prefab',
                   'content/CGFPrefabs/cosmic_event/cosmic_event_respawn_protection_02.prefab',
                   'content/CGFPrefabs/cosmic_event/cosmic_event_shield_transponter.prefab',
                   'content/CGFPrefabs/cosmic_event/cosmic_event_transponter_evac.prefab',
                   'content/CGFPrefabs/cosmic_event/cosmic_event_vehicle_lights.prefab',
                   'content/CGFPrefabs/cosmic_event/cosmic_event_vortex.prefab',
                   'content/CGFPrefabs/cosmic_event/cosmic_event_vortex_hint.prefab',
                   'content/CGFPrefabs/cosmic_event/cosmic_hangar_start_point_camera.prefab')
        self.__cachedPrefabs.update(prefabs)