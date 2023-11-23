from frameworks.wulf import ViewSettings, ViewModel
from gui.impl.gen import R
from gui.impl.pub import ViewImpl

class NyShopUnavailableTooltip(ViewImpl):
    __slots__ = ()

    def __init__(self):
        settings = ViewSettings(R.views.lobby.new_year.tooltips.NyShopUnavailableTooltip())
        settings.model = ViewModel()
        super(NyShopUnavailableTooltip, self).__init__(settings)