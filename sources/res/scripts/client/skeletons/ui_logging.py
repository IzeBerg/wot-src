

class IUILoggingCore(object):

    def init(self):
        raise NotImplementedError

    def fini(self):
        raise NotImplementedError

    def isFeatureEnabled(self, feature):
        raise NotImplementedError

    def log(self, feature, group, action, loglevel, **params):
        raise NotImplementedError


class IUILoggingListener(object):

    def fini(self):
        raise NotImplementedError