from frameworks.wulf import ViewSettings
from gui.impl.gen.view_models.views.lobby.achievements.tooltips.auto_setting_tooltip_model import AutoSettingTooltipModel
from gui.impl.pub import ViewImpl
from gui.impl.gen import R

class AutoSettingTooltip(ViewImpl):
    __slots__ = ()

    def __init__(self, *args, **kwargs):
        settings = ViewSettings(R.views.lobby.achievements.tooltips.AutoSettingTooltip())
        settings.model = AutoSettingTooltipModel()
        settings.args = args
        settings.kwargs = kwargs
        super(AutoSettingTooltip, self).__init__(settings)

    @property
    def viewModel(self):
        return super(AutoSettingTooltip, self).getViewModel()

    def _onLoading(self, isSwitchedOn):
        with self.viewModel.transaction() as (model):
            model.setIsSwitchedOn(isSwitchedOn)