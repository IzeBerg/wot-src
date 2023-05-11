from frameworks.wulf import ViewSettings, ViewModel
from gui.impl.pub import ViewImpl
from gui.impl.gen import R

class WOTPRMainTooltip(ViewImpl):

    def __init__(self):
        settings = ViewSettings(R.views.lobby.achievements.tooltips.WOTPRMainTooltip(), model=ViewModel())
        super(WOTPRMainTooltip, self).__init__(settings)