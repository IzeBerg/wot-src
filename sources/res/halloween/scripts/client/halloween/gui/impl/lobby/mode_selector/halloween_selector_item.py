from account_helpers.AccountSettings import MODE_SELECTOR_BATTLE_PASS_SHOWN, AccountSettings
from gui.impl import backport
from gui.impl.gen import R
from gui.impl.gen.view_models.views.lobby.mode_selector.mode_selector_normal_card_model import BattlePassState
from gui.impl.gen.view_models.views.lobby.mode_selector.mode_selector_performance_model import PerformanceRiskEnum
from gui.impl.lobby.mode_selector.items import resetBattlePassStateForItem, BATTLE_PASS_SEASON_ID
from gui.impl.lobby.mode_selector.items.items_constants import ModeSelectorRewardID
from gui.shared.utils import SelectorBattleTypesUtils
from halloween.gui.halloween_gui_constants import PREBATTLE_ACTION_NAME
from halloween.gui.shared.utils.performance_analyzer import PerformanceGroup
from helpers import dependency, time_utils
from gui.impl.lobby.mode_selector.items.base_item import ModeSelectorLegacyItem, getFormattedTimeLeft
from halloween.skeletons.halloween_controller import IHalloweenController
from helpers.time_utils import ONE_DAY
from skeletons.gui.game_control import IBattlePassController, IBootcampController
PERFORMANCE_MAP = {PerformanceGroup.LOW_RISK: PerformanceRiskEnum.LOWRISK, 
   PerformanceGroup.MEDIUM_RISK: PerformanceRiskEnum.MEDIUMRISK, 
   PerformanceGroup.HIGH_RISK: PerformanceRiskEnum.HIGHRISK}

class HalloweenSelectorItem(ModeSelectorLegacyItem):
    __halloweenBattleCtrl = dependency.descriptor(IHalloweenController)
    __bpController = dependency.descriptor(IBattlePassController)
    __bootcampController = dependency.descriptor(IBootcampController)

    def _onInitializing(self):
        super(HalloweenSelectorItem, self)._onInitializing()
        self.__halloweenBattleCtrl.onSettingsUpdate += self.__onHalloweenUpdate
        self._addReward(ModeSelectorRewardID.HW_REWARD_TANK)
        self._addReward(ModeSelectorRewardID.HW_REWARD_DECALS)
        with self.viewModel.transaction() as (vm):
            vm.setTimeLeft(self.__getEndDate())
            vm.performance.setShowPerfRisk(True)
            vm.performance.setPerformanceRisk(PERFORMANCE_MAP.get(self.__halloweenBattleCtrl.getPerformanceGroup(), PerformanceRiskEnum.LOWRISK))
            vm.setIsNew(not SelectorBattleTypesUtils.isKnownBattleType(PREBATTLE_ACTION_NAME.HALLOWEEN))
            vm.setIsSelected(self.__halloweenBattleCtrl.isEventHangar())
            self.__setBattlePassState(vm)

    @property
    def isSelectable(self):
        return False

    @property
    def calendarTooltipText(self):
        endDate = self.__halloweenBattleCtrl.getModeSettings().endDate
        timeValue = max(0, endDate - time_utils.getServerUTCTime())
        if timeValue >= ONE_DAY:
            return backport.text(R.strings.mode_selector.mode.halloween.calendar(), date=self.__getEndDate())
        return backport.text(R.strings.mode_selector.mode.halloween.calendarDay(), date=self.__getEndDate())

    def handleClick(self):
        self.__halloweenBattleCtrl.selectBattle()

    def _onDisposing(self):
        self.__halloweenBattleCtrl.onSettingsUpdate -= self.__onHalloweenUpdate
        super(HalloweenSelectorItem, self)._onDisposing()

    def __onHalloweenUpdate(self, *_):
        self.onCardChange()

    def __getEndDate(self):
        endDate = self.__halloweenBattleCtrl.getModeSettings().endDate
        return getFormattedTimeLeft(max(0, endDate - time_utils.getServerUTCTime()))

    def __setBattlePassState(self, itemVM):
        isActive = self.__bpController.isEnabled()
        isPaused = self.__bpController.isPaused()
        isOffSeason = not self.__bpController.isSeasonStarted() or self.__bpController.isSeasonFinished()
        hasStatusNotActive = bool(itemVM.getStatusNotActive())
        seasonId = self.__bpController.getSeasonStartTime()
        if not isActive or isPaused or isOffSeason or hasStatusNotActive:
            resetBattlePassStateForItem(itemVM)
            return
        bpSettings = AccountSettings.getSettings(MODE_SELECTOR_BATTLE_PASS_SHOWN)
        isShown = bpSettings.get(itemVM.getModeName(), False)
        isNewSeason = bpSettings.get(BATTLE_PASS_SEASON_ID, 0) != seasonId
        if self.__bootcampController.isInBootcamp():
            state = BattlePassState.NONE
        else:
            state = BattlePassState.STATIC if isShown and not isNewSeason else BattlePassState.NEW
        itemVM.setBattlePassState(state)