import enum
ENEMY_VEHICLE_ID = -1
INVALID_TIMESTAMP = -1
POI_EQUIPMENT_TAG = 'poiEquipment'

@enum.unique
class PoiType(enum.IntEnum):
    ARTILLERY = 1
    RECON = 2


@enum.unique
class PoiStatus(enum.IntEnum):
    ACTIVE = 1
    CAPTURING = 2
    COOLDOWN = 3


@enum.unique
class PoiBlockReasons(enum.IntEnum):
    DAMAGE = 1
    EQUIPMENT = 2


PoiEquipmentNamesByPoiType = {PoiType.ARTILLERY: 'poi_artillery_aoe', 
   PoiType.RECON: 'poi_radar'}
PoiTypesByPoiEquipmentName = {name:poiType for poiType, name in PoiEquipmentNamesByPoiType.iteritems()}