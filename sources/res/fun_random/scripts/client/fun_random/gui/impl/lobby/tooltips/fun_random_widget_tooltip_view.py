from frameworks.wulf import ViewSettings
from fun_random.gui.impl.gen.view_models.views.lobby.tooltips.fun_random_widget_tooltip_view_model import FunRandomWidgetTooltipViewModel
from gui.impl.gen import R
from gui.impl.pub import ViewImpl
from helpers import dependency, time_utils
from skeletons.gui.game_control import IFunRandomController

class FunRandomWidgetTooltipView(ViewImpl):
    __slots__ = ()
    __funRandomCtrl = dependency.descriptor(IFunRandomController)

    def __init__(self):
        settings = ViewSettings(layoutID=R.views.fun_random.lobby.tooltips.FunRandomWidgetTooltipView(), model=FunRandomWidgetTooltipViewModel())
        super(FunRandomWidgetTooltipView, self).__init__(settings)

    @property
    def viewModel(self):
        return super(FunRandomWidgetTooltipView, self).getViewModel()

    def _onLoading(self, *args, **kwargs):
        super(FunRandomWidgetTooltipView, self)._onLoading(*args, **kwargs)
        currentSeason = self.__funRandomCtrl.getCurrentSeason()
        if currentSeason is None:
            return
        else:
            with self.getViewModel().transaction() as (model):
                model.setLeftTime(currentSeason.getEndDate() - time_utils.getServerUTCTime())
            return