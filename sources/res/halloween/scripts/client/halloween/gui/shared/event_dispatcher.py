import adisp
from CurrentVehicle import HeroTankPreviewAppearance
from frameworks.wulf import WindowLayer
from BWUtil import AsyncReturn
from gui import GUI_SETTINGS
from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
from gui.impl.gen import R
from gui.Scaleform.framework import ScopeTemplates
from frameworks.wulf import WindowFlags
from gui.shared import EVENT_BUS_SCOPE, g_eventBus, events
from gui.shared.event_dispatcher import showShop, _getModuleInfoViewName, showBrowserOverlayView, findAndLoadWindow
from skeletons.gui.impl import INotificationWindowController
from gui.Scaleform.framework.managers.loaders import GuiImplViewLoadParams
from gui.Scaleform.framework.managers.loaders import SFViewLoadParams
from halloween.gui.halloween_account_settings import AccountSettingsKeys, getSettings
from halloween.gui.impl.lobby.tank_setup.dialogs.confirm_dialog import HWTankSetupConfirmDialog
from helpers import dependency
from gui.impl.pub.notification_commands import WindowNotificationCommand
from gui.impl.pub.lobby_window import LobbyNotificationWindow
from skeletons.gui.impl import IGuiLoader
from gui.impl.pub.fade_manager import waitGuiImplViewLoading, useDefaultFade
from skeletons.gui.lobby_context import ILobbyContext
from wg_async import wg_await, wg_async
from halloween.gui.scaleform.genConsts.HALLOWEEN_HANGAR_ALIASES import HALLOWEEN_HANGAR_ALIASES

@dependency.replace_none_kwargs(lobbyContext=ILobbyContext)
def _getUrl(urlName=None, lobbyContext=None):
    hostUrl = lobbyContext.getServerSettings().shop.hostUrl
    return hostUrl + ('' if urlName is None else GUI_SETTINGS.shop.get(urlName))


@useDefaultFade(layer=WindowLayer.TOP_WINDOW)
@adisp.adisp_async
@adisp.adisp_process
def loadGuiImplViewWithAnimation(layoutID, viewClass, scope=ScopeTemplates.LOBBY_SUB_SCOPE, callback=None, delay=None, *args, **kwargs):
    yield lambda callback: callback(None)
    if isViewLoaded(layoutID):
        callback(None)
        return
    else:
        yield waitGuiImplViewLoading(GuiImplViewLoadParams(layoutID, viewClass, scope), delay=delay, *args, **kwargs)
        callback(None)
        return


def isViewLoaded(layoutID):
    uiLoader = dependency.instance(IGuiLoader)
    if not uiLoader or not uiLoader.windowsManager or uiLoader.windowsManager.getViewByLayoutID(layoutID):
        return True
    return False


@adisp.adisp_async
@adisp.adisp_process
def showHangarAsync(parentID=None, callback=None):
    yield lambda callback: callback(None)
    from halloween.gui.impl.lobby.hangar_view import HangarView
    layoutID = R.views.halloween.lobby.HangarView()
    if isViewLoaded(layoutID=layoutID):
        return
    else:
        yield wg_await(waitGuiImplViewLoading(GuiImplViewLoadParams(layoutID, HangarView, ScopeTemplates.LOBBY_SUB_SCOPE)))
        callback(None)
        return


def showHangar():
    from halloween.gui.impl.lobby.hangar_view import HangarView
    layoutID = R.views.halloween.lobby.HangarView()
    if isViewLoaded(layoutID=layoutID):
        return
    g_eventBus.handleEvent(events.LoadGuiImplViewEvent(GuiImplViewLoadParams(layoutID, HangarView, ScopeTemplates.LOBBY_SUB_SCOPE)), scope=EVENT_BUS_SCOPE.LOBBY)


def showHangarWithFade():
    from halloween.gui.impl.lobby.hangar_view import HangarView
    layoutID = R.views.halloween.lobby.HangarView()
    if isViewLoaded(layoutID=layoutID):
        return
    loadGuiImplViewWithAnimation(layoutID, HangarView, scope=ScopeTemplates.LOBBY_SUB_SCOPE)


