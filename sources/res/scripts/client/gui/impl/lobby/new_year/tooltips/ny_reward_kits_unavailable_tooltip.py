from frameworks.wulf import ViewSettings, ViewModel
from gui.impl.gen import R
from gui.impl.pub import ViewImpl

class NyRewardKitsUnavailableTooltip(ViewImpl):
    __slots__ = ()

    def __init__(self):
        settings = ViewSettings(R.views.lobby.new_year.tooltips.NyRewardKitsUnavailableTooltip())
        settings.model = ViewModel()
        super(NyRewardKitsUnavailableTooltip, self).__init__(settings)