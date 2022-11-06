

class IFestivityFactory(object):

    def getRequester(self):
        raise NotImplementedError

    def getProcessor(self):
        raise NotImplementedError

    def getController(self):
        raise NotImplementedError