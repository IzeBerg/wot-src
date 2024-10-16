from frameworks.wulf import ViewSettings
from gui.impl.gen import R
from gui.impl.pub import ViewImpl
from halloween.gui.impl.gen.view_models.views.lobby.event_banner_view_model import EventBannerViewModel

class EventBannerTooltipView(ViewImpl):
    __slots__ = ('__performanceRisk', )

    def __init__(self, performanceRisk, layoutID=R.views.halloween.lobby.tooltips.EventBannerTooltip()):
        settings = ViewSettings(layoutID)
        settings.model = EventBannerViewModel()
        super(EventBannerTooltipView, self).__init__(settings)
        self.__performanceRisk = performanceRisk

    @property
    def viewModel(self):
        return super(EventBannerTooltipView, self).getViewModel()

    def _onLoading(self, *args, **kwargs):
        super(EventBannerTooltipView, self)._onLoading(*args, **kwargs)
        with self.getViewModel().transaction() as (model):
            model.setPerformanceRisk(self.__performanceRisk)