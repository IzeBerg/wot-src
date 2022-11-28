from frameworks.wulf import ViewSettings
from gui.impl.gen import R
from gui.impl.gen.view_models.views.lobby.tank_setup.tooltips.warning_tooltip_view_model import WarningTooltipViewModel, WarningDescription
from gui.impl.pub import ViewImpl

class WarningTooltipView(ViewImpl):

    def __init__(self, reason, isCritical):
        settings = ViewSettings(R.views.lobby.tanksetup.tooltips.WarningTooltipView())
        settings.model = WarningTooltipViewModel()
        settings.args = (reason, isCritical)
        super(WarningTooltipView, self).__init__(settings)

    @property
    def viewModel(self):
        return super(WarningTooltipView, self).getViewModel()

    def _onLoading(self, reason, isCritical, *args, **kwargs):
        super(WarningTooltipView, self)._onLoading(*args, **kwargs)
        self.viewModel.setReason(WarningDescription(reason))
        self.viewModel.setIsCritical(isCritical)