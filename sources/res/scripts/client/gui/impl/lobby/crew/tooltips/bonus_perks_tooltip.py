from frameworks.wulf import ViewSettings, ViewModel
from gui.impl.gen import R
from gui.impl.pub import ViewImpl

class BonusPerksTooltip(ViewImpl):

    def __init__(self):
        settings = ViewSettings(R.views.lobby.crew.tooltips.BonusPerksTooltip(), model=ViewModel())
        super(BonusPerksTooltip, self).__init__(settings)