from frameworks.wulf import ViewSettings
from battle_royale.gui.impl.gen.view_models.views.lobby.tooltips.proxy_currency_tooltip_view_model import ProxyCurrencyTooltipViewModel
from gui.impl.pub import ViewImpl
from gui.impl.gen import R

class ProxyCurrencyTooltipView(ViewImpl):
    __slots__ = ()

    def __init__(self):
        settings = ViewSettings(R.views.battle_royale.lobby.tooltips.ProxyCurrencyTooltipView())
        settings.model = ProxyCurrencyTooltipViewModel()
        super(ProxyCurrencyTooltipView, self).__init__(settings)

    @property
    def viewModel(self):
        return super(ProxyCurrencyTooltipView, self).getViewModel()