from frameworks.wulf import ViewSettings
from event_lootboxes.gui.impl.gen.view_models.views.lobby.event_lootboxes.entry_point_view_model import EntryPointViewModel
from gui.impl.gen import R
from gui.impl.pub import ViewImpl

class EventLootBoxesEntryPointTooltipView(ViewImpl):
    __slots__ = ()

    def __init__(self):
        settings = ViewSettings(R.views.event_lootboxes.lobby.event_lootboxes.tooltips.EntryPointTooltip())
        settings.model = EntryPointViewModel()
        super(EventLootBoxesEntryPointTooltipView, self).__init__(settings)

    @property
    def viewModel(self):
        return super(EventLootBoxesEntryPointTooltipView, self).getViewModel()