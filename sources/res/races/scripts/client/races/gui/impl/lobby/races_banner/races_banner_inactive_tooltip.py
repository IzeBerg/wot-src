from frameworks.wulf import ViewSettings, ViewFlags, ViewModel
from gui.impl.gen import R
from gui.impl.pub import ViewImpl

class RacesBannerInactiveTooltip(ViewImpl):

    def __init__(self):
        settings = ViewSettings(R.views.races.lobby.tooltips.RacesBannerInactiveTooltipView(), ViewFlags.VIEW, ViewModel())
        super(RacesBannerInactiveTooltip, self).__init__(settings)