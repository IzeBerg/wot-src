import logging, typing
from account_helpers.AccountSettings import LOOT_BOXES_WAS_STARTED
from event_lootboxes.gui.impl.lobby.event_lootboxes.entry_point_view import EventLootBoxesEntryPointTooltipView
from event_lootboxes.gui.impl.lobby.event_lootboxes.popover import EventLootBoxesPopover
from helpers.statistics import HARDWARE_SCORE_PARAMS
from Event import Event
from adisp import adisp_process
from gui.shared.gui_items.loot_box import EVENT_LOOT_BOXES_CATEGORY
from skeletons.gui.game_control import IExternalLinksController, IEventLootBoxesController
import wg_async
from cosmic_account_settings import setResearchDoneViewDisplayed, isResearchDoneViewDisplayed, setLobbyOpened, getLobbyOpened
from cosmic_event.gui.battle_results import CosmicBattleResultEvent
from cosmic_event.gui.game_control.announcer_controller import AnnouncerEvents
from cosmic_event.gui.gui_constants import SCH_CLIENT_MSG_TYPE
from cosmic_event.gui.impl.gen.view_models.views.lobby.cosmic_lobby_view.cosmic_lobby_view_model import CosmicLobbyViewModel, LobbyRouteEnum, PerformanceRiskEnum
from cosmic_event.gui.impl.gen.view_models.views.lobby.cosmic_lobby_view.mission_model import MissionModel
from cosmic_event.gui.impl.lobby.quest_helpers import fillDailyQuestModel, getDailyQuestModelFromQuest
from cosmic_event.gui.impl.lobby.quest_packer import getCosmicBonusPacker
from cosmic_event.gui.shared.utils.performance_analyzer import PerformanceAnalyzerMixin, PerformanceGroup, LimitType
from cosmic_event.skeletons.announcer_controller import IAnnouncerController
from cosmic_event.skeletons.battle_controller import ICosmicEventBattleController
from cosmic_event.skeletons.cosmic_fading_controller import ICosmicFadingController
from cosmic_event.skeletons.progression_controller import ICosmicEventProgressionController
from cosmic_event_common.cosmic_event_common import ScoreEvents
from cosmic_sound import CosmicHangarSounds
from frameworks.wulf import ViewFlags, ViewSettings, WindowLayer
from gui import GUI_SETTINGS
from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.impl import backport
from gui.impl.gen import R
from gui.impl.gen.view_models.views.lobby.crew.common.tooltip_constants import TooltipConstants
from gui.impl.gen.view_models.views.lobby.crew.tooltips.perk_available_tooltip_model import PerkAvailableTooltipModel
from gui.impl.gui_decorators import args2params
from gui.impl.lobby.common.view_helpers import packBonusModelAndTooltipData
from gui.impl.lobby.common.view_mixins import LobbyHeaderVisibility
from gui.impl.lobby.common.view_wrappers import createBackportTooltipDecorator
from gui.impl.pub import ViewImpl
from gui.impl.wrappers.function_helpers import replaceNoneKwargsModel
from gui.prb_control.dispatcher import g_prbLoader
from gui.prb_control.entities.base.ctx import PrbAction
from gui.prb_control.settings import PREBATTLE_ACTION_NAME
from gui.shared import EVENT_BUS_SCOPE, g_eventBus
from gui.shared.event_dispatcher import showBrowserOverlayView
from gui.shared.system_factory import collectBattleQueueProvider
from helpers import dependency
from skeletons.gui.app_loader import IAppLoader
from skeletons.gui.impl import INotificationWindowController, IGuiLoader
from skeletons.gui.server_events import IEventsCache
from skeletons.gui.shared import IItemsCache
from skeletons.gui.system_messages import ISystemMessages
if typing.TYPE_CHECKING:
    from typing import Tuple, Sequence, Callable, Optional, List, Dict
    from gui.shared.gui_items.Vehicle import Vehicle
    from gui.server_events.event_items import Quest
    from cosmic_event.gui.game_control.battle_controller import CosmicEventBattleController
    from cosmic_event.gui.impl.gen.view_models.views.lobby.cosmic_lobby_view.progression_model import ProgressionModel
    from gui.shared.missions.packers.bonus import BonusUIPacker
    from cosmic_event.gui.Scaleform.daapi.view.lobby.cosmic_battle_queue import CosmicEventQueueProvider