def showMetaIntroView(forceOpen=True, parent=None):
    from halloween.gui.impl.lobby.meta_intro_view import MetaIntroWindow
    layoutID = R.views.halloween.lobby.MetaIntroView()
    isShowed = getSettings(AccountSettingsKeys.META_INTRO_VIEW_SHOWED)
    if isViewLoaded(layoutID) or isShowed and not forceOpen:
        return
    wnd = MetaIntroWindow(layoutID, parent)
    wnd.load()


def showDifficultyView(level, useQueue=False):
    from halloween.gui.impl.lobby.difficulty_window_view import DifficultyWindow
    from halloween.gui.halloween_gui_constants import DifficultyLevel
    from halloween.gui.impl.gen.view_models.views.lobby.difficulty_window_view_model import WindowTypeEnum
    layoutID = R.views.halloween.lobby.DifficultyWindowView()
    difficultyLevel = None
    if level == DifficultyLevel.MEDIUM.value:
        difficultyLevel = WindowTypeEnum.MEDIUM
    elif level == DifficultyLevel.HARD.value:
        difficultyLevel = WindowTypeEnum.HARD
    findAndLoadWindow(useQueue, DifficultyWindow, layoutID, difficultyLevel)
    return


def showComparisonWindow():
    from halloween.gui.impl.lobby.comparison_window_view import ComparisonWindow
    layoutID = R.views.halloween.lobby.ComparisonWindowView()
    if isViewLoaded(layoutID=layoutID):
        return
    wnd = ComparisonWindow(layoutID)
    wnd.load()


def showKingRewardCongratsView(artefactID, isVideoInLastArtefact=False, useQueue=False):
    from halloween.gui.impl.lobby.king_reward_congrats_view import KingRewardCongratsWindow
    layoutID = R.views.halloween.lobby.KingRewardCongratsView()
    findAndLoadWindow(useQueue, KingRewardCongratsWindow, layoutID, artefactID, isVideoInLastArtefact)


def showRewardWindowView(artefactID, useQueue=False):
    from halloween.gui.impl.lobby.reward_window_view import RewardWindow
    layoutID = R.views.halloween.lobby.RewardWindowView()
    findAndLoadWindow(useQueue, RewardWindow, layoutID, artefactID)


def showMetaView(artifactID=None):
    from halloween.gui.impl.lobby.meta_view import MetaView
    layoutID = R.views.halloween.lobby.MetaView()
    if isViewLoaded(layoutID=layoutID):
        return
    loadGuiImplViewWithAnimation(layoutID, MetaView, scope=ScopeTemplates.LOBBY_SUB_SCOPE, artifactID=artifactID)


def showIntroVideo():
    url = GUI_SETTINGS.lookup('hwIntroVideo')
    showBrowserOverlayView(url, VIEW_ALIAS.WEB_VIEW_TRANSPARENT, hiddenLayers=(
     WindowLayer.MARKER, WindowLayer.VIEW, WindowLayer.WINDOW))


def showInfoPage():
    url = GUI_SETTINGS.lookup('infoPageHalloween')
    showBrowserOverlayView(url, HALLOWEEN_HANGAR_ALIASES.HALLOWEEN_BROWSER, hiddenLayers=(
     WindowLayer.MARKER, WindowLayer.VIEW, WindowLayer.WINDOW))


def showHWHangarAmmunitionSetupView(*args, **kwargs):
    from halloween.gui.impl.lobby.hangar_ammunition_setup_view import HWHangarAmmunitionSetupView
    layoutID = R.views.halloween.lobby.HangarAmmunitionSetupView()
    if isViewLoaded(layoutID=layoutID):
        return
    g_eventBus.handleEvent(events.LoadGuiImplViewEvent(GuiImplViewLoadParams(layoutID, HWHangarAmmunitionSetupView, ScopeTemplates.LOBBY_SUB_SCOPE), *args, **kwargs), scope=EVENT_BUS_SCOPE.LOBBY)


