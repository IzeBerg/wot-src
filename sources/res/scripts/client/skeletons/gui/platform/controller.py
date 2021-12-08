

class IPlatformRequestController(object):

    def init(self):
        raise NotImplementedError

    def fini(self):
        raise NotImplementedError