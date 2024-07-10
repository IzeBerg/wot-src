from gui.impl.gen.view_models.views.battle_royale.tournament_banner_base_view_model import TournamentBannerBaseViewModel

class TournamentBannerTooltipViewModel(TournamentBannerBaseViewModel):
    __slots__ = ()

    def __init__(self, properties=3, commands=0):
        super(TournamentBannerTooltipViewModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(TournamentBannerTooltipViewModel, self)._initialize()