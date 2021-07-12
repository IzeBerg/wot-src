

class INovelty(object):
    onUpdated = None

    def init(self):
        raise NotImplementedError

    def fini(self):
        raise NotImplementedError

    @property
    def showNovelty(self):
        raise NotImplementedError

    @property
    def noveltyCount(self):
        raise NotImplementedError

    def setAsSeen(self):
        raise NotImplementedError