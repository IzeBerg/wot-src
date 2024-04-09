

class IMapActivities(object):
    __slots__ = ()

    def start(self, name, targetTime):
        raise NotImplementedError

    def stop(self):
        raise NotImplementedError

    def generateOfflineActivities(self, spacePath, usePossibility=True):
        raise NotImplementedError

    def setPauseVisuals(self, isPause):
        raise NotImplementedError