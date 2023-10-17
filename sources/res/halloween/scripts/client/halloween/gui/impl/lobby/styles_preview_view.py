import CGF, WWISE, BigWorld
from HangarVehicle import HangarVehicle
from halloween.gui.sounds import playSound
from helpers import dependency
from helpers.CallbackDelayer import CallbackDelayer
from items.vehicles import getVehicleType
from frameworks.wulf import ViewSettings, ViewFlags, WindowLayer
from skeletons.gui.impl import IGuiLoader
from skeletons.gui.shared import IItemsCache
from skeletons.gui.hangar_cameras import IHangarCameraSounds
from skeletons.gui.customization import ICustomizationService
from skeletons.account_helpers.settings_core import ISettingsCore
from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.impl import backport
from gui.impl.backport import BackportTooltipWindow, createTooltipData
from gui.impl.gen import R
from gui.impl.pub.selectable_view_impl import SelectableViewImpl
from gui.shared import g_eventBus
from gui.shared.gui_items import GUI_ITEM_TYPE
from gui.shared.gui_items.customization import CustomizationTooltipContext
from gui.hangar_cameras.hangar_camera_common import CameraRelatedEvents
from gui.shared.gui_items.Vehicle import getShortUserName
from gui.Scaleform.daapi.view.lobby.storage.storage_helpers import getVehicleCDForStyle
from gui.shared.event_dispatcher import showHangar
from gui.hangar_cameras.hangar_camera_common import CameraMovementStates
from CurrentVehicle import g_currentPreviewVehicle
from HeroTank import HeroTank
from ClientSelectableCameraObject import ClientSelectableCameraObject
from cgf_components.hangar_styles_components import StylePreviewManager
from account_helpers.settings_core.settings_constants import GRAPHICS
from halloween.gui.impl.gen.view_models.views.lobby.style_card_view_model import StyleCardViewModel
from halloween.gui.impl.gen.view_models.views.lobby.styles_view_model import StylesViewModel
from halloween.gui.impl.lobby.base_view import BaseView
from halloween.gui.shared.event_dispatcher import showHalloweenShopStyles, showHangar as showHalloweenHangar, showHeroTankPreview
from halloween.gui.sounds.sound_constants import StylesPreviewState, STYLE_PREVIEW_WINDOW_ENTER, STYLE_PREVIEW_WINDOW_EXIT

