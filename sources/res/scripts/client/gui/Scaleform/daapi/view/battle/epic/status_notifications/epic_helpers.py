from items import vehicles

def getEquipmentById(equipmentId):
    return vehicles.g_cache.equipments()[equipmentId]


def getSmokeDataByPredicate(smokeInfo, teamPredicate, postEffectPredicate):
    if smokeInfo is None or not teamPredicate or not postEffectPredicate:
        return (None, None)
    if teamPredicate(smokeInfo['team']) and postEffectPredicate(smokeInfo['expiring']):
        return (smokeInfo['endTime'], getEquipmentById(smokeInfo['equipmentID']))
    else:
        return (None, None)