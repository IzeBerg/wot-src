from frameworks.wulf.view.view import ViewSettings
from gui.impl.gen.view_models.views.reroll_tooltip_model import RerollTooltipModel
from gui.impl.gen import R
from gui.impl.pub import ViewImpl

class RerollTooltip(ViewImpl):

    def __init__(self, timeLeft, rerollInterval, withCountdown=False):
        self._timeLeft = timeLeft
        self._rerollInterval = rerollInterval
        settings = ViewSettings(R.views.lobby.missions.RerollTooltipWithCountdown() if withCountdown else R.views.lobby.missions.RerollTooltip(), model=RerollTooltipModel())
        super(RerollTooltip, self).__init__(settings)

    @property
    def viewModel(self):
        return super(RerollTooltip, self).getViewModel()

    def _onLoading(self, *args, **kwargs):
        self.viewModel.setTimeLeft(self._timeLeft)
        self.viewModel.setRerollInterval(self._rerollInterval)