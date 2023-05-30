from frameworks.wulf import ViewSettings, ViewModel
from gui.impl.pub import ViewImpl
from gui.impl.gen import R

class WTRInfoTooltip(ViewImpl):

    def __init__(self):
        settings = ViewSettings(R.views.lobby.achievements.tooltips.WTRInfoTooltip(), model=ViewModel())
        super(WTRInfoTooltip, self).__init__(settings)