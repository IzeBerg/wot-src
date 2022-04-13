import BigWorld
from items import vehicles
from ModelHitTester import ModelHitStatus

def getWholeVehModels(vDesc):
    nationID, vehicleTypeID = vehicles.g_list.getIDsByName(vDesc.name)
    vType = vehicles.g_cache.vehicle(nationID, vehicleTypeID)
    hitTesters = vDesc.hitTesters
    prereqs = set(vDesc.prerequisites())
    bspModels = set()
    index = 0
    for chassie in vType.chassis:
        prereqs.add(chassie.models.undamaged)
        splinePairs = chassie.splineDesc.trackPairs if chassie.splineDesc else {}
        for splinePairDesc in splinePairs.itervalues():
            if splinePairDesc is not None:
                prereqs.add(splinePairDesc.segmentModelLeft())
                prereqs.add(splinePairDesc.segmentModelRight())
                prereqs.add(splinePairDesc.segment2ModelLeft())
                prereqs.add(splinePairDesc.segment2ModelRight())

        bspModels.add((index, hitTesters.chassis.bspModelName))
        index += 1

    for hull in vType.hulls:
        prereqs.add(hull.models.undamaged)
        bspModels.add((index, hitTesters.hull.bspModelName))
        index += 1

    for turrets in vType.turrets:
        for turret in turrets:
            prereqs.add(turret.models.undamaged)
            bspModels.add((index, hitTesters.turret.bspModelName))
            index += 1
            for gun in turret.guns:
                prereqs.add(gun.models.undamaged)
                bspModels.add((index, hitTesters.gun.bspModelName))
                index += 1

    prereqs.add(BigWorld.CollisionAssembler(tuple(bspModels), BigWorld.player().spaceID))
    return list(prereqs)