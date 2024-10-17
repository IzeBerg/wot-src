from frameworks.wulf import ViewSettings, ViewFlags
from gui.impl.pub import ViewImpl
from gui.impl.gen import R
from halloween.gui.halloween_gui_constants import PREBATTLE_ACTION_NAME
from gui.shared.utils import SelectorBattleTypesUtils
from halloween.gui.impl.lobby.tooltips.event_banner_tooltip import EventBannerTooltipView
from halloween.gui.shared.utils.performance_analyzer import PerformanceGroup
from halloween.gui.impl.gen.view_models.views.lobby.event_banner_view_model import EventBannerViewModel, PerformanceRiskEnum
from helpers import dependency, time_utils
from halloween.skeletons.halloween_controller import IHalloweenController
PERFORMANCE_MAP = {PerformanceGroup.LOW_RISK: PerformanceRiskEnum.LOWRISK, 
   PerformanceGroup.MEDIUM_RISK: PerformanceRiskEnum.MEDIUMRISK, 
   PerformanceGroup.HIGH_RISK: PerformanceRiskEnum.HIGHRISK}

@dependency.replace_none_kwargs(ctrl=IHalloweenController)
def isHalloweenEntryPointAvailable(ctrl=None):
    return ctrl.isAvailable()


class HalloweenEntryPointView(ViewImpl):
    __halloweenCtrl = dependency.descriptor(IHalloweenController)

    def __init__(self, flags=ViewFlags.VIEW):
        settings = ViewSettings(R.views.halloween.lobby.EventBannerView())
        settings.flags = flags
        settings.model = EventBannerViewModel()
        super(HalloweenEntryPointView, self).__init__(settings)

    @property
    def viewModel(self):
        return super(HalloweenEntryPointView, self).getViewModel()

    def createToolTipContent(self, event, contentID):
        if contentID == R.views.halloween.lobby.tooltips.EventBannerTooltip():
            performance = PERFORMANCE_MAP.get(self.__halloweenCtrl.getPerformanceGroup(), PerformanceRiskEnum.LOWRISK)
            return EventBannerTooltipView(performanceRisk=performance)
        return super(HalloweenEntryPointView, self).createToolTipContent(event, contentID)

    def _onLoading(self, *args, **kwargs):
        super(HalloweenEntryPointView, self)._onLoading(*args, **kwargs)
        self.__update()

    def _getEvents(self):
        return [
         (
          self.viewModel.onClick, self.__onClick),
         (
          self.__halloweenCtrl.onEventDisabled, self.__update),
         (
          self.__halloweenCtrl.onSettingsUpdate, self.__update)]

    def __onClick(self):
        self.__halloweenCtrl.selectBattle()

    def __update(self):
        if not isHalloweenEntryPointAvailable():
            self.destroyWindow()
            return
        with self.viewModel.transaction() as (model):
            model.setDate(time_utils.getServerUTCTime())
            model.setEndDate(self.__halloweenCtrl.getModeSettings().endDate)
            model.setPerformanceRisk(PERFORMANCE_MAP.get(self.__halloweenCtrl.getPerformanceGroup(), PerformanceRiskEnum.LOWRISK))
            model.setIsNew(not SelectorBattleTypesUtils.isKnownBattleType(PREBATTLE_ACTION_NAME.HALLOWEEN))