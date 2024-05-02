import logging, typing
from cosmic_constants import PROGRESSION_STAGES_IN_PHASE, PHASE_TO_ASSET
from cosmic_event.gui.game_control.progression_controller import CosmicProgressionController
from cosmic_event.gui.impl.gen.view_models.views.lobby.rewards_view.rewards_view_model import RewardsViewModel
from cosmic_event.gui.impl.lobby.quest_packer import getCosmicBonusPacker
from cosmic_event.skeletons.announcer_controller import IAnnouncerController
from cosmic_event.skeletons.progression_controller import ICosmicEventProgressionController
from event_lootboxes.gui.impl.lobby.event_lootboxes.tooltips.loot_box_tooltip import EventLootBoxTooltip
from frameworks.wulf import ViewFlags, ViewSettings, WindowFlags
from gui.impl import backport
from gui.impl.backport import BackportTooltipWindow
from gui.impl.backport.backport_tooltip import DecoratedTooltipWindow
from gui.impl.gen import R
from gui.impl.lobby.common.view_helpers import packBonusModelAndTooltipData
from gui.impl.lobby.tooltips.additional_rewards_tooltip import AdditionalRewardsTooltip
from gui.impl.pub import ViewImpl
from gui.impl.pub.lobby_window import LobbyNotificationWindow
from gui.shared.gui_items.loot_box import EventLootBoxes
from helpers import dependency
if typing.TYPE_CHECKING:
    from typing import TypeVar, List, Optional, Sequence, Tuple, Callable
    from Event import Event
    from frameworks.wulf import Array
    from gui.server_events.bonuses import SimpleBonus
    from gui.impl.gen.view_models.common.missions.bonuses.bonus_model import BonusModel
    from gui.shared.missions.packers.bonus import BonusUIPacker
    from gui.server_events.event_items import Quest
    from frameworks.wulf import ViewEvent, Window
    SimpleBonusesType = TypeVar('SimpleBonusesType', bound=SimpleBonus)
_logger = logging.getLogger(__name__)

class BonusesView(ViewImpl):
    __slots__ = ('_tooltips', )

    def __init__(self, *args, **kwargs):
        super(BonusesView, self).__init__(*args, **kwargs)
        self._tooltips = {}

    def _initRewardsList(self, model, quests):
        bonuses = self._getBonuses(quests)
        packerFactory = getCosmicBonusPacker()
        bonusArray = model.getRewards()
        bonusArray.clear()
        bonusArray.reserve(len(bonuses))
        packBonusModelAndTooltipData(bonuses, bonusArray, self._tooltips, packerFactory)
        bonusArray.invalidate()

    def _getBonuses(self, quests):
        raise NotImplementedError()

    def createToolTip(self, event):
        if event.contentID == R.views.common.tooltip_window.backport_tooltip_content.BackportTooltipContent():
            tooltipId = event.getArgument('tooltipId')
            window = BackportTooltipWindow(self._tooltips[tooltipId], parent=self.getParentWindow(), event=event) if tooltipId is not None and tooltipId in self._tooltips else None
            if window is not None:
                window.load()
            return window
        if event.contentID == R.views.lobby.tooltips.AdditionalRewardsTooltip():
            showCount = event.getArgument('showCount')
            if showCount is None:
                return
            packedBonuses = self.viewModel.getRewards()[int(showCount):]
            window = DecoratedTooltipWindow(AdditionalRewardsTooltip(packedBonuses), useDecorator=False)
            window.load()
            window.move(event.mouse.positionX, event.mouse.positionY)
            return window
        else:
            return super(BonusesView, self).createToolTip(event)

    def createToolTipContent(self, event, contentID):
        if contentID == R.views.event_lootboxes.lobby.event_lootboxes.tooltips.LootBoxesTooltip():
            return EventLootBoxTooltip(boxType=EventLootBoxes.PREMIUM)
        return super(BonusesView, self).createToolTipContent(event=event, contentID=contentID)


class RewardsView(BonusesView):
    __slots__ = ()
    _cosmicProgression = dependency.descriptor(ICosmicEventProgressionController)
    _announcerController = dependency.descriptor(IAnnouncerController)

    def __init__(self, *args, **kwargs):
        settings = ViewSettings(R.views.cosmic_event.lobby.rewards_view.RewardsView())
        settings.flags = ViewFlags.VIEW
        settings.model = RewardsViewModel()
        settings.args = args
        settings.kwargs = kwargs
        super(RewardsView, self).__init__(settings)

    @property
    def viewModel(self):
        return super(RewardsView, self).getViewModel()

    def _onLoading(self, quests, *args, **kwargs):
        super(RewardsView, self)._onLoading(*args, **kwargs)
        with self.getViewModel().transaction() as (model):
            self._initRewardsList(model, quests)
            self._initTexts(model, quests)

    def _getEvents(self):
        return (
         (
          self.viewModel.onCloseButtonClick, self.onClose),
         (
          self.viewModel.onContinueButtonClick, self.onClose),
         (
          self._announcerController.onAnnouncerPlay, self._onAnnouncerPlay))

    def _initTexts(self, model, quests):
        progressionStage = self._cosmicProgression.getProgressionStage(quests[0])
        if progressionStage is not None:
            model.setTitle(R.strings.cosmicEvent.rewardsView.viewTitle())
            phaseRemainder = progressionStage % PROGRESSION_STAGES_IN_PHASE
            if phaseRemainder == 0:
                model.setSubtitle(R.strings.cosmicEvent.rewardsView.phaseCompleted())
                phaseNumber = progressionStage / PROGRESSION_STAGES_IN_PHASE
                model.setProgressionStage(phaseNumber)
                model.setHeroAsset(PHASE_TO_ASSET[phaseNumber])
            else:
                model.setSubtitle(R.strings.cosmicEvent.rewardsView.stepCompleted())
                model.setProgressionStage(progressionStage)
        else:
            subTitle = R.strings.cosmicEvent.rewardsView.conditionsFulfilledTitle()
            title = R.strings.cosmicEvent.rewardsView.rewardsReceived.title()
            if len(quests) == 1:
                title = R.strings.cosmicEvent.rewardsView.rewardReceived.title()
                subTitle = R.strings.cosmicEvent.rewardsView.rewardReceived.medalReceived()
            model.setSubtitle(subTitle)
            model.setTitle(title)
        return

    def _onAnnouncerPlay(self, textKey, lineDuration):
        with self.getViewModel().announcer.transaction() as (tx):
            tx.setText(backport.text(R.strings.cosmicEvent.announcer.lobby.dyn(textKey)()))
            tx.setTime(lineDuration * 1000)

    def onClose(self, *args, **kwargs):
        self.destroyWindow()

    def _getBonuses(self, quests):
        results = []
        for quest in quests:
            results.extend(quest.getBonuses())

        return results


class RewardsWindow(LobbyNotificationWindow):

    def __init__(self, *args, **kwargs):
        super(RewardsWindow, self).__init__(wndFlags=(WindowFlags.WINDOW | WindowFlags.WINDOW_FULLSCREEN), content=RewardsView(kwargs.pop('quests')), *args, **kwargs)