class StylesPreviewView(SelectableViewImpl, BaseView):
    __slots__ = ('__selectedID', )
    _itemsCache = dependency.descriptor(IItemsCache)
    _c11n = dependency.descriptor(ICustomizationService)
    _guiLoader = dependency.descriptor(IGuiLoader)
    _hangarCameraSounds = dependency.descriptor(IHangarCameraSounds)
    _settingsCore = dependency.descriptor(ISettingsCore)
    _TIMEOUT_SELECTION_ENABLE = 2
    _LIGHT_ENV_NAME = 'Env_Forward_Light'

    def __init__(self, layoutID=R.views.halloween.lobby.StylePreview(), selectedID=None):
        settings = ViewSettings(layoutID)
        settings.flags = ViewFlags.LOBBY_SUB_VIEW
        settings.model = StylesViewModel()
        super(StylesPreviewView, self).__init__(settings)
        self.__selectedID = selectedID
        self.__isResetCameraObjectOnFini = True
        self.__timerEnable3DSelect = None
        self.__isOpenShop = False
        self._pipelineType = self._settingsCore.getSetting(GRAPHICS.RENDER_PIPELINE)
        self.__isHiddenMenu = self._hwController.isEventHangar()
        return

    @property
    def isHiddenMenu(self):
        return self.__isHiddenMenu

    @property
    def viewModel(self):
        return super(StylesPreviewView, self).getViewModel()

    def createToolTip(self, event):
        if event.contentID == R.views.common.tooltip_window.backport_tooltip_content.BackportTooltipContent():
            tooltipId = event.getArgument('tooltipId')
            styleID = event.getArgument('id')
            specialArgs = []
            if tooltipId != TOOLTIPS_CONSTANTS.TECH_CUSTOMIZATION_ITEM or styleID is None:
                return
            style = self._c11n.getItemByID(GUI_ITEM_TYPE.STYLE, int(styleID))
            if style is None:
                return
            intCD = style.intCD
            if tooltipId == TOOLTIPS_CONSTANTS.TECH_CUSTOMIZATION_ITEM:
                specialArgs = CustomizationTooltipContext(itemCD=intCD, showInventoryBlock=False)
            window = BackportTooltipWindow(createTooltipData(isSpecial=True, specialAlias=tooltipId, specialArgs=specialArgs), self.getParentWindow())
            window.load()
            return window
        else:
            return super(StylesPreviewView, self).createToolTip(event)

    def setSelectedStyleId(self, styleID):
        self._hangarCameraSounds.playMotionToObject()
        self.__selectedID = styleID
        with self.viewModel.transaction() as (tx):
            tx.setSelectedStyleId(str(self.__selectedID))

    def _getEvents(self):
        return [
         (
          self.viewModel.onExit, self.__close),
         (
          self.viewModel.onBack, self.__close),
         (
          self.viewModel.onChangeStyle, self.__onChangeStyle),
         (
          self.viewModel.onOpenShop, self.__onOpenShop)]

    def _onLoading(self, *args, **kwargs):
        super(StylesPreviewView, self)._onLoading(args, kwargs)
        self._hangarCameraSounds.playMotionToObject()
        g_eventBus.addListener(CameraRelatedEvents.CAMERA_ENTITY_UPDATED, self.__handleEntityUpdated)
        with self.viewModel.transaction() as (tx):
            self.__filViewModel(tx)
        self.__timerEnable3DSelect = CallbackDelayer()
        playSound(STYLE_PREVIEW_WINDOW_ENTER)
        WWISE.WW_setState(StylesPreviewState.GROUP, StylesPreviewState.OPEN)
        if self._pipelineType == 1:
            BigWorld.EnvironmentSwitcher(self._LIGHT_ENV_NAME).enable(True)

    def _onLoaded(self, *args, **kwargs):
        super(StylesPreviewView, self)._onLoaded(*args, **kwargs)
        self.__timerEnable3DSelect.delayCallback(self._TIMEOUT_SELECTION_ENABLE, lambda : self._hangarSpace.setVehicleSelectable(True))

    def _finalize(self):
        if self.__isResetCameraObjectOnFini:
            ClientSelectableCameraObject.switchCamera()
        playSound(STYLE_PREVIEW_WINDOW_EXIT)
        WWISE.WW_setState(StylesPreviewState.GROUP, StylesPreviewState.CLOSE)
        if self._pipelineType == 1:
            BigWorld.EnvironmentSwitcher(self._LIGHT_ENV_NAME).enable(False)
        super(StylesPreviewView, self)._finalize()

    def _unsubscribe(self):
        if self.__timerEnable3DSelect:
            self.__timerEnable3DSelect.clearCallbacks()
            self.__timerEnable3DSelect = None
        g_eventBus.removeListener(CameraRelatedEvents.CAMERA_ENTITY_UPDATED, self.__handleEntityUpdated)
        super(StylesPreviewView, self)._unsubscribe()
        return

    def _getStylesConfig(self):
        return self._hwController.getModeSettings().hangarStyles

    def __filViewModel(self, tx):
        stylesConfig = self._getStylesConfig()
        tx.setIsEvent(self._hwController.isEventHangar())
        for styleData in stylesConfig:
            style = self._c11n.getItemByID(GUI_ITEM_TYPE.STYLE, styleData['id'])
            vehicleCD = getVehicleCDForStyle(style, itemsCache=self._itemsCache)
            vehicleName = getShortUserName(getVehicleType(vehicleCD))
            styleModel = StyleCardViewModel()
            styleModel.setId(str(style.id))
            styleModel.setName(style.userName)
            styleModel.setIcon(styleData['icon'])
            styleModel.setDescription(style.getDescription())
            styleModel.setIsHistorical(True)
            styleModel.setLabel(backport.text(R.strings.halloween_lobby.styles.forVehicle(), vehicle=vehicleName))
            styleModel.setPriceValue(styleData['price'][1])
            styleModel.setPriceType(styleData['price'][0])
            styleModel.setInventoryCount(style.inventoryCount or len(style.getInstalledVehicles()))
            tx.getStyles().addViewModel(styleModel)

        tx.getStyles().invalidate()
        if self.__selectedID is None:
            self.__selectedID = tx.getStyles()[0].getId()
        tx.setSelectedStyleId(str(self.__selectedID))
        return

    def __onOpenShop(self):
        showHalloweenShopStyles()

    def __onChangeStyle(self, args):
        styleId = int(args.get('styleId', 0))
        if styleId and self.__selectedID != styleId:
            self.__selectedID = styleId
            self.viewModel.setSelectedStyleId(str(self.__selectedID))
            stylesManager = CGF.getManager(self._hangarSpace.spaceID, StylePreviewManager)
            stylesManager.selectStyle(styleId)

    def __close(self):
        if not self._hwController.isEventHangar():
            showHangar()
        else:
            showHalloweenHangar()

    def __handleEntityUpdated(self, event):
        if event.ctx['state'] != CameraMovementStates.MOVING_TO_OBJECT:
            return
        cameraObject = next(obj for obj in ClientSelectableCameraObject.allCameraObjects if obj.id == event.ctx['entityId'])
        if not cameraObject:
            return
        g_currentPreviewVehicle.selectNoVehicle()
        if isinstance(cameraObject, HeroTank):
            self.__isResetCameraObjectOnFini = False
            descriptor = cameraObject.typeDescriptor
            vehicleCD = descriptor.type.compactDescr
            showHeroTankPreview(vehicleCD, isHiddenMenu=self.isHiddenMenu)
        if isinstance(cameraObject, HangarVehicle):
            if len(self._guiLoader.windowsManager.findWindows(lambda w: w.layer == WindowLayer.SUB_VIEW)) == 1:
                self.__close()