_logger = logging.getLogger(__name__)
_SCORE_EVENTS_TO_ORDERED_LIST = [
 ScoreEvents.KILL_ASSIST,
 ScoreEvents.KILL,
 ScoreEvents.ABILITY_PICKUP,
 ScoreEvents.RAMMING,
 ScoreEvents.SHOT,
 ScoreEvents.ABILITY_HIT,
 ScoreEvents.FRAGMENT_PICKUP,
 ScoreEvents.FRAGMENT_CARRYING,
 ScoreEvents.FRAGMENT_HOLDER_KILL,
 ScoreEvents.FRAGMENT_DELIVERING,
 ScoreEvents.EVACUATION]
PERFORMANCE_MAP = {PerformanceGroup.LOW_RISK: PerformanceRiskEnum.LOWRISK, 
   PerformanceGroup.MEDIUM_RISK: PerformanceRiskEnum.MEDIUMRISK, 
   PerformanceGroup.HIGH_RISK: PerformanceRiskEnum.HIGHRISK, 
   PerformanceGroup.VERY_HIGH_RISK: PerformanceRiskEnum.VERYHIGHRISK}
PERFORMANCE_GROUP_LIMITS = {PerformanceGroup.VERY_HIGH_RISK: [{LimitType.HARDWARE_PARAMS: {HARDWARE_SCORE_PARAMS.PARAM_GPU_SCORE: 350}}], PerformanceGroup.HIGH_RISK: [{LimitType.HARDWARE_PARAMS: {HARDWARE_SCORE_PARAMS.PARAM_GPU_SCORE: 500}}], PerformanceGroup.MEDIUM_RISK: [{LimitType.HARDWARE_PARAMS: {HARDWARE_SCORE_PARAMS.PARAM_GPU_SCORE: 900}}]}

def _getScoreEventListOrder(eventName):
    return _SCORE_EVENTS_TO_ORDERED_LIST.index(ScoreEvents[eventName])


class _DefaultPerksTooltip(ViewImpl):

    def __init__(self):
        settings = ViewSettings(R.views.lobby.crew.tooltips.PerkAvailableTooltip())
        settings.model = PerkAvailableTooltipModel()
        super(_DefaultPerksTooltip, self).__init__(settings)

    @property
    def viewModel(self):
        return super(_DefaultPerksTooltip, self).getViewModel()

    def _onLoading(self, *args, **kwargs):
        super(_DefaultPerksTooltip, self)._onLoading()
        with self.viewModel.transaction() as (vm):
            vm.setPerkCount(1)
            vm.setLastPerkLevel(100)
            vm.setZeroPerkCount(0)


