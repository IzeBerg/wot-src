from collections import namedtuple
HWGameplayAction = namedtuple('HWGameplayAction', ('value', 'targetID', 'id'))

class HWGameplayActionID(object):
    UNKNOWN = 0
    VEHICLE_REPAIR_INCOMING = 1
    VEHICLE_REPAIR_OUTCOMING = 2
    MODULES_DAMAGE_BLOCKED = 3
    HEALTH_DRAINED_BY_PASSIVE_VAMPIRE = 4
    SHELLS_LOOT_PICKUP = 5


def packGameplayActionFeedback(action):
    return (int(action.targetID) & 65535) << 24 | (int(action.value) & 4095) << 12 | action.id & 255


def unpackGameplayActionFeedback(packedData):
    return HWGameplayAction(targetID=packedData >> 24 & 65535, value=packedData >> 12 & 4095, id=packedData & 255)