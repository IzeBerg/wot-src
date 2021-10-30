from constants import ARENA_BONUS_TYPE, ARENA_BONUS_MASK
from arena_bonus_type_caps import ARENA_BONUS_TYPE_CAPS
from collections import namedtuple
from collections import Counter
_DevBonusTypeDefinition = namedtuple('_DevBonusTypeDefinition', ('name', 'bonusType',
                                                                 'caps'))
_DEV_BONUS_TYPE_DEFS = ()

def initDevBonusTypes():
    __validateDevBonusTypeDefinitions()
    for name, bonusType, caps in _DEV_BONUS_TYPE_DEFS:
        setattr(ARENA_BONUS_TYPE, name, bonusType)
        setattr(ARENA_BONUS_TYPE_CAPS, name, caps)
        ARENA_BONUS_TYPE.RANGE = ARENA_BONUS_TYPE.RANGE + (bonusType,)
        ARENA_BONUS_TYPE_CAPS._typeToCaps[bonusType] = caps

    ARENA_BONUS_MASK.TYPE_BITS = dict((name, 2 ** bonusType) for bonusType, name in enumerate(ARENA_BONUS_TYPE.RANGE[1:]))


def __validateDevBonusTypeDefinitions():
    names = [ definition.name for definition in _DEV_BONUS_TYPE_DEFS ]
    bonusTypes = [ definition.bonusType for definition in _DEV_BONUS_TYPE_DEFS ]