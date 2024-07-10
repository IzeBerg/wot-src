from frameworks.wulf import ViewFlags, ViewSettings
from gui.impl.gen import R
from gui.impl.gen.view_models.views.battle_royale.tournament_banner_tooltip_view_model import TournamentBannerTooltipViewModel
from gui.impl.pub import ViewImpl

class TournamentBannerTooltipView(ViewImpl):
    __slots__ = ()

    def __init__(self, *args, **kwargs):
        settings = ViewSettings(R.views.battle_royale.lobby.tooltips.TournamentBannerTooltipView())
        settings.flags = ViewFlags.VIEW
        settings.model = TournamentBannerTooltipViewModel()
        settings.args = args
        settings.kwargs = kwargs
        super(TournamentBannerTooltipView, self).__init__(settings)

    @property
    def viewModel(self):
        return super(TournamentBannerTooltipView, self).getViewModel()

    def _onLoading(self, state, dateStart, dateEnd, *args, **kwargs):
        with self.viewModel.transaction() as (tx):
            tx.setState(state)
            tx.setDateStart(dateStart)
            tx.setDateEnd(dateEnd)