import logging, typing
from CurrentVehicle import g_currentVehicle, g_currentPreviewVehicle
from PlayerEvents import g_playerEvents
from halloween.gui.impl.gen.view_models.views.lobby.artefact_types_view_model import ArtefactTypesViewModel
from halloween.gui.impl.gen.view_models.views.lobby.widgets.hangar_carousel_def_view_model import VehicleStates
from halloween.gui.impl.lobby.widgets.carousel_def_view import CarouselDefView
from halloween.skeletons.difficulty_level_controller import IDifficultyLevelController
from shared_utils import first
from frameworks.wulf import ViewFlags, ViewSettings, WindowLayer, WindowStatus
from notification import NotificationMVC
from gui.ClientUpdateManager import g_clientUpdateManager
from gui.game_loading.resources.consts import Milestones
from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
from gui.Scaleform.framework.managers.containers import POP_UP_CRITERIA
from gui.Scaleform.framework.managers.loaders import SFViewLoadParams
from gui.app_loader import sf_lobby
from gui.impl import backport
from gui.impl.gen import R
from gui.impl.lobby.common.tooltips.extended_text_tooltip import ExtendedTextTooltip
from gui.impl.lobby.tank_setup.ammunition_setup.base_hangar import BaseHangarAmmunitionSetupView
from gui.prb_control import prb_getters
from gui.shared.events import AmmunitionPanelViewEvent
from gui.shared.utils import SelectorBattleTypesUtils
from gui.shared import EVENT_BUS_SCOPE, g_eventBus, events
from account_helpers.settings_core.settings_constants import OnceOnlyHints
from halloween.gui.halloween_gui_constants import PREBATTLE_ACTION_NAME
from halloween.gui.impl.gen.view_models.views.lobby.hangar_view_model import HangarViewModel
from halloween.gui.impl.gen.view_models.views.lobby.vehicle_title_view_model import VehicleTypes
from halloween.gui.impl.lobby import getVehicleState, getDefVehicalState
from halloween.gui.impl.lobby.hw_ammunition_panel_view import HWAmmunitionPanelView
from halloween.gui.impl.lobby.widgets.carousel_view import CarouselView
from halloween.gui.impl.lobby.widgets.difficulty_view import DifficultyView
from halloween.gui.impl.lobby.widgets.keys_view import KeysView
from halloween.gui.impl.lobby.widgets.meta_view import MetaWidgetView
from halloween.gui.shared.event_dispatcher import showRewardPathView, showHalloweenShopVehicle, showHalloweenShopAll, showHWHangarAmmunitionSetupView, showIntroVideo, showInfoPage, showHangar, showComparisonWindow, showVehiclePreview, selectVehicleInHangarWithFade, showHwLeaderboard
from halloween.skeletons.halloween_artefacts_controller import IHalloweenArtefactsController
from halloween.skeletons.halloween_controller import IHalloweenController
from halloween.gui.sounds.sound_constants import HANGAR_SOUND_SETTINGS
from helpers import dependency, int2roman
from helpers.CallbackDelayer import CallbackDelayer
from skeletons.gui.app_loader import IAppLoader
from skeletons.gui.impl import IGuiLoader, INotificationWindowController
from skeletons.gui.shared.utils import IHangarSpace
from halloween.gui.impl.lobby.base_view import BaseView
from skeletons.account_helpers.settings_core import ISettingsCore
from halloween.gui.shared import isHalloweenDefenceSelected
from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
if typing.TYPE_CHECKING:
    from halloween.gui.game_control.halloween_artefacts_controller import Artefact
_BACKGROUND_ALPHA = 0.0
_AMMO_PANEL_TOOLTIP_IDS = (TOOLTIPS_CONSTANTS.HANGAR_SLOT_SPEC,)
_logger = logging.getLogger(__name__)

