from enum import Enum

class VehicleCharacteristics(Enum):
    PROS = 'pros'
    CONS = 'cons'


class BonusGroup(object):
    STYLE_3D = 'style3d'
    VEHICLES = 2
    LOOTBOX = 'lootbox'
    OTHER = 'other'
    HIGH = 0
    AVERAGE = 1
    LOW = 2
    RENT = 3


def getBonusGroup(num):
    if num == 0:
        return BonusGroup.HIGH
    if num == 1:
        return BonusGroup.AVERAGE
    if num == 2:
        return BonusGroup.LOW
    if num == 3:
        return BonusGroup.RENT