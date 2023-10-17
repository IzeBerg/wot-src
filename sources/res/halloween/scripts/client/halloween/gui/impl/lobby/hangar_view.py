import logging, WWISE, BigWorld
from functools import partial
from CurrentVehicle import g_currentVehicle
from PlayerEvents import g_playerEvents
from HeroTank import HeroTank
from frameworks.wulf import ViewFlags, ViewSettings, WindowLayer, WindowStatus
from gui.ClientUpdateManager import g_clientUpdateManager
from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
from gui.Scaleform.daapi.view.lobby.LobbyMenu import LobbyMenu
from gui.Scaleform.daapi.view.lobby.header.LobbyHeader import HeaderMenuVisibilityState
from gui.Scaleform.framework.managers.containers import POP_UP_CRITERIA
from gui.Scaleform.framework.managers.loaders import SFViewLoadParams
from gui.app_loader import sf_lobby
from gui.impl.gen import R
from gui.impl.lobby.common.tooltips.extended_text_tooltip import ExtendedTextTooltip
from gui.impl.lobby.tank_setup.ammunition_setup.base_hangar import BaseHangarAmmunitionSetupView
from gui.impl.pub.fade_manager import DefaultFadingCover
from gui.impl.pub.selectable_view_impl import SelectableViewImpl, notifyCursorOver3DScene
from gui.prb_control import prb_getters
from gui.shared.events import AmmunitionPanelViewEvent
from gui.shared.utils import SelectorBattleTypesUtils
from gui.hangar_cameras.hangar_camera_common import CameraRelatedEvents
from gui.shared import EVENT_BUS_SCOPE, g_eventBus, events
from gui.hangar_cameras.hangar_camera_common import CameraMovementStates
from halloween.gui.halloween_gui_constants import PREBATTLE_ACTION_NAME
from halloween.gui.impl.gen.view_models.views.lobby.hangar_view_model import HangarViewModel
from halloween.gui.impl.gen.view_models.views.lobby.vehicle_title_view_model import VehicleTypes
from halloween.gui.impl.lobby import updateHeaderMenu, getVehicleState
from halloween.gui.impl.lobby.difficulty_window_view import DifficultyWindowView
from halloween.gui.impl.lobby.hw_ammunition_panel_view import HWAmmunitionPanelView
from halloween.gui.impl.lobby.widgets.carousel_view import CarouselView
from halloween.gui.impl.lobby.widgets.difficulty_view import DifficultyView
from halloween.gui.impl.lobby.widgets.keys_view import KeysView
from halloween.gui.shared.event_dispatcher import showMetaView, showHalloweenShopVehicle, showHalloweenShopAll, showHWHangarAmmunitionSetupView, showIntroVideo, showInfoPage, showComparisonWindow, showHeroTankPreview
from halloween.skeletons.halloween_artefacts_controller import IHalloweenArtefactsController
from halloween.skeletons.halloween_controller import IHalloweenController
from halloween.gui.sounds.sound_constants import HangarDragState, HANGAR_SOUND_SETTINGS
from helpers import dependency
from helpers.CallbackDelayer import CallbackDelayer
from skeletons.gui.app_loader import IAppLoader
from skeletons.gui.impl import IGuiLoader
_BACKGROUND_ALPHA = 0.0
_logger = logging.getLogger(__name__)
_CHECK_LAYERS = (
 WindowLayer.OVERLAY,
 WindowLayer.TOP_WINDOW,
 WindowLayer.FULLSCREEN_WINDOW,
 WindowLayer.TOP_SUB_VIEW)

