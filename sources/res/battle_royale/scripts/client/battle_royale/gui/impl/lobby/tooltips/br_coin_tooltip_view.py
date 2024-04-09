from frameworks.wulf import ViewSettings, ViewModel
from gui.impl.gen import R
from gui.impl.pub import ViewImpl

class BrCoinTooltipView(ViewImpl):

    def __init__(self):
        settings = ViewSettings(R.views.battle_royale.lobby.tooltips.BrCoinTooltipView())
        settings.model = ViewModel()
        super(BrCoinTooltipView, self).__init__(settings)