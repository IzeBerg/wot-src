

class IPlatformWebApi(object):

    def getType(self):
        raise NotImplementedError

    def isInited(self):
        raise NotImplementedError

    def isConnected(self):
        raise NotImplementedError