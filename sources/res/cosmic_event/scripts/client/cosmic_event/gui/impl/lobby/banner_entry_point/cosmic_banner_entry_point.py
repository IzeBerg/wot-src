from cosmic_event.gui.impl.gen.view_models.views.lobby.banner_entry_point.cosmic_banner_entry_point_model import CosmicBannerEntryPointModel, State, PerformanceRiskEnum
from cosmic_event.gui.impl.lobby.banner_entry_point.event_banner_tooltip import EventBannerTooltipView
from cosmic_event.gui.prb_control.prb_config import PREBATTLE_ACTION_NAME
from cosmic_event.gui.shared.utils.performance_analyzer import PerformanceGroup, PerformanceAnalyzerMixin
from cosmic_event.skeletons.battle_controller import ICosmicEventBattleController
from frameworks.wulf import ViewFlags, ViewSettings
from gui.impl.gen import R
from gui.impl.pub import ViewImpl
from gui.shared.utils import SelectorBattleTypesUtils
from gui.shared.utils.scheduled_notifications import Notifiable
from helpers import dependency, time_utils
from shared_utils import nextTick
PERFORMANCE_MAP = {PerformanceGroup.LOW_RISK: PerformanceRiskEnum.LOWRISK, 
   PerformanceGroup.MEDIUM_RISK: PerformanceRiskEnum.MEDIUMRISK, 
   PerformanceGroup.HIGH_RISK: PerformanceRiskEnum.HIGHRISK, 
   PerformanceGroup.VERY_HIGH_RISK: PerformanceRiskEnum.HIGHRISK}

@dependency.replace_none_kwargs(cosmicCtrl=ICosmicEventBattleController)
def isCosmicBannerEntryPointAvailable(cosmicCtrl=None):
    return cosmicCtrl.isEnabled


class CosmicBannerEntryPointView(ViewImpl, Notifiable, PerformanceAnalyzerMixin):
    __END_NOTIFICATIONS_PERIOD_LENGTH = time_utils.ONE_DAY
    __cosmicController = dependency.descriptor(ICosmicEventBattleController)

    def __init__(self, flags=ViewFlags.VIEW):
        settings = ViewSettings(layoutID=R.views.cosmic_event.lobby.banner_entry_point.CosmicBannerEntryPoint(), flags=flags, model=CosmicBannerEntryPointModel())
        super(CosmicBannerEntryPointView, self).__init__(settings)
        self.__isSingle = True

    @property
    def viewModel(self):
        return super(CosmicBannerEntryPointView, self).getViewModel()

    def setIsSingle(self, value):
        self.__isSingle = value
        self.__updateState()

    def createToolTipContent(self, event, contentID):
        if contentID == R.views.cosmic_event.lobby.tooltips.EventBannerTooltip():
            performance = PERFORMANCE_MAP.get(self.getPerformanceGroup(), PerformanceRiskEnum.LOWRISK)
            return EventBannerTooltipView(performanceRisk=performance)
        return super(CosmicBannerEntryPointView, self).createToolTipContent(event, contentID)

    def _initialize(self, *args, **kwargs):
        super(CosmicBannerEntryPointView, self)._initialize(*args, **kwargs)
        self.viewModel.onOpen += self.__onOpen
        self.__cosmicController.onPrimeTimeStatusUpdated += self.__onStatusUpdated
        self.__cosmicController.onStatusTick += self.__onStatusTick
        self.__cosmicController.onCosmicConfigChanged += self.__onConfigChanged

    def _finalize(self):
        self.viewModel.onOpen -= self.__onOpen
        self.__cosmicController.onPrimeTimeStatusUpdated -= self.__onStatusUpdated
        self.__cosmicController.onStatusTick -= self.__onStatusTick
        self.__cosmicController.onCosmicConfigChanged -= self.__onConfigChanged
        super(CosmicBannerEntryPointView, self)._finalize()

    def _onLoading(self, *args, **kwargs):
        super(CosmicBannerEntryPointView, self)._onLoading(*args, **kwargs)
        self.__updateState()

    def __onStatusUpdated(self, _):
        self.__updateState()

    def __onStatusTick(self):
        self.__updateState()

    def __onConfigChanged(self):
        self.__updateState()

    def __updateState(self):
        if isCosmicBannerEntryPointAvailable():
            with self.viewModel.transaction() as (tx):
                state, actualTime = self.__getPeriodStateAndActualTime()
                tx.setState(state)
                tx.setIsSingle(self.__isSingle)
                tx.setTimestamp(actualTime or 0)
                tx.setPerformanceRisk(PERFORMANCE_MAP.get(self.getPerformanceGroup(), PerformanceRiskEnum.LOWRISK))
                tx.setIsNew(not SelectorBattleTypesUtils.isKnownBattleType(PREBATTLE_ACTION_NAME.COSMIC_EVENT))
                if state == State.ENDSOON:
                    tx.setEndTimestamp(0)
                else:
                    tx.setEndTimestamp(self.__cosmicController.getCurrentSeason().getEndDate())
        else:
            nextTick(self.destroy)()

    def __getPeriodStateAndActualTime(self):
        if self.__cosmicController.isFrozen() or not self.__cosmicController.isBattleAvailable():
            return (State.DISABLED, 0)
        periodInfo = self.__cosmicController.getPeriodInfo()
        timeLeft = periodInfo.cycleBorderRight.delta(periodInfo.now)
        if timeLeft < self.__END_NOTIFICATIONS_PERIOD_LENGTH:
            return (State.ENDSOON, timeLeft)
        return (State.ACTIVE, timeLeft)

    def __onOpen(self):
        self.__cosmicController.switchPrb()