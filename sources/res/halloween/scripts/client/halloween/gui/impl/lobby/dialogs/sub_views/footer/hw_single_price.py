from frameworks.wulf import ViewSettings
from gui.impl.dialogs.dialog_template_utils import toString
from gui.impl.gen import R
from gui.impl.gen.view_models.views.dialogs.sub_views.hw_single_price_view_model import HwSinglePriceViewModel
from gui.impl.pub import ViewImpl
from halloween.gui.impl.lobby.tooltips.key_tooltip import KeyTooltipView

class HWSinglePrice(ViewImpl):
    __slots__ = ('_text', '_price')
    _LAYOUT_DYN_ACCESSOR = R.views.dialogs.sub_views.footer.HWSinglePrice

    def __init__(self, text, price, layoutID=None):
        settings = ViewSettings(layoutID or self._LAYOUT_DYN_ACCESSOR())
        settings.model = HwSinglePriceViewModel()
        super(HWSinglePrice, self).__init__(settings)
        self._text = text
        self._price = price

    @property
    def viewModel(self):
        return self.getViewModel()

    def updatePrice(self, newPrice):
        self._price = newPrice
        self.__updateViewModel()

    def setText(self, newText):
        self._text = newText
        self.__updateViewModel()

    def createToolTipContent(self, event, contentID):
        if contentID == R.views.halloween.lobby.tooltips.KeyTooltip():
            return KeyTooltipView(isPostBattle=False)
        return super(HWSinglePrice, self).createToolTipContent(event, contentID)

    def _onLoading(self, *args, **kwargs):
        super(HWSinglePrice, self)._onLoading(*args, **kwargs)
        self.__updateViewModel()

    def __updateViewModel(self):
        with self.viewModel.transaction() as (vm):
            vm.setText(toString(self._text))
            vm.setPrice(self._price)