from frameworks.wulf import ViewFlags, ViewSettings
from races.gui.impl.gen.view_models.views.lobby.reward_view.reward_view_model import RewardViewModel
from gui.impl.pub import ViewImpl

class RewardView(ViewImpl):
    __slots__ = ()

    def __init__(self, layoutID):
        settings = ViewSettings(layoutID)
        settings.flags = ViewFlags.LOBBY_SUB_VIEW
        settings.model = RewardViewModel()
        super(RewardView, self).__init__(settings)

    @property
    def viewModel(self):
        return super(RewardView, self).getViewModel()