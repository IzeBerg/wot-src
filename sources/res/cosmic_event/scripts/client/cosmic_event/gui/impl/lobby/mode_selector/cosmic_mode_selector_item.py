from cosmic_event.skeletons.progression_controller import ICosmicEventProgressionController
from gui.impl.gen.view_models.views.lobby.mode_selector.mode_selector_cosmic_model import PerformanceRiskEnum
from gui import GUI_SETTINGS
from gui.impl import backport
from gui.impl.gen import R
from gui.impl.lobby.mode_selector.items.base_item import ModeSelectorLegacyItem, formatSeasonLeftTime
from gui.impl.gen.view_models.views.lobby.mode_selector.mode_selector_cosmic_model import ModeSelectorCosmicModel
from gui.impl.gen.view_models.views.lobby.mode_selector.mode_selector_card_types import ModeSelectorCardTypes
from cosmic_event.skeletons.battle_controller import ICosmicEventBattleController
from cosmic_event.gui.shared.utils.performance_analyzer import PerformanceGroup, PerformanceAnalyzerMixin
from cosmic_event.gui.prb_control.prb_config import PREBATTLE_ACTION_NAME
from gui.shared.event_dispatcher import showBrowserOverlayView
from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
from frameworks.wulf import WindowLayer
from gui.shared.utils import SelectorBattleTypesUtils
from cosmic_constants import CosmicModeSelectorRewardID
from helpers import dependency
PERFORMANCE_MAP = {PerformanceGroup.LOW_RISK: PerformanceRiskEnum.LOWRISK, 
   PerformanceGroup.MEDIUM_RISK: PerformanceRiskEnum.MEDIUMRISK, 
   PerformanceGroup.HIGH_RISK: PerformanceRiskEnum.HIGHRISK}

class CosmicEventModeSelectorItem(ModeSelectorLegacyItem, PerformanceAnalyzerMixin):
    __slots__ = ()
    _VIEW_MODEL = ModeSelectorCosmicModel
    _CARD_VISUAL_TYPE = ModeSelectorCardTypes.COSMIC
    _cosmicEventBattleCtrl = dependency.descriptor(ICosmicEventBattleController)
    _cosmicProgression = dependency.descriptor(ICosmicEventProgressionController)

    @property
    def viewModel(self):
        return self._viewModel

    @property
    def isSelectable(self):
        return self._cosmicEventBattleCtrl.isEnabled

    @property
    def isSuspended(self):
        return self._cosmicEventBattleCtrl.isTemporaryUnavailable()

    @property
    def calendarTooltipText(self):
        return backport.text(R.strings.mode_selector.mode.cosmic_event.timeLeft(), time=formatSeasonLeftTime(self._cosmicEventBattleCtrl.getCurrentSeason()))

    def _onDisposing(self):
        self.__removeListeners()

    def __addListeners(self):
        self._cosmicEventBattleCtrl.onStatusTick += self.__onUpdated
        self._cosmicProgression.onProgressPointsUpdated += self.__onUpdated

    def __removeListeners(self):
        self._cosmicEventBattleCtrl.onStatusTick -= self.__onUpdated
        self._cosmicProgression.onProgressPointsUpdated -= self.__onUpdated

    def _isInfoIconVisible(self):
        return True

    def handleInfoPageClick(self):
        url = self._getInfoPageURL()
        showBrowserOverlayView(url, VIEW_ALIAS.WEB_VIEW_TRANSPARENT, hiddenLayers=(
         WindowLayer.MARKER, WindowLayer.VIEW, WindowLayer.WINDOW))

    def _onInitializing(self):
        super(CosmicEventModeSelectorItem, self)._onInitializing()
        self.__setData()
        with self.viewModel.transaction() as (tx):
            tx.setName(backport.text(R.strings.mode_selector.mode.cosmic_event.title()))
            tx.setIsNew(not SelectorBattleTypesUtils.isKnownBattleType(PREBATTLE_ACTION_NAME.COSMIC_EVENT))
            tx.setPerformanceRisk(PERFORMANCE_MAP.get(self.getPerformanceGroup(), PerformanceRiskEnum.LOWRISK))
            if self._cosmicEventBattleCtrl.isBattleAvailable():
                self._addReward(CosmicModeSelectorRewardID.COSMIC_CREW)
                self._addReward(CosmicModeSelectorRewardID.STYLE_2D)
                self._addReward(CosmicModeSelectorRewardID.EVENT_BONDS)

    def _getInfoPageURL(self):
        return GUI_SETTINGS.cosmicInfoPageURL

    def __setData(self):
        with self.viewModel.transaction() as (model):
            model.setTimeLeft(formatSeasonLeftTime(self._cosmicEventBattleCtrl.getCurrentSeason()))
            self.__fillWidget(model.widget)
            self.__updateSuspendedStatus(model)

    def __onUpdated(self, *_):
        self.__setData()

    def __fillWidget(self, model):
        ctrl = self._cosmicEventBattleCtrl
        currentStage, maxStages = self._cosmicProgression.getStageProgress()
        model.setIsEnabled(ctrl.isEnabled)
        model.setCurrentProgress(currentStage)
        model.setTotalCount(maxStages)

    def __updateSuspendedStatus(self, model):
        model.setIsSuspended(self.isSuspended)