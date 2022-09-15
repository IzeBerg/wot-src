from battle_royale.gui.impl.dialogs import CurrencyTypeExtended
from gui.impl.dialogs.sub_views.common.single_price import SinglePrice
from gui.impl.gen import R
from gui.impl.gen.view_models.views.dialogs.sub_views.currency_view_model import CurrencySize

class BRSinglePriceFooter(SinglePrice):
    __slots__ = ()
    _LAYOUT_DYN_ACCESSOR = R.views.dialogs.sub_views.footer.BRSinglePriceFooter

    def __init__(self, text, price, size=CurrencySize.SMALL, layoutID=None):
        super(BRSinglePriceFooter, self).__init__(text, price, size, layoutID, CurrencyTypeExtended)