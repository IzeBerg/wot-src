import typing, BigWorld
from items import vehicles
from points_of_interest_shared import PoiEquipmentNamesByPoiType, PoiTypesByPoiEquipmentName
if typing.TYPE_CHECKING:
    from items.artefacts import Equipment
    from points_of_interest.components import PoiStateComponent

def getPoiCooldownProgress(poiState):
    status = poiState.status
    duration = status.endTime - status.startTime
    progress = (BigWorld.serverTime() - status.startTime) / duration * 100
    return progress


def getPoiEquipmentByType(poiType):
    cache = vehicles.g_cache
    name = PoiEquipmentNamesByPoiType[poiType]
    equipmentID = cache.equipmentIDs().get(name)
    if equipmentID is not None:
        return cache.equipments()[equipmentID]
    else:
        return


def getPoiTypeByEquipment(equipment):
    return PoiTypesByPoiEquipmentName.get(equipment.name, None)