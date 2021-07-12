from controller import PurchaseCache
from skeletons.gui.cdn import IPurchaseCache
__all__ = ('getPurchaseCache', )

def getPurchaseCache(manager):
    controller = PurchaseCache()
    controller.init()
    manager.addInstance(IPurchaseCache, controller, finalizer='fini')