@dependency.replace_none_kwargs(notificationsMgr=INotificationWindowController)
def showBattleResult(arenaUniqueID, notificationsMgr=None):
    from halloween.gui.impl.lobby.battle_result_view import BattleResultView as BattleResultViewInLobby
    layoutID = R.views.halloween.lobby.BattleResultView()
    if isViewLoaded(layoutID=layoutID):
        return
    ctx = {'arenaUniqueID': arenaUniqueID}
    view = BattleResultViewInLobby(layoutID, ctx)
    window = LobbyNotificationWindow(WindowFlags.WINDOW_FULLSCREEN, content=view, layer=WindowLayer.FULLSCREEN_WINDOW)
    notificationsMgr.append(WindowNotificationCommand(window))


def showHalloweenShopAll():
    showShop(_getUrl('hw23ShopAll'))


def showHalloweenShopVehicle():
    showShop(_getUrl('hw23ShopVehicle'))


def showHalloweenShopKey():
    showShop(_getUrl('hw23ShopKey'))


def showHalloweenShopStyles():
    showShop(_getUrl('hw23ShopStyles'))


def showHalloweenShopEquyipment():
    showShop(_getUrl('hw23ShopEquipment'))


def showBundleWindow(price, callback=None):
    from halloween.gui.impl.lobby.bundle_view import BundleWindow
    layoutID = R.views.halloween.lobby.BundleView()
    if isViewLoaded(layoutID=layoutID):
        return
    wnd = BundleWindow(layoutID, price, callback)
    wnd.load()
    return wnd


def showStylesPreviewView(selectedID=None):
    uiLoader = dependency.instance(IGuiLoader)
    from halloween.gui.impl.lobby.styles_preview_view import StylesPreviewView
    layoutID = R.views.halloween.lobby.StylePreview()
    if isViewLoaded(layoutID=layoutID):
        stylesPreviewView = uiLoader.windowsManager.getViewByLayoutID(layoutID)
        stylesPreviewView.setSelectedStyleId(selectedID)
        return
    g_eventBus.handleEvent(events.LoadGuiImplViewEvent(GuiImplViewLoadParams(layoutID, StylesPreviewView, ScopeTemplates.LOBBY_SUB_SCOPE), selectedID=selectedID), scope=EVENT_BUS_SCOPE.LOBBY)


@wg_async
def showHWTankSetupConfirmDialog(items, vehicle=None, startState=None, parent=None):
    from gui.impl.dialogs import dialogs
    result = yield wg_await(dialogs.showSingleDialogWithResultData(layoutID=R.views.lobby.tanksetup.dialogs.Confirm(), wrappedViewClass=HWTankSetupConfirmDialog, items=items, vehicle=vehicle, startState=startState, parent=parent))
    raise AsyncReturn(result)


def showModuleInfo(itemCD, vehicleDescr):
    itemCD = int(itemCD)
    g_eventBus.handleEvent(events.LoadViewEvent(SFViewLoadParams(HALLOWEEN_HANGAR_ALIASES.HALLOWEEN_MODULE_INFO, _getModuleInfoViewName(itemCD, vehicleDescr)), ctx={'moduleCompactDescr': itemCD, 
       'vehicleDescr': vehicleDescr}), EVENT_BUS_SCOPE.LOBBY)


def closeViewsByID(layoutIDs):
    uiLoader = dependency.instance(IGuiLoader)
    if not uiLoader or not uiLoader.windowsManager:
        return
    for layoutID in layoutIDs:
        view = uiLoader.windowsManager.getViewByLayoutID(layoutID)
        if view:
            view.destroyWindow()


def showHeroTankPreview(vehTypeCompDescr, previewAlias=VIEW_ALIAS.LOBBY_HANGAR, previousBackAlias=None, previewBackCb=None, hangarVehicleCD=None, isHiddenMenu=True):
    g_eventBus.handleEvent(events.LoadViewEvent(SFViewLoadParams(VIEW_ALIAS.HERO_VEHICLE_PREVIEW), ctx={'itemCD': vehTypeCompDescr, 
       'previewAlias': previewAlias, 
       'previewAppearance': HeroTankPreviewAppearance(), 
       'isHeroTank': True, 
       'previousBackAlias': previousBackAlias, 
       'previewBackCb': previewBackCb, 
       'hangarVehicleCD': hangarVehicleCD, 
       'isHiddenMenu': isHiddenMenu}), scope=EVENT_BUS_SCOPE.LOBBY)