

class HWGameplayActionID(object):
    VEHICLE_REPAIR = 0
    VEHICLE_HEALTH_RESTORE = 1


def packGameplayActionFeedback(vehID, effectValue, actionID):
    return (int(vehID) & 65535) << 24 | (int(effectValue) & 4095) << 12 | actionID & 255


def unpackGameplayActionFeedback(packedData):
    return (
     packedData >> 24 & 65535, packedData >> 12 & 4095, packedData & 255)