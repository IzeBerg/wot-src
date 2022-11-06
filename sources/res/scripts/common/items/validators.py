from items import ITEM_TYPES, EQUIPMENT_TYPES, vehicles

def isBattleBooster(compDescr):
    itemTypeIdx, _, eqID = vehicles.parseIntCompactDescr(compDescr)
    if itemTypeIdx == ITEM_TYPES.equipment:
        equipment = vehicles.g_cache.equipments().get(eqID)
        if equipment and equipment.equipmentType == EQUIPMENT_TYPES.battleBoosters:
            return True
    return False