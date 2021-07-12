

class IUILoggingCore(object):

    def init(self):
        raise NotImplementedError

    def fini(self):
        raise NotImplementedError

    def getSettings(self, feature, group):
        raise NotImplementedError

    def log(self, feature, group, action, loglevel, **params):
        raise NotImplementedError

    @property
    def ready(self):
        raise NotImplementedError


class IUILoggingListener(object):

    def fini(self):
        raise NotImplementedError