class CosmicLobbyView(ViewImpl, LobbyHeaderVisibility, PerformanceAnalyzerMixin):
    __slots__ = ('__tooltipData', '__toolTipMgr', '__currentRoute', '_previouslySeenPoints_postBattleOpenedAfterBattle',
                 '__queueProvider')
    _cosmicController = dependency.descriptor(ICosmicEventBattleController)
    _cosmicProgression = dependency.descriptor(ICosmicEventProgressionController)
    _itemsCache = dependency.descriptor(IItemsCache)
    __systemMessages = dependency.descriptor(ISystemMessages)
    _notificationMgr = dependency.descriptor(INotificationWindowController)
    _eventsCache = dependency.descriptor(IEventsCache)
    _uiLoader = dependency.descriptor(IGuiLoader)
    _announcerController = dependency.descriptor(IAnnouncerController)
    _appLoader = dependency.descriptor(IAppLoader)
    _fadeManager = dependency.descriptor(ICosmicFadingController)
    _externalBrowserCtrl = dependency.descriptor(IExternalLinksController)
    _eventLootboxesCtrl = dependency.descriptor(IEventLootBoxesController)

    def __init__(self, layoutID):
        _logger.debug('[CosmicLobbyView] created')
        settings = ViewSettings(layoutID)
        settings.flags = ViewFlags.LOBBY_SUB_VIEW
        settings.model = CosmicLobbyViewModel()
        super(CosmicLobbyView, self).__init__(settings)
        self.__toolTipMgr = self._appLoader.getApp().getToolTipMgr()
        self.__tooltipData = {}
        self.__currentRoute = self._cosmicController.getLobbyRoute()
        self.__queueProvider = None
        self._postBattleOpenedAfterBattle = False
        g_eventBus.addListener(CosmicBattleResultEvent.POST_BATTLE_SCREEN_OPENING, self._postBattleOpening, scope=EVENT_BUS_SCOPE.LOBBY)
        return

    @property
    def viewModel(self):
        return super(CosmicLobbyView, self).getViewModel()

    def createToolTip(self, event):
        if event.contentID == R.views.common.tooltip_window.backport_tooltip_content.BackportTooltipContent():
            if event.getArgument('tooltipId') == TooltipConstants.SKILL:
                self.__toolTipMgr.onCreateWulfTooltip(TOOLTIPS_CONSTANTS.CREW_PERK_GF, (event.getArgument('skillName'), 0), event.mouse.positionX, event.mouse.positionY, parent=self.getParentWindow())
                return TOOLTIPS_CONSTANTS.CREW_PERK_GF
        return self._createBackPortTooltip(event)

    def getQueueProvider(self):
        qType = self._cosmicController.prbEntity.getQueueType()
        providerClass = collectBattleQueueProvider(qType)
        return providerClass(self, qType)

    def getTooltipData(self, event):
        tooltipId = event.getArgument('tooltipId')
        if tooltipId is None:
            return
        else:
            data = self.__tooltipData.get(tooltipId)
            return data

    def createToolTipContent(self, event, contentID):
        if contentID == R.views.lobby.crew.tooltips.PerkAvailableTooltip():
            return _DefaultPerksTooltip()
        if contentID == R.views.event_lootboxes.lobby.event_lootboxes.tooltips.LootBoxesTooltip():
            return EventLootBoxesEntryPointTooltipView()
        if contentID == R.views.event_lootboxes.lobby.event_lootboxes.tooltips.EntryPointTooltip():
            return EventLootBoxesEntryPointTooltipView()
        return super(CosmicLobbyView, self).createToolTipContent(event=event, contentID=contentID)

    def _initialize(self, *args, **kwargs):
        super(CosmicLobbyView, self)._initialize(*args, **kwargs)
        CosmicHangarSounds.playLobbyEnter()
        if not getLobbyOpened():
            self._showInfoPage()
            self._eventLootboxesCtrl.setSetting(EVENT_LOOT_BOXES_CATEGORY, LOOT_BOXES_WAS_STARTED, True)
        self._announcerController.processProgressFinished()
        self._announcerController.startQueuePlay()
        self.suspendLobbyHeader(self.uniqueID)

    def _getEvents(self):
        return (
         (
          self.viewModel.onLobbyRouteChange, self.onLobbyRouteChange),
         (
          self.viewModel.onClose, self.onClose),
         (
          self.viewModel.onAboutEvent, self.onAboutEvent),
         (
          self.viewModel.onGetRewardsClick, self.__onGetRewardsClick),
         (
          self._itemsCache.onSyncCompleted, self._onItemSyncCompleted),
         (
          self._cosmicProgression.onProgressPointsUpdated, self._fillModel),
         (
          self._cosmicController.onLobbyRouteChange, self.onLobbyRouteChangeImpl),
         (
          self._eventsCache.onSyncCompleted, self._onEventSyncCompleted),
         (
          self._announcerController.onAnnouncerPlay, self._onAnnouncerPlay))

    def _onLoading(self, *args, **kwargs):
        _logger.debug('[CosmicLobbyView] loading')
        super(CosmicLobbyView, self)._onLoading(*args, **kwargs)
        self._fillModel(self.__currentRoute)

    def _onLoaded(self, *args, **kwargs):
        super(CosmicLobbyView, self)._onLoaded(*args, **kwargs)
        if self._notificationMgr.isEnabled():
            self._notificationMgr.releasePostponed()
        self._fadeManager.hide()

    @createBackportTooltipDecorator()
    def _createBackPortTooltip(self, event):
        return super(CosmicLobbyView, self).createToolTip(event)

    def _fillModel(self, newRoute=None):
        _logger.debug('[CosmicLobbyView] filling model, route %s', newRoute)
        with self.viewModel.transaction() as (model):
            model.setLobbyRoute(newRoute or self.__currentRoute)
            currentPoints, limitPoints = self._cosmicProgression.getProgression()
            model.setEventPoints(currentPoints)
            model.setEventPointsLimit(limitPoints)
            currentStage, maxStage = self._cosmicProgression.getStageProgress()
            model.setFragmentLimit(maxStage)
            model.setFragmentCount(currentStage)
            model.setFadeOut(False)
            model.setIsResearchDone(isResearchDoneViewDisplayed())
            performanceGroup = self.getPerformanceGroup(PERFORMANCE_GROUP_LIMITS)
            model.setPerformanceGroup(PERFORMANCE_MAP.get(performanceGroup, PerformanceRiskEnum.MEDIUMRISK))
            if newRoute == LobbyRouteEnum.MAIN or newRoute in self._cosmicProgression.PROGRESSION_ROUTE:
                self._fillMissionsModel(model=model)
                self._fillProgression(model=model)
            self._updateVehicleState(model=model)

    def _fillProgression(self, model):
        packer = getCosmicBonusPacker(forProgression=True)
        progression = self._cosmicProgression.getBonuses()
        progressionArray = model.getProgression()
        progressionArray.clear()
        progressionArray.reserve(len(progression))
        self.__tooltipData = {}
        prevPoints = 0
        for pointsCondition, bonuses, isCompleted in progression:
            progressionModel = model.getProgressionType()()
            progressionModel.setEventPoints(pointsCondition - prevPoints)
            prevPoints = pointsCondition
            progressionModel.setIsRewardGranted(isCompleted)
            _logger.debug('[cosmic progression] condition: %s, bonuses: %s', pointsCondition, bonuses)
            bonusArray = progressionModel.getBonuses()
            bonusArray.clear()
            bonusArray.reserve(len(bonuses))
            packBonusModelAndTooltipData(bonuses, bonusArray, self.__tooltipData, packer)
            bonusArray.invalidate()
            progressionArray.addViewModel(progressionModel)

        progressionArray.invalidate()

    def _getScoreSystem(self):
        scoreSystem = self._cosmicController.getModeSettings().scoreSystem
        return scoreSystem.scoreEventsUpper.items()

    @replaceNoneKwargsModel
    def _fillMissionsModel(self, model=None):
        quests = self._cosmicProgression.collectSortedDailyQuests()
        missionsModel = model.getMissions()
        missionsModel.clear()
        missionsModel.reserve(len(quests))
        for quest in quests.values():
            dailyQuestModel = MissionModel()
            fullQuestModel = getDailyQuestModelFromQuest(quest)
            fillDailyQuestModel(dailyQuestModel, fullQuestModel)
            missionsModel.addViewModel(dailyQuestModel)
            fullQuestModel.unbind()

        missionsModel.invalidate()

    def _finalize(self):
        _logger.debug('[CosmicLobbyView] finalizing')
        self.resumeLobbyHeader(self.uniqueID)
        CosmicHangarSounds.playLobbyExit()
        self._announcerController.stopQueuePlay()
        g_eventBus.removeListener(CosmicBattleResultEvent.POST_BATTLE_SCREEN_OPENING, self._postBattleOpening, scope=EVENT_BUS_SCOPE.LOBBY)
        if self.__queueProvider:
            self.__queueProvider.stop()
            self.__queueProvider = None
        super(CosmicLobbyView, self)._finalize()
        return

    def onLobbyRouteChangeImpl(self, newRoute):
        if self.__currentRoute == newRoute:
            return
        _logger.debug('[CosmicLobbyView] onLobbyRoute changed - %s', newRoute)
        CosmicHangarSounds.handleLobbyRouteChange(self.__currentRoute, newRoute)
        if newRoute == LobbyRouteEnum.QUEUE:
            if not self.__queueProvider:
                self.__queueProvider = self.getQueueProvider()
            self.__queueProvider.start()
        elif newRoute == LobbyRouteEnum.RESEARCH:
            if not isResearchDoneViewDisplayed():
                self.__systemMessages.proto.serviceChannel.pushClientMessage({}, SCH_CLIENT_MSG_TYPE.COSMIC_COMPLETED)
                setResearchDoneViewDisplayed()
        if self.__currentRoute == LobbyRouteEnum.QUEUE:
            self._onQueueLeave()
        self.__currentRoute = newRoute
        self._fillModel(self.__currentRoute)
        self._cosmicController.setLobbyRoute(self.__currentRoute)

    @args2params(str)
    def onLobbyRouteChange(self, newRoute):
        self.onLobbyRouteChangeImpl(LobbyRouteEnum(newRoute))

    @wg_async.wg_async
    def onClose(self):
        _logger.debug('[CosmicLobbyView] close button clicked')
        yield wg_async.wg_await(self._fadeManager.show())
        self.closeLobby()

    @adisp_process
    def closeLobby(self, *args, **kwargs):
        dispatcher = g_prbLoader.getDispatcher()
        result = yield dispatcher.doSelectAction(PrbAction(PREBATTLE_ACTION_NAME.RANDOM))
        if result:
            self._cosmicController.setLobbyRoute(LobbyRouteEnum.MAIN)
            self.destroyWindow()
            self._fadeManager.hide()

    def onAboutEvent(self, *args, **kwargs):
        _logger.debug('[CosmicLobbyView] info button clicked')
        self._showInfoPage()

    def __onGetRewardsClick(self, *args, **kwargs):
        self._externalBrowserCtrl.open(GUI_SETTINGS.cosmicArtifactRewardURL)

    @replaceNoneKwargsModel
    def _updateVehicleState(self, model=None):
        vehicle = self._cosmicController.getEventVehicle()
        if vehicle:
            model.setIsVehicleInBattle(vehicle.isInBattle)

    def _onItemSyncCompleted(self, *_):
        self._updateVehicleState()

    def _onEventSyncCompleted(self, *_):
        self._fillMissionsModel()

    def _onAnnouncerPlay(self, textKey, lineDuration):
        with self.viewModel.announcer.transaction() as (tx):
            tx.setText(backport.text(R.strings.cosmicEvent.announcer.lobby.dyn(textKey)()))
            tx.setTime(lineDuration * 1000)

    def _onInfoPageClosed(self):
        if not getLobbyOpened():
            self._announcerController.addToQueue(AnnouncerEvents.FIRST_LOGIN)
            setLobbyOpened(True)

    def _getWelcomePageURL(self):
        return GUI_SETTINGS.cosmicWelcomePageURL

    def _showInfoPage(self):
        url = self._getWelcomePageURL()
        showBrowserOverlayView(url, VIEW_ALIAS.WEB_VIEW_TRANSPARENT, callbackOnClose=self._onInfoPageClosed, hiddenLayers=(
         WindowLayer.MARKER, WindowLayer.VIEW, WindowLayer.WINDOW))

    def _postBattleOpening(self, *args, **kwargs):
        self._postBattleOpenedAfterBattle = True

    def _onQueueLeave(self):
        self._cosmicController.leaveQueue()
        if self.__queueProvider:
            self.__queueProvider.stop()
            self.__queueProvider = None
        return

    def setPlayersCount(self, count):
        with self.viewModel.queue.transaction() as (tx):
            tx.setPlayersInQueue(count)

    def createPopOverContent(self, event):
        return EventLootBoxesPopover()