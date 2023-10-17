import WWISE
from account_helpers.AccountSettings import AccountSettings, HW23_ARTEFACT_VOICEOVER_MUTED
from adisp import adisp_process
from frameworks.wulf import ViewSettings, ViewFlags, WindowStatus
from gui.impl import backport
from gui.impl.dialogs import dialogs
from gui.impl.gen import R
from gui.impl.backport import BackportTooltipWindow, createTooltipData
from gui.impl.lobby.common.tooltips.extended_text_tooltip import ExtendedTextTooltip
from gui.impl.pub.dialog_window import DialogButtons
from gui.prb_control.entities.base.ctx import PrbAction
from halloween.gui.game_control.halloween_artefacts_controller import compareBonuses
from halloween.gui.halloween_gui_constants import PREBATTLE_ACTION_NAME
from gui.shared.event_dispatcher import showVehiclePreview, selectVehicleInHangar
from halloween.gui.impl.gen.view_models.views.lobby.bonus_item_view_model import BonusItemViewModel
from gui.server_events.awards_formatters import AWARDS_SIZES
from halloween.gui.impl.gen.view_models.views.lobby.artefact_view_model import ArtefactViewModel, ArtefactStates
from halloween.gui.impl.gen.view_models.views.lobby.meta_view_model import MetaViewModel
from halloween.gui.impl.lobby.base_view import BaseView
from halloween.gui.impl.lobby.battle_result_view import BattleResultView
from halloween.gui.impl.lobby.dialogs.dialogs import OpenArtefactDialogBuilder, SkipArtefactDialogBuilder
from halloween.gui.impl.lobby.difficulty_window_view import DifficultyWindowView
from halloween.gui.impl.lobby.hw_helpers.bonuses_formatters import HalloweenBonusesAwardsComposer, getHWMetaAwardFormatter, getImgName
from halloween.gui.impl.lobby.king_reward_congrats_view import KingRewardCongratsView
from halloween.gui.impl.lobby.reward_window_view import RewardWindowView
from halloween.gui.impl.lobby.tooltips.key_tooltip import KeyTooltipView
from halloween.gui.impl.lobby.tooltips.not_enough_key_tooltip import NotEnoughKeyTooltipView
from halloween.gui.impl.lobby.tooltips.rewards_tooltip import RewardsTooltipView
from halloween.gui.impl.lobby.tooltips.video_tooltip import VideoTooltipView
from halloween.gui.impl.lobby.widgets.keys_view import KeysView
from halloween.gui.shared.event_dispatcher import showMetaIntroView, showHangarWithFade, showMetaView, showIntroVideo, showBundleWindow
from halloween.gui.sounds import playSound
from halloween.gui.sounds.sound_constants import META_ENTER, META_EXIT, META_PREVIEW_ENTER, ArtefactDialogState, META_QUANTUM_SOUND, MetaViewState
from halloween.skeletons.halloween_artefacts_controller import IHalloweenArtefactsController
from halloween.skeletons.halloween_controller import IHalloweenController
from halloween.skeletons.halloween_shop_controller import IHalloweenShopController
from halloween_common.halloween_constants import ArtefactsSettings
from helpers import dependency
from ids_generators import SequenceIDGenerator
from shared_utils import first
from skeletons.gui.impl import IGuiLoader
from wg_async import wg_await, wg_async
_R_BACKPORT_TOOLTIP = R.views.common.tooltip_window.backport_tooltip_content.BackportTooltipContent()
ALL_VIDEO_KEY = 'hwAllVideo'
_IGNORE_WINDOW = (
 R.views.halloween.lobby.DifficultyWindowView(),
 R.views.halloween.lobby.BattleResultView(),
 R.views.halloween.lobby.RewardWindowView(),
 R.views.halloween.lobby.KingRewardCongratsView())

