from frameworks.wulf import ViewSettings
from gui.impl.gen import R
from gui.impl.gen.view_models.views.lobby.new_year.tooltips.ny_sack_random_reward_tooltip_model import NySackRandomRewardTooltipModel
from gui.impl.pub import ViewImpl

class NySackRandomRewardTooltip(ViewImpl):
    __slots__ = ('__resourceType', )

    def __init__(self, *args, **kwargs):
        settings = ViewSettings(R.views.lobby.new_year.tooltips.NySackRandomRewardTooltip())
        settings.model = NySackRandomRewardTooltipModel()
        settings.args = args
        settings.kwargs = kwargs
        super(NySackRandomRewardTooltip, self).__init__(settings)

    @property
    def viewModel(self):
        return super(NySackRandomRewardTooltip, self).getViewModel()

    def _onLoading(self, resourceType):
        with self.viewModel.transaction() as (model):
            model.setResourceType(resourceType)