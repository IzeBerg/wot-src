import adisp

class IPurchaseCache(object):

    def init(self):
        raise NotImplementedError

    def fini(self):
        raise NotImplementedError

    @adisp.async
    def requestPurchaseByID(self, pId, callback=None):
        pass

    def getCachedPurchase(self, pId):
        return

    def getProductCode(self, pId):
        return

    def canBeRequestedFromProduct(self, data):
        return False