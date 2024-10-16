import typing
from skeletons.gui.platform.product_purchase_controller import IWotShopPurchaseController
from gui.platform.product_purchase.wot_shop_purchase_controller import WotShopPurchaseController
if typing.TYPE_CHECKING:
    from helpers.dependency import DependencyManager
__all__ = ('getProductPurchaseControllers', )

def getProductPurchaseControllers(manager):
    wotShopController = WotShopPurchaseController()
    manager.addInstance(IWotShopPurchaseController, wotShopController)