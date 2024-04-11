from gui.impl.gen import R
from frameworks.wulf import ViewModel, ViewSettings
from gui.impl.pub import ViewImpl

class GeneralHbCoinTooltip(ViewImpl):
    __slots__ = ()

    def __init__(self):
        settings = ViewSettings(R.views.historical_battles.lobby.tooltips.GeneralHbCoinTooltip())
        settings.model = ViewModel()
        super(GeneralHbCoinTooltip, self).__init__(settings)

    @property
    def viewModel(self):
        return super(GeneralHbCoinTooltip, self).getViewModel()