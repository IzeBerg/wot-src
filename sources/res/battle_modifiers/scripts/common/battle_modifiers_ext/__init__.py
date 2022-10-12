import battle_params, battle_modifiers, vehicle_modifications

def init():
    battle_params.init()
    battle_modifiers.init()
    vehicle_modifications.init()


def getGlobalModifiers():
    return battle_modifiers.g_cache


def getModificationCache():
    return vehicle_modifications.g_cache