class HangarView(BaseView):
    _POP_UP_PADDING_X = 5
    _POP_UP_PADDING_Y = 207
    _appLoader = dependency.descriptor(IAppLoader)
    _guiLoader = dependency.descriptor(IGuiLoader)
    _hwController = dependency.descriptor(IHalloweenController)
    _hwArtefactsCtrl = dependency.descriptor(IHalloweenArtefactsController)
    _hangarSpace = dependency.descriptor(IHangarSpace)
    _notificationMgr = dependency.descriptor(INotificationWindowController)
    _settingsCore = dependency.descriptor(ISettingsCore)
    _difficultyController = dependency.descriptor(IDifficultyLevelController)
    _COMMON_SOUND_SPACE = HANGAR_SOUND_SETTINGS

    def __init__(self, layoutID=R.views.halloween.lobby.HangarView(), artefactID=None):
        settings = ViewSettings(layoutID)
        settings.flags = ViewFlags.LOBBY_SUB_VIEW
        settings.model = HangarViewModel()
        super(HangarView, self).__init__(settings)
        self.__isUnitJoiningInProgress = False
        self.__timer = None
        self.__ammoPanel = None
        self.__metaWidget = None
        self.__prevOptimizationEnabled = False
        self.__selectedMissionIndex = 1
        self.__selectedArtefactID = artefactID
        self.__needSlideToNext = False
        return

    @property
    def viewModel(self):
        return super(HangarView, self).getViewModel()

    def createContextMenu(self, event):
        if self.__ammoPanel is not None:
            return self.__ammoPanel.createContextMenu(event)
        else:
            return super(HangarView, self).createContextMenu(event)

    def createToolTip(self, event):
        dialogsContainer = self.__app.containerManager.getContainer(WindowLayer.TOP_WINDOW)
        if dialogsContainer.getView(criteria={POP_UP_CRITERIA.VIEW_ALIAS: VIEW_ALIAS.LOBBY_MENU}):
            return
        else:
            tooltipID = event.getArgument('tooltip')
            if self.__ammoPanel is not None and tooltipID in _AMMO_PANEL_TOOLTIP_IDS:
                return self.__ammoPanel.createToolTip(event)
            return super(HangarView, self).createToolTip(event)

    def createToolTipContent(self, event, contentID):
        if contentID == R.views.lobby.common.tooltips.ExtendedTextTooltip():
            text = event.getArgument('text', '')
            stringifyKwargs = event.getArgument('stringifyKwargs', '')
            return ExtendedTextTooltip(text, stringifyKwargs)
        return super(HangarView, self).createToolTipContent(event, contentID)

    def selectSlideByArtefact(self, artefactID):
        self.viewModel.setSelectedSlide(self._hwArtefactsCtrl.getIndex(artefactID))

    def selectNextSlide(self):
        self.__needSlideToNext = True

    def updateSlide(self):
        self.__prepareSelectedArtefact()
        self.__fillCore()

    def _onLoading(self, *args, **kwargs):
        super(HangarView, self)._onLoading()
        self.__timer = CallbackDelayer()
        app = self._appLoader.getApp()
        app.setBackgroundAlpha(_BACKGROUND_ALPHA)
        self.__ammoPanel = HWAmmunitionPanelView()
        self.__metaWidget = MetaWidgetView(parent=self)
        self._setComponents()
        self.__prepareSelectedArtefact()
        self.__fillCore()
        self.__fillMetaWidget()
        self.__fillGiftVehicle()
        self.__metaWidget.updateData(int(self.__selectedMissionIndex))
        self.__updateVehicleLocked()
        self.__setCarousel()
        if isHalloweenDefenceSelected():
            self.__fillVehicleTitle()
        self.__prevOptimizationEnabled = app.graphicsOptimizationManager.getEnable()
        if self.__prevOptimizationEnabled:
            app.graphicsOptimizationManager.switchOptimizationEnabled(False)

    def _onLoaded(self, *args, **kwargs):
        super(HangarView, self)._onLoaded(*args, **kwargs)
        if g_currentPreviewVehicle is not None:
            g_currentPreviewVehicle.selectNoVehicle()
        if not SelectorBattleTypesUtils.isKnownBattleType(PREBATTLE_ACTION_NAME.HALLOWEEN):
            showIntroVideo()
            SelectorBattleTypesUtils.setBattleTypeAsKnown(PREBATTLE_ACTION_NAME.HALLOWEEN)
        if self._hangarSpace.spaceInited:
            self.__updateNotificationsLayout()
        else:
            g_playerEvents.onLoadingMilestoneReached += self.__onLoadingMilestoneReached
        return

    def _finalize(self):
        app = self._appLoader.getApp()
        if self.__prevOptimizationEnabled:
            app.graphicsOptimizationManager.switchOptimizationEnabled(True)
        notificationsModel = NotificationMVC.g_instance.getModel()
        if notificationsModel is not None:
            notificationsModel.onPopUpPaddingChanged(False)
        self.__ammoPanel = None
        self.__metaWidget = None
        super(HangarView, self)._finalize()
        return

    def _getEvents(self):
        return [
         (
          g_playerEvents.onPrebattleInvitationAccepted, self.__onPrebattleInvitationAccepted),
         (
          self._guiLoader.windowsManager.onWindowStatusChanged, self.__windowStatusChanged),
         (
          self.viewModel.onEscPressed, self.__onEscape),
         (
          self.viewModel.onExitClick, self.__onExitClick),
         (
          self.viewModel.onAboutClick, self.__onAboutClick),
         (
          self.viewModel.onMetaClick, self.__onMetaClick),
         (
          self.viewModel.onShopClick, self.__onShopClick),
         (
          self.viewModel.onTasksClick, self.__onTasksClick),
         (
          self.viewModel.onPacksClick, self.__onPacksClick),
         (
          self.viewModel.onViewLoaded, self.__onViewLoaded),
         (
          self.viewModel.onSlide, self.__onSlide),
         (
          self.viewModel.onPreview, self.__onPreview),
         (
          self.viewModel.onComparisonClick, self.__onComporisonClick),
         (
          self.viewModel.onLeaderboardClick, self.__onLeaderboardClick),
         (
          self._hwArtefactsCtrl.onArtefactStatusUpdated, self.__onArtefactStatusUpdated),
         (
          self._hwArtefactsCtrl.onArtefactSettingsUpdated, self.__onArtefactSettingsUpdated),
         (
          self._difficultyController.onChangeDifficultyLevel, self.__onDifficultyChange),
         (
          g_currentVehicle.onChanged, self.__onCurrentVehicleChanged),
         (
          g_currentPreviewVehicle.onChanged, self.__onCurrentVehicleChanged)]

    def _subscribe(self):
        super(HangarView, self)._subscribe()
        unitMgr = prb_getters.getClientUnitMgr()
        if unitMgr:
            unitMgr.onUnitJoined += self.__onUnitJoined
        g_eventBus.addListener(AmmunitionPanelViewEvent.SECTION_SELECTED, self.__onTankSetupChange, scope=EVENT_BUS_SCOPE.LOBBY)
        g_clientUpdateManager.addCallbacks({'cache.vehsLock': self.__onVehicleLockUpdated})

    def _unsubscribe(self):
        g_eventBus.removeListener(AmmunitionPanelViewEvent.SECTION_SELECTED, self.__onTankSetupChange, scope=EVENT_BUS_SCOPE.LOBBY)
        g_clientUpdateManager.removeObjectCallbacks(self)
        unitMgr = prb_getters.getClientUnitMgr()
        if unitMgr:
            unitMgr.onUnitJoined -= self.__onUnitJoined
        if self.__timer is not None:
            self.__timer.clearCallbacks()
            self.__timer = None
        g_playerEvents.onLoadingMilestoneReached -= self.__onLoadingMilestoneReached
        super(HangarView, self)._unsubscribe()
        return

    def _setComponents(self):
        self.setChildView(resourceID=R.views.halloween.lobby.widgets.KeysView(), view=KeysView())
        self.setChildView(resourceID=R.views.halloween.lobby.widgets.DifficultyView(), view=DifficultyView())
        self.setChildView(resourceID=R.views.halloween.lobby.widgets.TankSetupView(), view=self.__ammoPanel)
        self.setChildView(resourceID=R.views.halloween.lobby.widgets.MetaView(), view=self.__metaWidget)

    def _onClose(self):
        pass

    def __selectNextSlide(self):
        if self.__metaWidget is not None:
            self.__metaWidget.updateData(int(self.__selectedMissionIndex))
        self.__selectedArtefactID = None
        self.__prepareSelectedArtefact()
        self.viewModel.setSelectedSlide(self.__selectedMissionIndex)
        self.__needSlideToNext = False
        return

    def __prepareSelectedArtefact(self):
        artefacts = self._hwArtefactsCtrl.artefactsSorted()
        if self.__selectedArtefactID is None:
            artefactID = None
            if self._hwArtefactsCtrl.getCurrentArtefactProgress() >= self._hwArtefactsCtrl.getMaxArtefactsProgress():
                artefactID = self._hwArtefactsCtrl.getFinalArtefact().artefactID
            else:
                for artefact in artefacts:
                    if not self._hwArtefactsCtrl.isArtefactOpened(artefact.artefactID):
                        artefactID = artefact.artefactID
                        break

            if artefactID is None:
                artefactID = artefacts[0].artefactID
            self.__selectedMissionIndex = self._hwArtefactsCtrl.getIndex(artefactID)
            self.__selectedArtefactID = artefactID
        else:
            self.__selectedMissionIndex = self._hwArtefactsCtrl.getIndex(self.__selectedArtefactID)
        return

    def __onVehicleLockUpdated(self, *args):
        if g_currentVehicle.item:
            self.viewModel.setIsVehicleInBattle(g_currentVehicle.item.isInBattle)

    def __onPrebattleInvitationAccepted(self, _, __):
        self.__isUnitJoiningInProgress = True
        self.__timer.delayCallback(15, self.__onResetUnitJoiningProgress)

    def __onResetUnitJoiningProgress(self):
        self.__isUnitJoiningInProgress = False

    def __onUnitJoined(self, _, __):
        self.__isUnitJoiningInProgress = False
        if self.__timer is not None:
            self.__timer.stopCallback(self.__onResetUnitJoiningProgress)
        return

    def __onArtefactStatusUpdated(self, _):
        self.__fillMetaWidget()
        if self._hwArtefactsCtrl.isArtefactOpened(self.__selectedArtefactID):
            return
        self.__metaWidget.updateData(int(self.__selectedMissionIndex))

    def __onArtefactSettingsUpdated(self):
        self.__fillCore()
        self.__updateVehicleLocked()

    def __onDifficultyChange(self, _):
        self.viewModel.setIsDefenseMode(isHalloweenDefenceSelected())
        self.__fillVehicleTitle()

    def __setCarousel(self):
        self.setChildView(resourceID=R.views.halloween.lobby.widgets.CarouselDefView(), view=CarouselDefView())
        self.setChildView(resourceID=R.views.halloween.lobby.widgets.CarouselView(), view=CarouselView())

    def __onSlide(self, args):
        if args is None:
            return
        else:
            slideIndex = int(args.get('slide', 1))
            self.viewModel.setSelectedSlide(slideIndex)
            self.__selectedMissionIndex = slideIndex
            self.__selectedArtefactID = self._hwArtefactsCtrl.getArtefactIDByIndex(slideIndex)
            self.__metaWidget.updateData(slideIndex)
            return

    @sf_lobby
    def __app(self):
        return

    def __fillMetaWidget(self):
        with self.viewModel.transaction() as (tx):
            maxProgress = self._hwArtefactsCtrl.getMaxArtefactsProgress()
            currentProgress = self._hwArtefactsCtrl.getCurrentArtefactProgress()
            tx.progress.setMaxProgress(maxProgress)
            tx.progress.setCurrentProgress(currentProgress)
            tx.progress.setIsCompleted(currentProgress >= maxProgress)

    def __fillGiftVehicle(self):
        vehicle = self._hwArtefactsCtrl.getMainGiftVehicle()
        if vehicle is not None:
            with self.viewModel.transaction() as (tx):
                vehGift = tx.mainGiftVehicle
                vehGift.setName(vehicle.userName)
                vehGift.setLevel(int2roman(vehicle.level))
                vehGift.setIsPremium(vehicle.isPremium)
                vehGift.setVehicleType(VehicleTypes(vehicle.type) if vehicle.type != '' else VehicleTypes.NONE)
        return

    def __fillVehicleTitle(self):
        vehicle = g_currentVehicle.item
        with self.viewModel.transaction() as (tx):
            vehicleTitle = tx.vehicleTitle
            tx.setShowRandomLable(False)
            if vehicle is not None:
                if isHalloweenDefenceSelected():
                    vehState = getDefVehicalState(vehicle)
                    tx.setShowRandomLable(vehState == VehicleStates.REPAIR.value or vehState == VehicleStates.CREWINCOMPLETE.value)
                vehicleTitle.setName(vehicle.descriptor.type.shortUserString)
                vehicleTitle.setIsPremium(vehicle.isPremium)
                vehicleTitle.setIsElite(vehicle.isElite)
                vehicleTitle.setIsPremiumIGR(vehicle.isPremiumIGR)
                vehicleTitle.setVehicleType(VehicleTypes(vehicle.type) if vehicle.type != '' else VehicleTypes.NONE)
            else:
                vehicleTitle.setName('')
                vehicleTitle.setIsPremium(False)
                vehicleTitle.setIsElite(False)
                vehicleTitle.setIsPremiumIGR(False)
                vehicleTitle.setVehicleType(VehicleTypes.NONE)
        return

    def __fillCore(self):
        with self.viewModel.transaction() as (tx):
            tx.setIsDefenseMode(isHalloweenDefenceSelected())
            tx.setSelectedSlide(self.__selectedMissionIndex)
            tx.setSlidesCount(self._hwArtefactsCtrl.getArtefactsCount())
            artefacts = tx.getArtefacts()
            artefacts.clear()
            for artefact in self._hwArtefactsCtrl.artefactsSorted():
                artefactType = ArtefactTypesViewModel()
                artefactType.setId(artefact.artefactID)
                artefactType.setIndex(self._hwArtefactsCtrl.getIndex(artefact.artefactID))
                artefactType.setTypes((',').join(artefact.artefactTypes))
                artefacts.addViewModel(artefactType)

    def __updateVehicleLocked(self):
        vehicle = g_currentVehicle.item
        self.viewModel.setIsDefenseMode(isHalloweenDefenceSelected())
        if vehicle is not None:
            vehicleLocked = getVehicleState(vehicle) == VehicleStates.LOCKED
            self.viewModel.setIsVehicleLocked(vehicleLocked)
            if vehicleLocked:
                missionID = self._hwArtefactsCtrl.getArtefactIDForAccessToVehicle(vehicle.intCD)
                if missionID is not None:
                    self.viewModel.setLockedMissionIndex(self._hwArtefactsCtrl.getIndex(missionID))
            self.viewModel.setIsVehicleInBattle(vehicle.isInBattle)
        return

    def __updateNotificationsLayout(self):
        notificationsModel = NotificationMVC.g_instance.getModel()
        if notificationsModel is not None:
            notificationsModel.onPopUpPaddingChanged(True, self._POP_UP_PADDING_X, self._POP_UP_PADDING_Y)
        return

    def __onLoadingMilestoneReached(self, milestoneName):
        if milestoneName == Milestones.HANGAR_READY:
            g_playerEvents.onLoadingMilestoneReached -= self.__onLoadingMilestoneReached
            self.__updateNotificationsLayout()

    def __onExitClick(self):
        self._hwController.selectRandomMode()

    def __onAboutClick(self):
        showInfoPage()

    def __onMetaClick(self):
        showRewardPathView(selectedArtefactID=self.__selectedArtefactID)

    def __onShopClick(self):
        showHalloweenShopAll()

    def __showLastMission(self):
        showHangar(self.__selectedArtefactID)

    def __onComporisonClick(self):
        showComparisonWindow()

    def __onLeaderboardClick(self):
        showHwLeaderboard()
        leaderboardHint = OnceOnlyHints.HALLOWEEN_LEADERBOARD_BTN_HINT
        hintShowed = self._settingsCore.serverSettings.getOnceOnlyHintsSetting(leaderboardHint, default=False)
        if not hintShowed:
            self._settingsCore.serverSettings.setOnceOnlyHintsSettings({leaderboardHint: True})

    def __onPreview(self, args):
        if args.get('isKingReward', False):
            vehicle = self._hwArtefactsCtrl.getMainGiftVehicle()
            if vehicle is not None:
                if not vehicle.isInInventory:
                    style = self._hwArtefactsCtrl.getMainGiftStyle()
                    showVehiclePreview(itemCD=vehicle.intCD, previewBackCb=self.__showLastMission, backBtnLabel=backport.text(R.strings.halloween_lobby.common.toEvent()), outfit=style.getOutfit(first(style.seasons), vehicleCD=vehicle.descriptor.makeCompactDescr()) if style else None, isKingReward=True)
                else:
                    selectVehicleInHangarWithFade(vehicle.intCD)
        elif g_currentVehicle.item:
            showVehiclePreview(itemCD=g_currentVehicle.item.intCD, previewBackCb=showHangar, outfit=g_currentVehicle.item.getOutfit(g_currentVehicle.item.getAnyOutfitSeason()), backBtnLabel=backport.text(R.strings.halloween_lobby.common.toEvent()))
        return

    def __onTasksClick(self):
        vehicle = g_currentVehicle.item
        if not vehicle:
            return
        else:
            missionID = self._hwArtefactsCtrl.getArtefactIDForAccessToVehicle(vehicle.intCD)
            if missionID is None:
                return
            self.__selectedMissionIndex = self._hwArtefactsCtrl.getIndex(missionID)
            self.viewModel.setSelectedSlide(self.__selectedMissionIndex)
            return

    def __onPacksClick(self):
        showHalloweenShopVehicle()

    def __onEscape(self):
        dialogsContainer = self.__app.containerManager.getContainer(WindowLayer.TOP_WINDOW)
        if not dialogsContainer.getView(criteria={POP_UP_CRITERIA.VIEW_ALIAS: VIEW_ALIAS.LOBBY_MENU}):
            g_eventBus.handleEvent(events.LoadViewEvent(SFViewLoadParams(VIEW_ALIAS.LOBBY_MENU)), scope=EVENT_BUS_SCOPE.LOBBY)

    def __onCurrentVehicleChanged(self):
        if g_currentVehicle.item is None:
            return
        else:
            self.__fillVehicleTitle()
            self.__updateVehicleLocked()
            return

    def __onTankSetupChange(self, event):
        ctx = event.ctx
        if self._hangarSpace.spaceLoading():
            _logger.warning('Optional Device click was not handled (kwargs=%s). HangarSpace is currently  loading.', ctx)
        elif not self.__isUnitJoiningInProgress:
            with self.viewModel.transaction() as (tx):
                tx.setIsLoadedSetup(True)
            showHWHangarAmmunitionSetupView(**ctx)

    def __windowStatusChanged(self, uniqueID, newStatus):
        if newStatus == WindowStatus.DESTROYING:
            window = self._guiLoader.windowsManager.getWindow(uniqueID)
            if window.content is None:
                return
            if isinstance(window.content, BaseHangarAmmunitionSetupView):
                with self.viewModel.transaction() as (tx):
                    tx.setIsLoadedSetup(False)
                return
        if newStatus == WindowStatus.DESTROYED:
            if self.__needSlideToNext and self._notificationMgr.activeQueueLength == 0:
                self.__selectNextSlide()
        return

    def __onViewLoaded(self):
        g_eventBus.handleEvent(events.ViewReadyEvent(self.layoutID))