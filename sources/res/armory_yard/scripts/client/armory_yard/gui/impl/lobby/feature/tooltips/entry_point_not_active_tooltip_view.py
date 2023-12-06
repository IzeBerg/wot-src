from frameworks.wulf import ViewFlags, ViewSettings
import armory_yard.gui.impl.gen.view_models.views.lobby.feature.tooltips.entry_point_not_active_tooltip_view_model as model
from gui.impl.pub import ViewImpl

class EntryPointNotActiveTooltipView(ViewImpl):
    __slots__ = ()

    def __init__(self, layoutID):
        settings = ViewSettings(layoutID)
        settings.flags = ViewFlags.LOBBY_SUB_VIEW
        settings.model = model.EntryPointNotActiveTooltipViewModel()
        super(EntryPointNotActiveTooltipView, self).__init__(settings)

    @property
    def viewModel(self):
        return super(EntryPointNotActiveTooltipView, self).getViewModel()