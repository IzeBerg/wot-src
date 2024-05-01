from cosmic_event.gui.impl.gen.view_models.views.lobby.banner_entry_point.cosmic_banner_entry_point_model import CosmicBannerEntryPointModel
from frameworks.wulf import ViewSettings
from gui.impl.gen import R
from gui.impl.pub import ViewImpl

class EventBannerTooltipView(ViewImpl):
    __slots__ = ('__performanceRisk', )

    def __init__(self, performanceRisk, layoutID=R.views.cosmic_event.lobby.tooltips.EventBannerTooltip()):
        settings = ViewSettings(layoutID)
        settings.model = CosmicBannerEntryPointModel()
        super(EventBannerTooltipView, self).__init__(settings)
        self.__performanceRisk = performanceRisk

    @property
    def viewModel(self):
        return super(EventBannerTooltipView, self).getViewModel()

    def _onLoading(self, *args, **kwargs):
        super(EventBannerTooltipView, self)._onLoading(*args, **kwargs)
        with self.getViewModel().transaction() as (model):
            model.setPerformanceRisk(self.__performanceRisk)