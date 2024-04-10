

class IBattleDynamicObjectsCache(object):

    def getConfig(self, arenaType):
        raise NotImplementedError

    def getFeaturesConfig(self, feature):
        raise NotImplementedError

    def load(self, arenaType):
        raise NotImplementedError

    def unload(self, arenaType):
        raise NotImplementedError