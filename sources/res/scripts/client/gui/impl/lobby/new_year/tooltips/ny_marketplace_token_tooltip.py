from frameworks.wulf import ViewSettings, ViewModel
from gui.impl.gen import R
from gui.impl.pub import ViewImpl

class NyMarketplaceTokenTooltip(ViewImpl):
    __slots__ = ()

    def __init__(self):
        settings = ViewSettings(R.views.lobby.new_year.tooltips.NyMarketplaceTokenTooltip())
        settings.model = ViewModel()
        super(NyMarketplaceTokenTooltip, self).__init__(settings)