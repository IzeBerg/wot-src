import typing
from dossiers2.custom.records import RECORDS, RECORD_INDICES
from dossiers2.custom.cache import getCache
from nations import ALL_NATIONS_INDEX
from soft_exception import SoftException

def getTankExpertRequirements(vehTypeFrags, nationID=ALL_NATIONS_INDEX):
    cache = getCache()
    killedVehTypes = set(vehTypeFrags.iterkeys())
    res = {'tankExpert': cache['vehiclesInTrees'] - killedVehTypes}
    if nationID == ALL_NATIONS_INDEX:
        nationIDs = cache['nationsWithVehiclesInTree']
    else:
        nationIDs = [
         nationID]
    vehiclesInTreesByNation = cache['vehiclesInTreesByNation']
    for nationIdx in nationIDs:
        res[('').join(['tankExpert', str(nationIdx)])] = vehiclesInTreesByNation[nationIdx] - killedVehTypes

    return res


def getMechanicEngineerRequirements(defaultUnlocks, unlocks, nationID=ALL_NATIONS_INDEX):
    cache = getCache()
    vehiclesInTreesByNation = cache['vehiclesInTreesByNation']
    res = {'mechanicEngineer': cache['vehiclesInTrees'] - defaultUnlocks - unlocks}
    if nationID == ALL_NATIONS_INDEX:
        nationIDs = cache['nationsWithVehiclesInTree']
    else:
        nationIDs = [
         nationID]
    for nationIdx in nationIDs:
        res[('').join(['mechanicEngineer', str(nationIdx)])] = vehiclesInTreesByNation[nationIdx] - defaultUnlocks - unlocks

    return res


def getVehicleCollectorRequirements(inventoryVehicles, nationID=ALL_NATIONS_INDEX):
    cache = getCache()
    collectorVehicles = getAllCollectorVehicles()
    res = {'collectorVehicle': collectorVehicles - inventoryVehicles}
    collectorVehiclesByNations = cache['collectorVehiclesByNations']
    nationIDs = collectorVehiclesByNations.keys() if nationID == ALL_NATIONS_INDEX else [nationID]
    for nationIdx in nationIDs:
        achievementName = ('').join(['collectorVehicle', str(nationIdx)])
        collectorVehiclesByNation = collectorVehiclesByNations.get(nationIdx, set())
        if collectorVehiclesByNation:
            res[achievementName] = collectorVehiclesByNation - inventoryVehicles

    return res


def getAllCollectorVehicles(nationID=ALL_NATIONS_INDEX):
    cache = getCache()
    collectorVehicles = set()
    collectorVehiclesByNations = cache['collectorVehiclesByNations']
    if nationID == ALL_NATIONS_INDEX:
        for collectorVehiclesInNation in collectorVehiclesByNations.itervalues():
            collectorVehicles.update(collectorVehiclesInNation)

    else:
        collectorVehicles.update(collectorVehiclesByNations.get(nationID, set()))
    return collectorVehicles


def getRecordMaxValue(block, record):
    recordPacking = RECORDS[RECORD_INDICES[(block, record)]]
    if recordPacking[2] == 'b' or recordPacking[2] == 'bs':
        return 1
    return recordPacking[4]


def updateTankExpert(dossierDescr, vehTypeFrags, nationID):
    res = getTankExpertRequirements(vehTypeFrags, nationID)
    for record, value in res.iteritems():
        if len(value) == 0:
            if not dossierDescr['achievements'][record]:
                dossierDescr['achievements'][record] = True
                dossierDescr.addPopUp('achievements', record, True)


def updateMechanicEngineer(dossierDescr, defaultUnlocks, unlocks, nationID):
    res = getMechanicEngineerRequirements(defaultUnlocks, unlocks, nationID)
    for record, value in res.iteritems():
        if len(value) == 0:
            if not dossierDescr['achievements'][record]:
                dossierDescr['achievements'][record] = True
                dossierDescr.addPopUp('achievements', record, True)


def updateVehicleCollector(dossierDescr, inventoryVehicles, nationID):
    res = getVehicleCollectorRequirements(inventoryVehicles, nationID)
    for record, value in res.iteritems():
        if len(value) == 0:
            if not dossierDescr['achievements'][record]:
                dossierDescr['achievements'][record] = True
                dossierDescr.addPopUp('achievements', record, True)


def updateVehicleBoughtListAchievements(dossierDescr, vehDescr):
    if vehDescr.type.isCollectorVehicle or vehDescr.type.isPremium:
        return
    level = vehDescr.level
    if 5 <= level <= 10:
        medalName = ('steamGetTankLevel{0}Medal').format(level)
        if not dossierDescr['steamAchievements'][medalName]:
            dossierDescr['steamAchievements'][medalName] = True


def updateRareAchievements(dossierDescr, achievements):
    block = dossierDescr['rareAchievements']
    for achievement in achievements:
        if achievement > 0:
            block.append(achievement)
        elif achievement < 0:
            try:
                block.remove(abs(achievement))
            except:
                pass