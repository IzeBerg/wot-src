from constants import IS_CLIENT
if IS_CLIENT:
    import BattleReplay

class PlanTags(object):

    def __init__(self):
        self._tags = {'Load.NotInReplay': PlanTags.__notInReplay}

    @staticmethod
    def __notInReplay():
        if IS_CLIENT:
            return not BattleReplay.isPlaying()
        return False

    def tagsAll(self):
        return list(self._tags.keys())

    def tags(self):
        return [ tag for tag, func in self._tags.iteritems() if func() ]