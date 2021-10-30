from constants import IS_CLIENT, IS_DEVELOPMENT
from arena_bonus_type_caps import ARENA_BONUS_TYPE_CAPS as BONUS_CAPS, ALLOWED_ARENA_BONUS_TYPE_CAPS
if IS_CLIENT:
    import BattleReplay

def bonusCapToTag(cap):
    return 'Load.BonusCaps.' + cap


def notInReplay():
    if IS_CLIENT:
        return not BattleReplay.isPlaying()
    return False


class PlanTags(object):
    _tags = {'Load.NotInReplay': notInReplay, 
       'Load.Development': lambda : IS_DEVELOPMENT}

    def __init__(self, arenaBonusType=0):
        self._tagsList = [ tag for tag, func in PlanTags._tags.iteritems() if func() ]
        if arenaBonusType != 0:
            self._tagsList.extend(bonusCapToTag(cap) for cap in BONUS_CAPS.get(arenaBonusType))

    @property
    def tags(self):
        return self._tagsList


def getAllTags():
    tagsAll = PlanTags._tags.keys()
    tagsAll.extend(bonusCapToTag(cap) for cap in ALLOWED_ARENA_BONUS_TYPE_CAPS)
    return tagsAll