class HangarView(SelectableViewImpl):
    _appLoader = dependency.descriptor(IAppLoader)
    _guiLoader = dependency.descriptor(IGuiLoader)
    _hwController = dependency.descriptor(IHalloweenController)
    _hwArtifactsCtrl = dependency.descriptor(IHalloweenArtefactsController)
    _TIMEOUT_SELECTION_ENABLE = 2
    _COMMON_SOUND_SPACE = HANGAR_SOUND_SETTINGS

    def __init__(self, layoutID=R.views.halloween.lobby.HangarView()):
        settings = ViewSettings(layoutID)
        settings.flags = ViewFlags.LOBBY_SUB_VIEW
        settings.model = HangarViewModel()
        super(HangarView, self).__init__(settings)
        self.__isUnitJoiningInProgress = False
        self.__timer = None
        self.__timerEnable3DSelect = None
        self.__ammoPanel = HWAmmunitionPanelView()
        self._headerMenuVisibilityRestore = False
        return

    @property
    def viewModel(self):
        return super(HangarView, self).getViewModel()

    def createContextMenu(self, event):
        if self.__ammoPanel is not None:
            return self.__ammoPanel.createContextMenu(event)
        else:
            return super(HangarView, self).createContextMenu(event)

    def createToolTipContent(self, event, contentID):
        if contentID == R.views.lobby.common.tooltips.ExtendedTextTooltip():
            text = event.getArgument('text', '')
            stringifyKwargs = event.getArgument('stringifyKwargs', '')
            return ExtendedTextTooltip(text, stringifyKwargs)
        return super(HangarView, self).createToolTipContent(event, contentID)

    def _onLoading(self, *args, **kwargs):
        super(HangarView, self)._onLoading()
        self.__timer = CallbackDelayer()
        self.__timerEnable3DSelect = CallbackDelayer()
        app = self._appLoader.getApp()
        app.setBackgroundAlpha(_BACKGROUND_ALPHA)
        self._setComponents()
        self.__fillMetaWidget()
        self.__fillVehicleName()
        notifyCursorOver3DScene(True)

    def _onLoaded(self, *args, **kwargs):
        super(HangarView, self)._onLoaded(*args, **kwargs)
        updateHeaderMenu(HeaderMenuVisibilityState.NOTHING)
        self._headerMenuVisibilityRestore = True
        if not SelectorBattleTypesUtils.isKnownBattleType(PREBATTLE_ACTION_NAME.HALLOWEEN):
            showIntroVideo()
            SelectorBattleTypesUtils.setBattleTypeAsKnown(PREBATTLE_ACTION_NAME.HALLOWEEN)
        self.__timerEnable3DSelect.delayCallback(self._TIMEOUT_SELECTION_ENABLE, lambda : self._hangarSpace.setVehicleSelectable(True))

    def _finalize(self):
        if self._headerMenuVisibilityRestore:
            updateHeaderMenu(HeaderMenuVisibilityState.ALL)
        self._headerMenuVisibilityRestore = False
        notifyCursorOver3DScene(False)
        super(HangarView, self)._finalize()

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
          self.viewModel.onComparisonClick, self.__onComporisonClick),
         (
          self.viewModel.onMetaClick, self.__onMetaClick),
         (
          self.viewModel.onShopClick, self.__onShopClick),
         (
          self.viewModel.vehicleTitle.onTasksClick, self.__onTasksClick),
         (
          self.viewModel.vehicleTitle.onPacksClick, self.__onPacksClick),
         (
          self.viewModel.onDragging, self.__onDragging),
         (
          self._hwArtifactsCtrl.onArtefactStatusUpdated, self.__onArtefactStatusUpdated),
         (
          self._hwArtifactsCtrl.onArtefactSettingsUpdated, self.__onVehicleRentChange),
         (
          g_currentVehicle.onChanged, self.__onCurrentVehicleChanged)]

    def _subscribe(self):
        super(HangarView, self)._subscribe()
        unitMgr = prb_getters.getClientUnitMgr()
        if unitMgr:
            unitMgr.onUnitJoined += self.__onUnitJoined
        g_eventBus.addListener(AmmunitionPanelViewEvent.SECTION_SELECTED, self.__onTankSetupChange, scope=EVENT_BUS_SCOPE.LOBBY)
        g_eventBus.addListener(CameraRelatedEvents.CAMERA_ENTITY_UPDATED, self.__handleSelectedEntityUpdated)

    def _unsubscribe(self):
        g_eventBus.removeListener(CameraRelatedEvents.CAMERA_ENTITY_UPDATED, self.__handleSelectedEntityUpdated)
        g_eventBus.removeListener(AmmunitionPanelViewEvent.SECTION_SELECTED, self.__onTankSetupChange, scope=EVENT_BUS_SCOPE.LOBBY)
        g_clientUpdateManager.removeObjectCallbacks(self)
        unitMgr = prb_getters.getClientUnitMgr()
        if unitMgr:
            unitMgr.onUnitJoined -= self.__onUnitJoined
        if self.__timer is not None:
            self.__timer.clearCallbacks()
            self.__timer = None
        if self.__timerEnable3DSelect:
            self.__timerEnable3DSelect.clearCallbacks()
            self.__timerEnable3DSelect = None
        super(HangarView, self)._unsubscribe()
        return

    def _setComponents(self):
        self.setChildView(resourceID=R.views.halloween.lobby.widgets.CarouselView(), view=CarouselView())
        self.setChildView(resourceID=R.views.halloween.lobby.widgets.KeysView(), view=KeysView())
        self.setChildView(resourceID=R.views.halloween.lobby.widgets.DifficultyView(), view=DifficultyView())
        self.setChildView(resourceID=R.views.halloween.lobby.widgets.TankSetupView(), view=self.__ammoPanel)

    def _onCursorOver3DScene(self, args=None):
        hasOverlappingWindows = self.__hasOverlappingWindows()
        pre = self._guiLoader.windowsManager.getViewByLayoutID(R.views.halloween.lobby.PreBattleQueueView())
        if pre:
            return
        if not hasOverlappingWindows:
            super(HangarView, self)._onCursorOver3DScene(args)

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

    def __onArtefactStatusUpdated(self, *args):
        self.__fillMetaWidget()

    def __onVehicleRentChange(self, *args):
        self.__fillVehicleName()

    @sf_lobby
    def __app(self):
        return

    def __fillMetaWidget(self):
        with self.viewModel.transaction() as (tx):
            maxProgress = self._hwArtifactsCtrl.getMaxArtefactsProgress()
            currentProgress = self._hwArtifactsCtrl.getCurrentArtefactProgress()
            tx.setMaxProgress(maxProgress)
            tx.setCurrentProgress(currentProgress)
            tx.setIsCompleted(currentProgress >= maxProgress)

    def __fillVehicleName(self):
        vehicle = g_currentVehicle.item
        if vehicle is not None:
            with self.viewModel.transaction() as (tx):
                tx.vehicleTitle.setName(vehicle.userName)
                tx.vehicleTitle.setDescription(vehicle.fullDescription)
                tx.vehicleTitle.setVehicleState(getVehicleState(vehicle))
                tx.vehicleTitle.setVehicleType(VehicleTypes(vehicle.type) if vehicle.type != '' else VehicleTypes.NONE)
        return

    def __onExitClick(self):
        self._hwController.selectRandomMode()

    def __onComporisonClick(self):
        showComparisonWindow()

    def __onAboutClick(self):
        showInfoPage()

    def __onMetaClick(self):
        showMetaView()

    def __onShopClick(self):
        showHalloweenShopAll()

    def __onTasksClick(self):
        vehicle = g_currentVehicle.item
        if not vehicle:
            return
        showMetaView(artifactID=self._hwArtifactsCtrl.getArtefactIDForAccessToVehicle(vehicle.intCD))

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
            self.__fillVehicleName()
            return

    def __onTankSetupChange(self, event):
        ctx = event.ctx
        if self._hangarSpace.spaceLoading():
            _logger.warning('Optional Device click was not handled (kwargs=%s). HangarSpace is currently  loading.', ctx)
        elif not self.__isUnitJoiningInProgress:
            with self.viewModel.transaction() as (tx):
                tx.setIsLoadedSetup(True)
            showHWHangarAmmunitionSetupView(**ctx)

    def __onDragging(self, args):
        isDragging = args.get('isDragging')
        if isDragging:
            WWISE.WW_setState(HangarDragState.GROUP, HangarDragState.UI_UNVISIBLE)
        else:
            WWISE.WW_setState(HangarDragState.GROUP, HangarDragState.UI_VISIBLE)

    def __windowStatusChanged(self, uniqueID, newStatus):
        hasOverlappingWindows = self.__hasOverlappingWindows(uniqueID if newStatus == WindowStatus.CREATED else None)
        if hasOverlappingWindows:
            for wnd in hasOverlappingWindows:
                if wnd.content is not None and isinstance(wnd.content, DefaultFadingCover):
                    break
                notifyCursorOver3DScene(False)

        if newStatus == WindowStatus.DESTROYING:
            window = self._guiLoader.windowsManager.getWindow(uniqueID)
            if window.content is None:
                return
            if isinstance(window.content, (LobbyMenu, DifficultyWindowView)):
                notifyCursorOver3DScene(True)
                return
            if isinstance(window.content, BaseHangarAmmunitionSetupView):
                with self.viewModel.transaction() as (tx):
                    tx.setIsLoadedSetup(False)
                return
        return

    @staticmethod
    def __isOverlappingWindow(excludedUniqueId, window):
        return window.uniqueID != excludedUniqueId and window.windowStatus in (WindowStatus.LOADING, WindowStatus.LOADED) and window.layer in _CHECK_LAYERS

    def __hasOverlappingWindows(self, excludedUniqueId=None):
        return self._guiLoader.windowsManager.findWindows(partial(self.__isOverlappingWindow, excludedUniqueId))

    def __handleSelectedEntityUpdated(self, event):
        ctx = event.ctx
        if ctx['state'] != CameraMovementStates.FROM_OBJECT:
            entity = BigWorld.entities.get(ctx['entityId'], None)
            if isinstance(entity, HeroTank):
                descriptor = entity.typeDescriptor
                vehicleCD = descriptor.type.compactDescr
                showHeroTankPreview(vehicleCD)
        return