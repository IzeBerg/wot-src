import SoundGroups
from battle_pass_common import BattlePassRewardReason
from frameworks.wulf import ViewSettings, WindowFlags
from gui.battle_pass.battle_pass_award import BattlePassAwardsManager
from gui.battle_pass.battle_pass_bonuses_packers import packBonusModelAndTooltipData, useBigAwardInjection
from gui.battle_pass.battle_pass_decorators import createBackportTooltipDecorator, createTooltipContentDecorator
from gui.battle_pass.battle_pass_helpers import getStyleInfoForChapter
from gui.battle_pass.sounds import BattlePassSounds
from gui.impl.gen import R
from gui.impl.gen.view_models.views.lobby.battle_pass.battle_pass_awards_view_model import BattlePassAwardsViewModel, RewardReason
from gui.impl.pub import ViewImpl
from gui.impl.pub.lobby_window import LobbyNotificationWindow
from gui.shared import EVENT_BUS_SCOPE, events, g_eventBus
from gui.shared.event_dispatcher import showBattlePassBuyWindow
from gui.sounds.filters import switchHangarOverlaySoundFilter
from helpers import dependency
from skeletons.gui.game_control import IBattlePassController
MAP_REWARD_REASON = {BattlePassRewardReason.PURCHASE_BATTLE_PASS: RewardReason.BUY_BATTLE_PASS, 
   BattlePassRewardReason.PURCHASE_BATTLE_PASS_LEVELS: RewardReason.BUY_BATTLE_PASS_LEVELS, 
   BattlePassRewardReason.STYLE_UPGRADE: RewardReason.STYLE_UPGRADE, 
   BattlePassRewardReason.PURCHASE_BATTLE_PASS_MULTIPLE: RewardReason.BUY_MULTIPLE_BATTLE_PASS, 
   BattlePassRewardReason.SELECT_REWARD: RewardReason.BUY_BATTLE_PASS_LEVELS}
MAIN_REWARDS_LIMIT = 4
FINAL_REWARDS_LIMIT = 3
STANDART_REWARD_SIZE = 1
WIDE_REWARD_SIZE = 1.5
REWARD_SIZES = {'Standard': STANDART_REWARD_SIZE, 
   'Wide': WIDE_REWARD_SIZE, 
   'None': 0}

