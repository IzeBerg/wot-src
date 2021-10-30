from items import vehicles
__author__ = 'a_jorov'

def getKamikazeEquipmentDescr():
    return vehicles.g_cache.equipments()[vehicles.g_cache.equipmentIDs()['spawn_kamikaze']]