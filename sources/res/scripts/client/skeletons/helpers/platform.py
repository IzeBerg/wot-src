import typing
if typing.TYPE_CHECKING:
    from Event import Event

class IPublishPlatform(object):
    onPayment = None
    onOverlay = None

    def init(self):
        raise NotImplementedError

    def fini(self):
        raise NotImplementedError

    def isInited(self):
        raise NotImplementedError

    def isConnected(self):
        raise NotImplementedError