class BattlePassAwardsView(ViewImpl):
    __slots__ = ('__tooltipItems', '__closeCallback')
    __battlePassController = dependency.descriptor(IBattlePassController)

    def __init__(self, *args, **kwargs):
        settings = ViewSettings(R.views.lobby.battle_pass.BattlePassAwardsView())
        settings.model = BattlePassAwardsViewModel()
        settings.args = args
        settings.kwargs = kwargs
        self.__tooltipItems = {}
        self.__closeCallback = None
        super(BattlePassAwardsView, self).__init__(settings)
        return

    @property
    def viewModel(self):
        return super(BattlePassAwardsView, self).getViewModel()

    @createBackportTooltipDecorator()
    def createToolTip(self, event):
        return super(BattlePassAwardsView, self).createToolTip(event)

    @createTooltipContentDecorator()
    def createToolTipContent(self, event, contentID):
        return

    def getTooltipData(self, event):
        tooltipId = event.getArgument('tooltipId')
        if tooltipId is None:
            return
        else:
            return self.__tooltipItems.get(tooltipId)

    def _getEvents(self):
        return (
         (
          self.viewModel.onBuyClick, self.__onBuyClick),)

    def _onLoading(self, bonuses, data, *args, **kwargs):
        super(BattlePassAwardsView, self)._onLoading(*args, **kwargs)
        chapterID = data.get('chapter', 0)
        newLevel = data.get('newLevel', 0) or 0
        reason = data.get('reason', BattlePassRewardReason.DEFAULT)
        self.__closeCallback = data.get('callback')
        isFinalReward = self.__battlePassController.isFinalLevel(chapterID, newLevel) and reason not in (
         BattlePassRewardReason.PURCHASE_BATTLE_PASS, BattlePassRewardReason.PURCHASE_BATTLE_PASS_MULTIPLE,
         BattlePassRewardReason.SELECT_REWARD)
        isPurchase = reason in BattlePassRewardReason.PURCHASE_REASONS
        rewardReason = MAP_REWARD_REASON.get(reason, RewardReason.DEFAULT)
        isBattlePassPurchased = self.__battlePassController.isBought(chapterID=chapterID) or isPurchase
        _, styleLevel = getStyleInfoForChapter(chapterID) if chapterID else (None,
                                                                             None)
        with self.viewModel.transaction() as (tx):
            tx.setIsFinalReward(isFinalReward)
            tx.setReason(rewardReason)
            tx.setIsBattlePassPurchased(isBattlePassPurchased)
            tx.setCurrentLevel(newLevel)
            tx.setChapterID(chapterID)
            tx.setSeasonStopped(self.__battlePassController.isPaused())
            tx.setIsBaseStyleLevel(styleLevel == 1)
            tx.setIsExtra(self.__battlePassController.isExtraChapter(chapterID))
        self.__setAwards(bonuses, isFinalReward)
        isRewardSelected = reason == BattlePassRewardReason.SELECT_REWARD
        self.viewModel.setIsNeedToShowOffer(not (isBattlePassPurchased or self.viewModel.additionalRewards.getItemsLength() or isRewardSelected))
        switchHangarOverlaySoundFilter(on=True)
        SoundGroups.g_instance.playSound2D(BattlePassSounds.REWARD_SCREEN)
        return

    def _onLoaded(self, data, *args, **kwargs):
        reason = data.get('reason', BattlePassRewardReason.DEFAULT)
        if reason in (BattlePassRewardReason.PURCHASE_BATTLE_PASS, BattlePassRewardReason.PURCHASE_BATTLE_PASS_LEVELS):
            g_eventBus.handleEvent(events.BattlePassEvent(events.BattlePassEvent.BUYING_THINGS), scope=EVENT_BUS_SCOPE.LOBBY)

    def _finalize(self):
        super(BattlePassAwardsView, self)._finalize()
        self.__tooltipItems = None
        switchHangarOverlaySoundFilter(on=False)
        if callable(self.__closeCallback):
            self.__closeCallback()
        g_eventBus.handleEvent(events.BattlePassEvent(events.BattlePassEvent.AWARD_VIEW_CLOSE), scope=EVENT_BUS_SCOPE.LOBBY)
        return

    def __setAwards(self, bonuses, isFinalReward):
        rewards = BattlePassAwardsManager.composeBonuses(bonuses)
        rewards = BattlePassAwardsManager.sortBonuses(BattlePassAwardsManager.uniteTokenBonuses(rewards))
        if not rewards:
            return
        mainRewards = self.__setMainRewards(rewards, isFinalReward=isFinalReward)
        rewards = [ reward for reward in rewards if reward not in mainRewards ]
        packBonusModelAndTooltipData(rewards, self.viewModel.additionalRewards, self.__tooltipItems)

    def __setMainRewards(self, rewards, isFinalReward):
        limit = MAIN_REWARDS_LIMIT if not isFinalReward else FINAL_REWARDS_LIMIT
        mainRewards = []
        for reward in rewards:
            weight = self.__getRewardWeight(reward)
            if limit >= weight > 0:
                mainRewards.append(reward)
                limit -= weight
                if weight == WIDE_REWARD_SIZE:
                    self.viewModel.getWideRewardsIDs().addNumber(len(mainRewards) - 1)
            elif limit <= 0:
                break

        with useBigAwardInjection():
            packBonusModelAndTooltipData(mainRewards, self.viewModel.mainRewards, self.__tooltipItems)
        return mainRewards

    @staticmethod
    def __getRewardWeight(bonus):
        return REWARD_SIZES.get(BattlePassAwardsManager.getBigIcon(bonus), 0)

    def __onBuyClick(self):
        if callable(self.__closeCallback):
            self.__closeCallback()
            self.__closeCallback = None
        showBattlePassBuyWindow()
        self.destroyWindow()
        return


class BattlePassAwardWindow(LobbyNotificationWindow):
    __slots__ = ('__params', )

    def __init__(self, bonuses, data):
        self.__params = dict(bonuses=bonuses, data=data)
        super(BattlePassAwardWindow, self).__init__(wndFlags=WindowFlags.SERVICE_WINDOW | WindowFlags.WINDOW_FULLSCREEN, content=BattlePassAwardsView(**self.__params))

    def isParamsEqual(self, *args, **kwargs):
        return all(pValue in args or kwargs.get(pName) == pValue for pName, pValue in self.__params.iteritems())