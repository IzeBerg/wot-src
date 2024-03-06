from frameworks.wulf import ViewFlags
from gui.Scaleform.daapi.view.meta.ShopSalesEntryPointMeta import ShopSalesEntryPointMeta
from gui.impl.lobby.shop_sales.shop_sales_entry_point_view import ShopSalesEntryPointView

class ShopSalesEntryPoint(ShopSalesEntryPointMeta):

    def _makeInjectView(self):
        self.__view = ShopSalesEntryPointView(ViewFlags.VIEW)
        return self.__view