import logging, SoundGroups
from PlayerEvents import g_playerEvents
from frameworks.wulf import ViewFlags, ViewSettings, WindowFlags
from gui.Scaleform.daapi.view.lobby.store.browser.shop_helpers import getBuyBattlePassUrl
from gui.battle_pass.battle_pass_bonuses_packers import packBonusModelAndTooltipData
from gui.battle_pass.battle_pass_buyer import BattlePassBuyer
from gui.battle_pass.battle_pass_constants import ChapterState
from gui.battle_pass.battle_pass_decorators import createBackportTooltipDecorator, createTooltipContentDecorator
from gui.battle_pass.battle_pass_package import generatePackages
from gui.battle_pass.sounds import BattlePassSounds
from gui.impl.gen import R
from gui.impl.gen.view_models.views.lobby.battle_pass.battle_pass_buy_view_model import BattlePassBuyViewModel
from gui.impl.gen.view_models.views.lobby.battle_pass.package_item import ChapterStates, PackageItem, PackageType
from gui.impl.pub import ViewImpl
from gui.impl.pub.lobby_window import LobbyWindow
from gui.impl.wrappers.function_helpers import replaceNoneKwargsModel
from gui.server_events.events_dispatcher import showMissionsBattlePass
from gui.shared import EVENT_BUS_SCOPE, g_eventBus
from gui.shared.event_dispatcher import showHangar, showShop
from gui.shared.events import BattlePassEvent
from gui.sounds.filters import switchHangarOverlaySoundFilter
from helpers import dependency
from skeletons.gui.game_control import IBattlePassController, IWalletController
from skeletons.gui.shared import IItemsCache
WINDOW_IS_NOT_OPENED = -1
_CHAPTER_STATES = {ChapterState.ACTIVE: ChapterStates.ACTIVE, 
   ChapterState.COMPLETED: ChapterStates.COMPLETED, 
   ChapterState.PAUSED: ChapterStates.PAUSED, 
   ChapterState.NOT_STARTED: ChapterStates.NOTSTARTED}

class BattlePassBuyViewStates(object):

    def __init__(self):
        self.chapterID = WINDOW_IS_NOT_OPENED
        g_playerEvents.onDisconnected += self.reset
        g_playerEvents.onAccountBecomePlayer += self.reset

    def reset(self):
        self.chapterID = WINDOW_IS_NOT_OPENED

    def getPackageID(self):
        return self.chapterID


g_BPBuyViewStates = BattlePassBuyViewStates()
_logger = logging.getLogger(__name__)

