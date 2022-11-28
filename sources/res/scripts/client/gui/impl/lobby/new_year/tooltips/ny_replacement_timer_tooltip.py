from frameworks.wulf import ViewSettings
from gui.impl.gen.view_models.views.lobby.new_year.tooltips.ny_replacement_timer_tooltip_model import NyReplacementTimerTooltipModel
from gui.impl.pub import ViewImpl
from gui.impl.gen import R
from helpers import time_utils

class NyReplacementTimerTooltip(ViewImpl):
    __slots__ = ()

    def __init__(self):
        settings = ViewSettings(R.views.lobby.new_year.tooltips.NyReplacementTimerTooltip())
        settings.model = NyReplacementTimerTooltipModel()
        super(NyReplacementTimerTooltip, self).__init__(settings)

    @property
    def viewModel(self):
        return super(NyReplacementTimerTooltip, self).getViewModel()

    def _onLoaded(self, *args, **kwargs):
        super(NyReplacementTimerTooltip, self)._onLoaded()
        self.viewModel.setTimeTill(time_utils.getDayTimeLeft())