class MetaView(BaseView):
    __slots__ = ()
    layoutID = R.views.halloween.lobby.MetaView()
    _MAX_BONUSES_IN_VIEW = 5
    _guiLoader = dependency.descriptor(IGuiLoader)
    _hwController = dependency.descriptor(IHalloweenController)
    _hwShopController = dependency.descriptor(IHalloweenShopController)
    _hwArtifactsCtrl = dependency.descriptor(IHalloweenArtefactsController)

    def __init__(self, layoutID=None, artifactID=None):
        settings = ViewSettings(layoutID or self.layoutID, ViewFlags.LOBBY_SUB_VIEW, MetaViewModel())
        super(MetaView, self).__init__(settings)
        self.__idGen = SequenceIDGenerator()
        self.__bonusCache = {}
        self.__artefactID = artifactID
        self.setChildView(resourceID=R.views.halloween.lobby.widgets.KeysView(), view=KeysView())

    def createToolTip(self, event):
        if event.contentID == _R_BACKPORT_TOOLTIP:
            tooltipId = event.getArgument('tooltipId')
            bonus = self.__bonusCache.get(tooltipId)
            if bonus:
                window = BackportTooltipWindow(createTooltipData(tooltip=bonus.tooltip, isSpecial=bonus.isSpecial, specialAlias=bonus.specialAlias, specialArgs=bonus.specialArgs), self.getParentWindow())
                window.load()
                return window
        return super(MetaView, self).createToolTip(event)

    def createToolTipContent(self, event, contentID):
        if contentID == R.views.halloween.lobby.tooltips.KeyTooltip():
            return KeyTooltipView(isPostBattle=False)
        if contentID == R.views.halloween.lobby.tooltips.VideoTooltip():
            return VideoTooltipView()
        if contentID == R.views.halloween.lobby.tooltips.RewardsTooltip():
            artefactId = event.getArgument('artefactId')
            artefact = self._hwArtifactsCtrl.getArtefact(artefactId)
            return RewardsTooltipView(rewards=artefact.bonusRewards)
        if contentID == R.views.halloween.lobby.tooltips.NotEnoughKeyTooltip():
            price = event.getArgument('price', 0)
            return NotEnoughKeyTooltipView(price)
        if contentID == R.views.lobby.common.tooltips.ExtendedTextTooltip():
            text = event.getArgument('text', '')
            stringifyKwargs = event.getArgument('stringifyKwargs', '')
            return ExtendedTextTooltip(text, stringifyKwargs)
        return super(MetaView, self).createToolTipContent(event, contentID)

    @property
    def viewModel(self):
        return super(MetaView, self).getViewModel()

    def selectArtefact(self, artefactID):
        self.__artefactID = artefactID
        self.__setSoundState()
        with self.viewModel.transaction() as (tx):
            self.__fillSelectedArtefact(tx)

    def _onLoading(self, *args, **kwargs):
        super(MetaView, self)._onLoading()
        self.__fillAllViewModel()

    def _initialize(self):
        super(MetaView, self)._initialize()
        showMetaIntroView(forceOpen=False, parent=self.getParentWindow())
        playSound(META_ENTER)
        self.__playArtefactSound()

    def _finalize(self):
        playSound(META_EXIT)
        super(MetaView, self)._finalize()

    def _getEvents(self):
        return [
         (
          self._guiLoader.windowsManager.onWindowStatusChanged, self.__windowStatusChanged),
         (
          self.viewModel.onOpenAbout, self.__onOpenAbout),
         (
          self.viewModel.onOpenIntro, self.__onOpenIntro),
         (
          self.viewModel.onClose, self.__onClose),
         (
          self.viewModel.onOpenArtefact, self.__onOpenArtefact),
         (
          self.viewModel.onSkipArtefact, self.__onSkipArtefact),
         (
          self.viewModel.onChangeArtefact, self.__onChangeArtefact),
         (
          self.viewModel.onOpenPreview, self.__onOpenPreview),
         (
          self.viewModel.onMuteSound, self.__onMuteSound),
         (
          self._hwArtifactsCtrl.onArtefactStatusUpdated, self.__onArtefactStatusUpdated),
         (
          self._hwArtifactsCtrl.onArtefactSettingsUpdated, self.__onSettingsUpdate),
         (
          self._hwArtifactsCtrl.onArtefactKeyUpdated, self.__onArtefactKeyUpdated),
         (
          self._hwShopController.onBundlesUpdated, self.__onBundleUpdated)]

    def __onSettingsUpdate(self):
        self.__fillAllViewModel()

    def __onArtefactStatusUpdated(self, _):
        self.__fillAllViewModel()
        self.__setSoundState()

    def __onArtefactKeyUpdated(self):
        with self.viewModel.transaction() as (tx):
            self.__fillSelectedArtefact(tx)

    def __onBundleUpdated(self):
        with self.viewModel.transaction() as (tx):
            self.__fillSelectedArtefact(tx)

    def __setSoundState(self):
        if self._hwArtifactsCtrl.isArtefactReceived(self.__artefactID):
            WWISE.WW_setState(MetaViewState.GROUP, MetaViewState.RECIVED)
        elif self._hwArtifactsCtrl.isArtefactOpened(self.__artefactID):
            WWISE.WW_setState(MetaViewState.GROUP, MetaViewState.COMPLETED)
        else:
            WWISE.WW_setState(MetaViewState.GROUP, MetaViewState.INPROGRESS)

    @wg_async
    def __onSkipArtefact(self):
        artefact = self._hwArtifactsCtrl.getArtefact(self.__artefactID)
        if artefact.skipPrice.amount > self._hwArtifactsCtrl.getArtefactKeyQuantity():
            showBundleWindow(artefact.skipPrice.amount, self.__skipArtefact)
        else:
            result = yield wg_await(dialogs.show(SkipArtefactDialogBuilder(price=artefact.skipPrice.amount).build()))
            WWISE.WW_setState(ArtefactDialogState.GROUP, ArtefactDialogState.UI_UNVISIBLE)
            if result.result == DialogButtons.SUBMIT:
                self.__skipArtefact()

    @adisp_process
    def __skipArtefact(self):
        yield self._hwArtifactsCtrl.openArtefact(self.__artefactID, True)

    @wg_async
    def __onOpenArtefact(self):
        artefact = self._hwArtifactsCtrl.getArtefact(self.__artefactID)
        if artefact.decodePrice.amount > self._hwArtifactsCtrl.getArtefactKeyQuantity():
            showBundleWindow(artefact.decodePrice.amount, self.__openArtefact)
        else:
            result = yield wg_await(dialogs.show(OpenArtefactDialogBuilder(price=artefact.decodePrice.amount).build()))
            WWISE.WW_setState(ArtefactDialogState.GROUP, ArtefactDialogState.UI_UNVISIBLE)
            if result.result == DialogButtons.SUBMIT:
                self.__openArtefact()

    @adisp_process
    def __openArtefact(self):
        yield self._hwArtifactsCtrl.openArtefact(self.__artefactID, False)

    def __onChangeArtefact(self, args):
        artefactID = args.get('artefactID', None)
        if artefactID is not None:
            self.selectArtefact(artefactID)
            self.__playArtefactSound()
        return

    def __fillAllViewModel(self):
        with self.viewModel.transaction() as (tx):
            self.__fillCoreViewModel(tx)
            self.__fillFinalArtefact(tx)
            self.__fillSelectedArtefact(tx)
            tx.setIsMuted(AccountSettings.getSessionSettings(HW23_ARTEFACT_VOICEOVER_MUTED))

    def __fillCoreViewModel(self, tx):
        artefacts = self._hwArtifactsCtrl.regularArtefacts()
        if not artefacts:
            return
        else:
            if self.__artefactID is None:
                for artefact in artefacts:
                    if self._hwArtifactsCtrl.isArtefactReceived(artefact.artefactID) and not self._hwArtifactsCtrl.isArtefactOpened(artefact.artefactID):
                        self.__artefactID = artefact.artefactID
                        break
                    if not self._hwArtifactsCtrl.isArtefactReceived(artefact.artefactID) and not self._hwArtifactsCtrl.isArtefactOpened(artefact.artefactID):
                        self.__artefactID = artefact.artefactID
                        break

                if self.__artefactID is None:
                    self.__artefactID = artefacts[0].artefactID
                if self._hwArtifactsCtrl.getCurrentArtefactProgress() >= self._hwArtifactsCtrl.getMaxArtefactsProgress():
                    self.__artefactID = self._hwArtifactsCtrl.getFinalArtefact().artefactID
            self.__fillArtefact(tx.selectedArtefact, self._hwArtifactsCtrl.getArtefact(self.__artefactID))
            currProgress = self._hwArtifactsCtrl.getCurrentArtefactProgress()
            maxProgress = self._hwArtifactsCtrl.getMaxArtefactsProgress()
            tx.setCurrentProgress(currProgress)
            tx.setMaxProgress(maxProgress)
            tx.setIsCompleted(currProgress >= maxProgress)
            artefactsVM = tx.getArtefacts()
            artefactsVM.clear()
            for artefact in artefacts:
                artefactVM = ArtefactViewModel()
                self.__fillArtefact(artefactVM, artefact)
                artefactsVM.addViewModel(artefactVM)

            artefactsVM.invalidate()
            return

    def __fillBonuses(self, rewardsVM, bonusRewards):
        rewardsVM.clear()
        if not bonusRewards:
            return
        formatter = HalloweenBonusesAwardsComposer(self._MAX_BONUSES_IN_VIEW, getHWMetaAwardFormatter())
        bonusRewards = formatter.getFormattedBonuses(bonusRewards, AWARDS_SIZES.BIG)
        for bonus in sorted(bonusRewards, cmp=compareBonuses, key=lambda b: b.bonusName):
            tooltipId = ('{}').format(self.__idGen.next())
            self.__bonusCache[tooltipId] = bonus
            reward = BonusItemViewModel()
            if self._hwArtifactsCtrl.getIsHiddenBonusStyle(bonus):
                continue
            reward.setName(bonus.bonusName)
            reward.setValue(str(bonus.label))
            reward.setIcon(getImgName(bonus.getImage(AWARDS_SIZES.BIG)))
            reward.setOverlayType(bonus.getOverlayType(AWARDS_SIZES.SMALL))
            reward.setTooltipId(tooltipId)
            if bonus.bonusName == ArtefactsSettings.ARTEFACT:
                reward.setTooltipContentId(str(R.views.halloween.lobby.tooltips.VideoTooltip()))
            rewardsVM.addViewModel(reward)

        rewardsVM.invalidate()

    def __fillArtefact(self, artefactVM, artefact):
        artefactID, decodePrice, skipPrice, bonusRewards, questConditions, artefactTypes, difficulty = artefact
        artefactVM.setId(artefactID)
        artefactVM.setQuestName(questConditions.name)
        artefactVM.setQuestDescr(questConditions.description)
        artefactVM.setQuestProgress(questConditions.progress)
        artefactVM.setQuestMaxProgress(questConditions.totalValue)
        artefactVM.setDifficulty(difficulty)
        state = ArtefactStates.INPROGRESS
        if self._hwArtifactsCtrl.isArtefactReceived(artefactID):
            state = ArtefactStates.RECIVE
        else:
            if self._hwArtifactsCtrl.isArtefactOpened(artefactID):
                state = ArtefactStates.OPEN
            artefactVM.setState(state)
            types = artefactVM.getTypes()
            types.clear()
            for artefactType in artefactTypes:
                types.addString(artefactType)

        artefactVM.setSkipPrice(skipPrice.amount)
        artefactVM.setDecodePrice(decodePrice.amount)
        if state == ArtefactStates.INPROGRESS:
            artefactVM.setIsMoneyEnough(self.__checkPriceAndBundles(skipPrice))
        elif state == ArtefactStates.RECIVE:
            artefactVM.setIsMoneyEnough(self.__checkPriceAndBundles(decodePrice))
        else:
            artefactVM.setIsMoneyEnough(True)
        self.__fillBonuses(artefactVM.getRewards(), bonusRewards)

    def __checkPriceAndBundles(self, price):
        keyCount = self._hwArtifactsCtrl.getArtefactKeyQuantity()
        return self._hwShopController.checkIsEnoughBundles() or price.amount <= keyCount

    def __fillFinalArtefact(self, tx):
        self.__fillArtefact(tx.finalArtefact, self._hwArtifactsCtrl.getFinalArtefact())

    def __fillSelectedArtefact(self, tx):
        self.__fillArtefact(tx.selectedArtefact, self._hwArtifactsCtrl.getArtefact(self.__artefactID))

    def __onOpenAbout(self):
        showMetaIntroView(forceOpen=True, parent=self.getParentWindow())

    def __onOpenIntro(self):
        showIntroVideo()

    def __onOpenPreview(self):
        mainVehicle = self._hwArtifactsCtrl.getMainGiftVehicle()
        if not mainVehicle:
            return
        else:
            if mainVehicle.isInInventory:
                selectVehicleInHangar(mainVehicle.intCD)
            else:
                if mainVehicle.isRestorePossible():
                    self.__selectRandomBattle()
                backLable = R.strings.halloween_lobby.meta.backTasks()
                if self.__artefactID == self._hwArtifactsCtrl.getFinalArtefact().artefactID:
                    backLable = R.strings.halloween_lobby.meta.backToFinal()
                playSound(META_PREVIEW_ENTER)
                style = self._hwArtifactsCtrl.getMainGiftStyle()
                showVehiclePreview(vehTypeCompDescr=mainVehicle.intCD, backBtnLabel=backport.text(backLable), previewBackCb=self.__backProcessing, isHiddenMenu=True, outfit=style.getOutfit(first(style.seasons), vehicleCD=mainVehicle.descriptor.makeCompactDescr()) if style else None)
            return

    @adisp_process
    def __selectRandomBattle(self):
        dispatcher = self.prbDispatcher
        if dispatcher is not None:
            yield dispatcher.doSelectAction(PrbAction(PREBATTLE_ACTION_NAME.RANDOM))
        return

    @adisp_process
    def __selectEventBattle(self):
        dispatcher = self.prbDispatcher
        if dispatcher is not None:
            yield dispatcher.doSelectAction(PrbAction(PREBATTLE_ACTION_NAME.HALLOWEEN))
        return

    def __backProcessing(self):
        if not self._hwController.isEventHangar():
            self.__selectEventBattle()
        showMetaView(artifactID=self.__artefactID)

    def __onClose(self):
        showHangarWithFade()

    def __onMuteSound(self):
        isMuted = AccountSettings.getSessionSettings(HW23_ARTEFACT_VOICEOVER_MUTED)
        AccountSettings.setSessionSettings(HW23_ARTEFACT_VOICEOVER_MUTED, not isMuted)
        self.viewModel.setIsMuted(not isMuted)

    def __windowStatusChanged(self, uniqueID, newStatus):
        if newStatus == WindowStatus.DESTROYING:
            window = self._guiLoader.windowsManager.getWindow(uniqueID)
            if window is None or window.content is None:
                return
            if newStatus == WindowStatus.DESTROYING:
                if isinstance(window.content, (RewardWindowView, BattleResultView,
                 DifficultyWindowView, KingRewardCongratsView)):
                    self.__playArtefactSound(skipStatus=True)
        return

    def __checkIsOpened(self):
        for layoutID in _IGNORE_WINDOW:
            view = self._guiLoader.windowsManager.getViewByLayoutID(layoutID)
            if view is not None:
                return True

        return False

    def __playArtefactSound(self, skipStatus=False):
        if not skipStatus and self.__checkIsOpened():
            return
        if not self._hwArtifactsCtrl.isArtefactOpened(self.__artefactID):
            return
        playSound(META_QUANTUM_SOUND.format(self._hwArtifactsCtrl.getIndex(self.__artefactID)))