class BattlePassBuyView(ViewImpl):
    __slots__ = ('__packages', '__selectedPackage', '__tooltipItems', '__backCallback',
                 '__backBtnDescrLabel', '__tooltipWindow')
    __battlePassController = dependency.descriptor(IBattlePassController)
    __wallet = dependency.descriptor(IWalletController)
    __itemsCache = dependency.descriptor(IItemsCache)

    def __init__(self, layoutID, wsFlags=ViewFlags.LOBBY_TOP_SUB_VIEW, viewModelClazz=BattlePassBuyViewModel, ctx=None):
        settings = ViewSettings(layoutID)
        settings.flags = wsFlags
        settings.model = viewModelClazz()
        self.__backCallback = None if ctx is None else ctx.get('backCallback')
        self.__packages = {}
        self.__selectedPackage = None
        self.__tooltipItems = {}
        self.__tooltipWindow = None
        self.__packageID = None
        super(BattlePassBuyView, self).__init__(settings)
        return

    @property
    def viewModel(self):
        return super(BattlePassBuyView, self).getViewModel()

    @createBackportTooltipDecorator()
    def createToolTip(self, event):
        return super(BattlePassBuyView, self).createToolTip(event)

    @createTooltipContentDecorator()
    def createToolTipContent(self, event, contentID):
        return

    def getTooltipData(self, event):
        tooltipId = event.getArgument('tooltipId')
        if tooltipId is None:
            return
        else:
            return self.__tooltipItems.get(tooltipId)

    def _onLoading(self, *args, **kwargs):
        super(BattlePassBuyView, self)._onLoading(*args, **kwargs)
        self.__packages = generatePackages(battlePass=self.__battlePassController)
        self.__setGeneralFields()
        self.__setPackages()
        if g_BPBuyViewStates.chapterID != WINDOW_IS_NOT_OPENED:
            self.__choosePackage({'packageID': g_BPBuyViewStates.getPackageID()})
        g_BPBuyViewStates.reset()
        switchHangarOverlaySoundFilter(on=True)

    def _finalize(self):
        g_eventBus.removeListener(BattlePassEvent.AWARD_VIEW_CLOSE, self.__onAwardViewClose, EVENT_BUS_SCOPE.LOBBY)
        switchHangarOverlaySoundFilter(on=False)
        self.__selectedPackage = None
        self.__tooltipItems = None
        self.__packages = None
        self.__tooltipWindow = None
        super(BattlePassBuyView, self)._finalize()
        return

    def _getEvents(self):
        return (
         (
          self.viewModel.choosePackage, self.__choosePackage),
         (
          self.viewModel.showConfirm, self.__showConfirm),
         (
          self.viewModel.showRewards, self.__showRewards),
         (
          self.viewModel.onBackClick, self.__onBackClick),
         (
          self.viewModel.onShopOfferClick, self.__onShopOfferClick),
         (
          self.viewModel.confirm.onShowRewardsClick, self.__showRewards),
         (
          self.viewModel.confirm.onBuyClick, self.__onBuyBattlePassClick),
         (
          self.__battlePassController.onLevelUp, self.__onLevelUp),
         (
          self.__wallet.onWalletStatusChanged, self.__onWalletChanged),
         (
          self.__battlePassController.onBattlePassSettingsChange, self.__onBattlePassSettingsChanged),
         (
          self.__battlePassController.onSeasonStateChanged, self.__onBattlePassSettingsChanged),
         (
          self.__battlePassController.onExtraChapterExpired, self.__onExtraChapterExpired))

    def _getListeners(self):
        return (
         (
          BattlePassEvent.BUYING_THINGS, self.__onBuying, EVENT_BUS_SCOPE.LOBBY),)

    def __setGeneralFields(self):
        with self.viewModel.transaction() as (tx):
            tx.setIsWalletAvailable(self.__wallet.isAvailable)
            tx.setIsShopOfferAvailable(self.__isShopOfferAvailable())

    def __clearTooltips(self):
        self.__tooltipItems.clear()
        if self.__tooltipWindow is not None:
            self.__tooltipWindow.destroy()
            self.__tooltipWindow = None
        return

    def __onBackClick(self):
        if self.viewModel.getState() == self.viewModel.CONFIRM_STATE:
            self.__showBuy()
        elif self.__backCallback is not None:
            self.__backCallback()
        else:
            self.destroyWindow()
        return

    def __showConfirm(self):
        self.__setConfirmModel()
        self.viewModel.setState(self.viewModel.CONFIRM_STATE)
        SoundGroups.g_instance.playSound2D(BattlePassSounds.CONFIRM_BUY)

    def __showRewards(self):
        self.viewModel.setState(self.viewModel.REWARDS_STATE)

    def __showBuy(self):
        self.__selectedPackage = None
        self.__clearTooltips()
        self.viewModel.setState(self.viewModel.BUY_STATE)
        return

    def __onBuying(self, _):
        self.__battlePassController.onLevelUp += self.__onLevelUp

    def __onAwardViewClose(self, _):
        self.destroyWindow()

    def __onLevelUp(self):
        self.__updateState()

    def __onWalletChanged(self, _):
        self.viewModel.setIsWalletAvailable(self.__wallet.isAvailable)

    def __updateState(self):
        if self.viewModel.getState() == self.viewModel.CONFIRM_STATE:
            self.__setConfirmModel()
        elif self.viewModel.getState() == self.viewModel.BUY_STATE:
            self.__setPackages()
        elif self.viewModel.getState() == self.viewModel.REWARDS_STATE:
            self.__updateDetailRewards()
        else:
            self.__setPackages()

    def __choosePackage(self, args):
        self.__packageID = int(args.get('packageID'))
        self.__selectedPackage = self.__packages[self.__packageID]
        self.__showConfirm()

    def __setConfirmModel(self):
        if self.__selectedPackage is None:
            return
        else:
            self.__clearTooltips()
            chapterID = self.__selectedPackage.getChapterID()
            self.viewModel.confirm.setPrice(self.__selectedPackage.getPrice())
            self.viewModel.confirm.setChapterID(chapterID)
            self.viewModel.confirm.setIsExtra(self.__battlePassController.isExtraChapter(chapterID))
            isChapterActive = self.__selectedPackage.getChapterState() in (ChapterState.ACTIVE, ChapterState.COMPLETED)
            self.viewModel.confirm.setIsActive(isChapterActive)
            self.__updateDetailRewards()
            return

    def __updateDetailRewards(self):
        chapterID = self.__selectedPackage.getChapterID()
        fromLevel = 1
        toLevel = self.__selectedPackage.getCurrentLevel()
        with self.viewModel.rewards.transaction() as (tx):
            tx.nowRewards.clearItems()
            tx.futureRewards.clearItems()
            tx.setFromLevel(fromLevel)
            tx.setToLevel(toLevel)
            tx.setChapterID(chapterID)
            tx.setPackageState(PackageType.BATTLEPASS)
        packBonusModelAndTooltipData(self.__selectedPackage.getNowAwards(), self.viewModel.rewards.nowRewards, self.__tooltipItems)
        packBonusModelAndTooltipData(self.__selectedPackage.getFutureAwards(), self.viewModel.rewards.futureRewards, self.__tooltipItems)

    def __onBuyBattlePassClick(self):
        if self.__selectedPackage is not None:
            self.__battlePassController.onLevelUp -= self.__onLevelUp
            BattlePassBuyer.buyBP(self.__selectedPackage.getSeasonID(), chapterID=self.__selectedPackage.getChapterID(), onBuyCallback=self.__onBuyBPCallback)
        return

    def __onBuyBPCallback(self, result):
        if not result:
            self.__battlePassController.onLevelUp += self.__onLevelUp
        else:
            self.__setPackages()
            self.__setGeneralFields()
            g_eventBus.addListener(BattlePassEvent.AWARD_VIEW_CLOSE, self.__onAwardViewClose, EVENT_BUS_SCOPE.LOBBY)

    def __isShopOfferAvailable(self):
        return not any(package.isBought() and not package.isExtra() for package in self.__packages.itervalues())

    def __onShopOfferClick(self):
        showShop(getBuyBattlePassUrl())
        self.destroyWindow()

    @replaceNoneKwargsModel
    def __setPackages(self, model=None):
        model.packages.clearItems()
        for packageID, package in self.__packages.iteritems():
            if not package.isVisible():
                continue
            item = PackageItem()
            item.setPackageID(packageID)
            item.setPrice(package.getPrice())
            item.setIsBought(package.isBought())
            item.setType(PackageType.BATTLEPASS)
            item.setIsLocked(package.isLocked())
            item.setChapterID(package.getChapterID())
            item.setIsExtra(package.isExtra())
            item.setChapterState(_CHAPTER_STATES.get(package.getChapterState()))
            item.setCurrentLevel(package.getCurrentLevel() + 1)
            item.setExpireTime(self.__battlePassController.getChapterRemainingTime(package.getChapterID()))
            model.packages.addViewModel(item)

        model.packages.invalidate()

    def __onBattlePassSettingsChanged(self, *_):
        self.__update()

    def __onExtraChapterExpired(self):
        self.__update()

    def __update(self):
        ctrl = self.__battlePassController
        if ctrl.isPaused():
            showMissionsBattlePass(R.views.lobby.battle_pass.ChapterChoiceView())
            self.destroyWindow()
            return
        if not (ctrl.isEnabled() and ctrl.isActive()):
            showHangar()
            return
        if len(ctrl.getChapterIDs()) != self.viewModel.packages.getItemsLength():
            self.__packages = generatePackages(battlePass=ctrl)
            self.__setPackages()
        isValidState = not self.__packageID or ctrl.isChapterExists(self.__packageID) and (not ctrl.isExtraChapter(self.__packageID) or ctrl.getChapterRemainingTime(self.__packageID) > 0)
        allBought = all(ctrl.isBought(chID) for chID in ctrl.getChapterIDs())
        if not isValidState or allBought:
            showMissionsBattlePass(R.views.lobby.battle_pass.ChapterChoiceView())
            self.destroyWindow()
            return
        self.__updateState()


class BattlePassBuyWindow(LobbyWindow):
    __slots__ = ()

    def __init__(self, ctx, parent):
        super(BattlePassBuyWindow, self).__init__(content=BattlePassBuyView(R.views.lobby.battle_pass.BattlePassBuyView(), wsFlags=ViewFlags.LOBBY_TOP_SUB_VIEW, ctx=ctx), wndFlags=WindowFlags.WINDOW, decorator=None, parent=parent)
        return