from frameworks.wulf import ViewSettings, ViewModel
from gui.impl.gen import R
from gui.impl.pub import ViewImpl

class NyRewardKitGuestCTooltip(ViewImpl):
    __slots__ = ()

    def __init__(self):
        settings = ViewSettings(R.views.lobby.new_year.tooltips.NyRewardKitGuestCTooltip())
        settings.model = ViewModel()
        super(NyRewardKitGuestCTooltip, self).__init__(settings)