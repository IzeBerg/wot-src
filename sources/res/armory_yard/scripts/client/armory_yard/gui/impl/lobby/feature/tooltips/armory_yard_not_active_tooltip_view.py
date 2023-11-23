import armory_yard.gui.impl.gen.view_models.views.lobby.feature.tooltips.entry_point_not_active_tooltip_view_model as model
from frameworks.wulf import ViewSettings
from gui.impl.gen import R
from gui.impl.pub import ViewImpl

class EntryPointNotActiveTooltipView(ViewImpl):
    __slots__ = ()

    def __init__(self):
        settings = ViewSettings(R.views.armory_yard.lobby.feature.tooltips.EntryPointNotActiveTooltipView())
        settings.model = model.EntryPointNotActiveTooltipViewModel()
        super(EntryPointNotActiveTooltipView, self).__init__(settings)

    def viewModel(self):
        return super(EntryPointNotActiveTooltipView, self).getViewModel()