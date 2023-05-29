

class IBaseProvider(object):

    def start(self):
        raise NotImplementedError

    def stop(self, withClear=False):
        raise NotImplementedError