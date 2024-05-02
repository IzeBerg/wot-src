

class Vehicle(object):
    COLLISION_EFFECT = 'content/CGFPrefabs/cosmic_event/cosmic_event_collision_effect.prefab'
    RAMMING_FIELD = 'content/CGFPrefabs/cosmic_event/cosmic_event_ramming_field.prefab'
    SPAWN_EFFECT = 'content/CGFPrefabs/cosmic_event/cosmic_event_transponter_respawn.prefab'
    DESPAWN_EFFECT = 'content/CGFPrefabs/cosmic_event/cosmic_event_transponter_death.prefab'
    ELECTRICITY_EFFECT = 'content/CGFPrefabs/cosmic_event/cosmic_event_vehicle_evacuation_electricity.prefab'
    RANGE = (
     COLLISION_EFFECT, RAMMING_FIELD, SPAWN_EFFECT, DESPAWN_EFFECT, ELECTRICITY_EFFECT)


class Loot(object):
    COSMIC_VORTEX = 'content/CGFPrefabs/cosmic_event/cosmic_event_pickup_vortex.prefab'
    COSMIC_REPULSOR = 'content/CGFPrefabs/cosmic_event/cosmic_event_pickup_repulsor.prefab'
    COSMIC_JUMP = 'content/CGFPrefabs/cosmic_event/cosmic_event_pickup_jump.prefab'
    COSMIC_MINES = 'content/CGFPrefabs/cosmic_event/cosmic_event_pickup_mine.prefab'
    UNKNOWN = 'content/CGFPrefabs/cosmic_event/cosmic_event_pickup_hint.prefab'
    RANGE_LOOT = (
     COSMIC_VORTEX,
     COSMIC_REPULSOR,
     COSMIC_JUMP,
     COSMIC_MINES,
     UNKNOWN)


class Fragment(object):
    FRAGMENT_DELIVERED = 'content/CGFPrefabs/cosmic_event/cosmic_event_fragment_delivery_effect.prefab'
    RANGE = (
     FRAGMENT_DELIVERED,)