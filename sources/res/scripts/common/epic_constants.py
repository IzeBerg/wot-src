from constants import IS_CLIENT

class EPIC_BATTLE_TEAM_ID(object):
    TEAM_ATTACKER = 1
    TEAM_DEFENDER = 2


if IS_CLIENT:
    from shared_utils import CONST_CONTAINER

    class SECTOR_EDGE_STATE(CONST_CONTAINER):
        NONE = 0
        SAFE = 1
        DANGER = 2