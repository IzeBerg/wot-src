from skeletons.gui.platform.controller import IPlatformRequestController

class IProductFetchController(IPlatformRequestController):

    def getProducts(self, showWaiting=True):
        raise NotImplementedError


class ISubscriptionsFetchController(IProductFetchController):

    def getProducts(self, showWaiting=True):
        raise NotImplementedError


class IUserSubscriptionsFetchController(IProductFetchController):

    def getProducts(self, showWaiting=True):
        raise NotImplementedError

    def resetFetch(self):
        raise NotImplementedError