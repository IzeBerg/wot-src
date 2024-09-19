from enum import Enum

class VehicleCharacteristics(Enum):
    PROS = 'pros'
    CONS = 'cons'


class BonusGroup(object):
    STYLE_3D = 'style3d'
    VEHICLES = 3
    LOOTBOX = 'lootbox'
    OTHER = 'other'
    GUARANTEED = 0
    HIGH = 1
    AVERAGE = 2
    LOW = 3
    RENT = 4


def getBonusGroup(num):
    if num == 0:
        return BonusGroup.GUARANTEED
    if num == 1:
        return BonusGroup.HIGH
    if num == 2:
        return BonusGroup.AVERAGE
    if num == 3:
        return BonusGroup.LOW
    if num == 4:
        return BonusGroup.RENT


class WtState(object):
    UNDEFINED = 0
    BEFORE_SEASON = 1
    BETWEEN_SEASONS = 2
    AFTER_SEASON = 3
    AVAILABLE = 5
    FROZEN = 6
    SINGLE_FROZEN = 7
    NOT_AVAILABLE = 8
    NOT_AVAILABLE_END = 9