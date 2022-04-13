

class IReplayConvertible(object):

    @staticmethod
    def dumpSafe(value):
        raise NotImplementedError

    @staticmethod
    def loadSafe(value):
        raise NotImplementedError