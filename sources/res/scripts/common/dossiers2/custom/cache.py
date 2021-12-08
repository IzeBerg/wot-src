import nations
from items import vehicles
from collector_vehicle import CollectorVehicleConsts

def getCache():
    global _g_cache
    return _g_cache


def buildCache():
    vehiclesByLevel = {}
    vehiclesByTag = {'beast': set(), 'sinai': set(), 'patton': set()}
    vehiclesInTreeByNation = {}
    vehiclesInTree = set()
    nationsWithVehiclesInTree = []
    collectorVehiclesByNations = {}
    collectorVehiclesLevelsByNations = {}
    unlocksSources = vehicles.getUnlocksSources()
    for nationIdx in xrange(len(nations.NAMES)):
        nationList = vehicles.g_list.getList(nationIdx)
        vehiclesInNationTree = set()
        for vehDescr in nationList.itervalues():
            if 'bob' in vehDescr.tags:
                continue
            else:
                if 'battle_royale' in vehDescr.tags:
                    continue
                elif 'maps_training' in vehDescr.tags:
                    continue
                vehiclesByLevel.setdefault(vehDescr.level, set()).add(vehDescr.compactDescr)
                for tag in ('beast', 'sinai', 'patton'):
                    if tag in vehDescr.tags:
                        vehiclesByTag[tag].add(vehDescr.compactDescr)

            if CollectorVehicleConsts.COLLECTOR_VEHICLES_TAG in vehDescr.tags:
                collectorVehiclesByNations.setdefault(nationIdx, set()).add(vehDescr.compactDescr)
                collectorVehiclesLevelsByNations.setdefault(nationIdx, set()).add(vehDescr.level)
                continue
            if len(unlocksSources.get(vehDescr.compactDescr, set())) > 0 or len(vehicles.g_cache.vehicle(nationIdx, vehDescr.id).unlocksDescrs) > 0:
                vehiclesInNationTree.add(vehDescr.compactDescr)

        vehiclesInTree.update(vehiclesInNationTree)
        vehiclesInTreeByNation[nationIdx] = vehiclesInNationTree
        if bool(vehiclesInNationTree):
            nationsWithVehiclesInTree.append(nationIdx)

    vehicles8p = vehiclesByLevel[8] | vehiclesByLevel[9] | vehiclesByLevel[10]
    _g_cache.update({'vehiclesByLevel': vehiclesByLevel, 
       'vehicles8+': vehicles8p, 
       'vehiclesInTreesWithout1Lvl': vehiclesInTree - vehiclesByLevel[1], 
       'vehiclesByTag': vehiclesByTag, 
       'mausTypeCompDescr': vehicles.makeVehicleTypeCompDescrByName('germany:G42_Maus'), 
       'vehiclesInTreesByNation': vehiclesInTreeByNation, 
       'vehiclesInTrees': vehiclesInTree, 
       'nationsWithVehiclesInTree': nationsWithVehiclesInTree, 
       'collectorVehiclesByNations': collectorVehiclesByNations, 
       'collectorVehiclesLevelsByNations': collectorVehiclesLevelsByNations})


_g_cache = {}