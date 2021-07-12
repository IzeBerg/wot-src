

class IPromoLogger(object):

    def logAction(self, **kwargs):
        raise NotImplementedError

    def logTeaserAction(self, teaserData, **kwargs):
        raise NotImplementedError

    def getLoggingFuture(self, teaserData=None, **kwargs):
        raise NotImplementedError

    def fini(self):
        raise NotImplementedError