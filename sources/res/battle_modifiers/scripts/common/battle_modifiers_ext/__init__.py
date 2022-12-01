import battle_params, remappings_cache, vehicle_modifications

def init():
    battle_params.init()
    remappings_cache.init()
    vehicle_modifications.init()


def getModificationCache():
    return vehicle_modifications.g_cache