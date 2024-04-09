from vehicle_systems.tankStructure import TankPartNames

def _getVisibleGunLength(appearance):
    maxBounds = appearance.collisions.getBoundingBox(TankPartNames.getIdx(TankPartNames.GUN))[1]
    return maxBounds[2]


def getEffectSuffixForGunLength(rangeMap, appearance):
    length = _getVisibleGunLength(appearance)
    for name, (low, high) in rangeMap.iteritems():
        if low < length <= high:
            return name