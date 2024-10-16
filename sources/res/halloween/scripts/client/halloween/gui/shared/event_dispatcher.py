import adisp
from CurrentVehicle import HeroTankPreviewAppearance
from frameworks.wulf import WindowLayer
from BWUtil import AsyncReturn
from gui import GUI_SETTINGS
from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
from gui.Scaleform.framework.entities.View import ViewKey
from gui.impl.common.fade_manager import UseFading
from gui.impl.gen import R
from gui.Scaleform.framework import ScopeTemplates
from frameworks.wulf import WindowFlags
from gui.shared import EVENT_BUS_SCOPE, g_eventBus, events
from gui.shared.event_dispatcher import showShop, _getModuleInfoViewName, showBrowserOverlayView, findAndLoadWindow, selectVehicleInHangar
from skeletons.gui.app_loader import IAppLoader
from skeletons.gui.impl import INotificationWindowController
from gui.Scaleform.framework.managers.loaders import GuiImplViewLoadParams
from gui.Scaleform.framework.managers.loaders import SFViewLoadParams
from halloween.gui.halloween_account_settings import AccountSettingsKeys, getSettings
from halloween.gui.impl.lobby.tank_setup.dialogs.confirm_dialog import HWTankSetupConfirmDialog
from helpers import dependency
from gui.impl.pub.notification_commands import WindowNotificationCommand
from gui.impl.pub.lobby_window import LobbyNotificationWindow
from gui.game_control.links import URLMacros
from skeletons.gui.impl import IGuiLoader
from skeletons.gui.lobby_context import ILobbyContext
from wg_async import wg_await, wg_async
from halloween.gui.scaleform.genConsts.HALLOWEEN_HANGAR_ALIASES import HALLOWEEN_HANGAR_ALIASES

@dependency.replace_none_kwargs(lobbyContext=ILobbyContext)
def _getUrl(urlName=None, url=None, lobbyContext=None):
    hostUrl = lobbyContext.getServerSettings().shop.hostUrl
    if url:
        return hostUrl + url
    else:
        return hostUrl + ('' if urlName is None else GUI_SETTINGS.lookup('hwShop').get(urlName))


def isViewLoaded(layoutID):
    uiLoader = dependency.instance(IGuiLoader)
    if not uiLoader or not uiLoader.windowsManager or uiLoader.windowsManager.getViewByLayoutID(layoutID):
        return True
    return False


def isViewLoadedWrap(layoutID):

    def decorator(func):

        def wrapper(*args, **kwargs):
            if isViewLoaded(layoutID=layoutID):
                return None
            else:
                return func(*args, **kwargs)

        return wrapper

    return decorator


@isViewLoadedWrap(R.views.halloween.lobby.HangarView())
@UseFading(layer=WindowLayer.OVERLAY, waitForLayoutReady=R.views.halloween.lobby.HangarView())
def showHangar(artefactID=None):
    from halloween.gui.impl.lobby.hangar_view import HangarView
    layoutID = R.views.halloween.lobby.HangarView()
    g_eventBus.handleEvent(events.LoadGuiImplViewEvent(GuiImplViewLoadParams(layoutID, HangarView, ScopeTemplates.LOBBY_SUB_SCOPE), artefactID=artefactID), scope=EVENT_BUS_SCOPE.LOBBY)


def isHangarLoaded():
    return isViewLoaded(R.views.halloween.lobby.HangarView())


def showMetaIntroView(forceOpen=True, parent=None):
    from halloween.gui.impl.lobby.meta_intro_view import MetaIntroWindow
    layoutID = R.views.halloween.lobby.MetaIntroView()
    isShowed = getSettings(AccountSettingsKeys.META_INTRO_VIEW_SHOWED)
    if isViewLoaded(layoutID) or isShowed and not forceOpen:
        return
    wnd = MetaIntroWindow(parent)
    wnd.load()


def showVehiclePreview(**kwargs):
    from ClientSelectableCameraObject import ClientSelectableCameraObject
    ClientSelectableCameraObject.switchCamera()
    viewAlias = HALLOWEEN_HANGAR_ALIASES.HALLOWEEN_VEHICLE_PREVIEW
    app = dependency.instance(IAppLoader).getApp()
    view = app.containerManager.getViewByKey(ViewKey(viewAlias))
    if view is not None:
        view.destroy()
    kwargs.update({'isHiddenMenu': True})
    g_eventBus.handleEvent(events.LoadViewEvent(SFViewLoadParams(viewAlias), ctx=kwargs), EVENT_BUS_SCOPE.LOBBY)
    return


def showHeroTankPreview(vehTypeCompDescr, previewAlias=VIEW_ALIAS.LOBBY_HANGAR, previousBackAlias=None, previewBackCb=None, hangarVehicleCD=None, backOutfit=None, backBtnLabel='', isHiddenMenu=True, isKingReward=False):
    g_eventBus.handleEvent(events.LoadViewEvent(SFViewLoadParams(HALLOWEEN_HANGAR_ALIASES.HALLOWEEN_HERO_PREVIEW), ctx={'itemCD': vehTypeCompDescr, 
       'previewAlias': previewAlias, 
       'previewAppearance': HeroTankPreviewAppearance(), 
       'isHeroTank': True, 
       'previousBackAlias': previousBackAlias, 
       'previewBackCb': previewBackCb, 
       'hangarVehicleCD': hangarVehicleCD, 
       'backOutfit': backOutfit, 
       'backBtnLabel': backBtnLabel, 
       'isHiddenMenu': isHiddenMenu, 
       'isKingReward': isKingReward}), scope=EVENT_BUS_SCOPE.LOBBY)


@isViewLoadedWrap(R.views.halloween.lobby.RewardPathView())
@UseFading(layer=WindowLayer.OVERLAY, waitForLayoutReady=R.views.halloween.lobby.RewardPathView())
def showRewardPathView(selectedArtefactID=None):
    from halloween.gui.impl.lobby.reward_path_view import RewardPathView
    layoutID = R.views.halloween.lobby.RewardPathView()
    g_eventBus.handleEvent(events.LoadGuiImplViewEvent(GuiImplViewLoadParams(layoutID, RewardPathView, ScopeTemplates.LOBBY_SUB_SCOPE), selectedArtefactID=selectedArtefactID), scope=EVENT_BUS_SCOPE.LOBBY)


@dependency.replace_none_kwargs(notificationsMgr=INotificationWindowController)
def showPromoWindowView(forceOpen=False, notificationsMgr=None):
    from halloween.gui.impl.lobby.promo_window_view import PromoWindow
    layoutID = R.views.halloween.lobby.PromoWindowView()
    isShowed = getSettings(AccountSettingsKeys.PROMO_SCREEN_SHOWED)
    if isViewLoaded(layoutID=layoutID) or isShowed and not forceOpen:
        return
    window = PromoWindow(layoutID)
    notificationsMgr.append(WindowNotificationCommand(window))


def showDifficultyView(level, useQueue=False):
    from halloween.gui.impl.lobby.difficulty_window_view import DifficultyWindow
    layoutID = R.views.halloween.lobby.DifficultyWindowView()
    findAndLoadWindow(useQueue, DifficultyWindow, layoutID, level)


def showComparisonWindow():
    from halloween.gui.impl.lobby.comparison_window_view import ComparisonWindow
    layoutID = R.views.halloween.lobby.ComparisonWindowView()
    if isViewLoaded(layoutID=layoutID):
        return
    wnd = ComparisonWindow(layoutID)
    wnd.load()


def showKingRewardCongratsView(artefactID, useQueue=False):
    from halloween.gui.impl.lobby.king_reward_congrats_view import KingRewardCongratsWindow
    layoutID = R.views.halloween.lobby.KingRewardCongratsView()
    findAndLoadWindow(useQueue, KingRewardCongratsWindow, layoutID, artefactID)


def showDecryptWindowView(artefactID, useQueue=False, isReward=False):
    from halloween.gui.impl.lobby.decrypt_view import DecryptWindow
    findAndLoadWindow(useQueue, DecryptWindow, artefactID, isReward)


def showIntroVideo():
    url = GUI_SETTINGS.lookup('hwIntroVideo')
    showBrowserOverlayView(url, VIEW_ALIAS.WEB_VIEW_TRANSPARENT, hiddenLayers=(
     WindowLayer.MARKER, WindowLayer.VIEW, WindowLayer.WINDOW))


def showInfoPage():
    url = GUI_SETTINGS.lookup('infoPageHalloween')
    showBrowserOverlayView(url, HALLOWEEN_HANGAR_ALIASES.HALLOWEEN_BROWSER, hiddenLayers=(
     WindowLayer.MARKER, WindowLayer.VIEW, WindowLayer.WINDOW))


@adisp.adisp_process
def showHwLeaderboard():
    url = GUI_SETTINGS.lookup('hwLeaderboard')
    if url:
        from gui.shared.events import OpenLinkEvent
        url = yield URLMacros().parse(url)
        g_eventBus.handleEvent(OpenLinkEvent(OpenLinkEvent.SPECIFIED, url))


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
    showShop(_getUrl('hwShopAll'))


def showHalloweenShopVehicle():
    showShop(_getUrl('hwShopVehicle'))


def showHalloweenShopBundle(bundleUrl):
    showShop(_getUrl(url=bundleUrl))


def showBundleWindow(artefactID=''):
    from halloween.gui.impl.lobby.bundle_view import BundleWindow
    layoutID = R.views.halloween.lobby.BundleView()
    if isViewLoaded(layoutID=layoutID):
        return
    wnd = BundleWindow(layoutID, artefactID)
    wnd.load()
    return wnd


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


@UseFading(layer=WindowLayer.OVERLAY)
def selectVehicleInHangarWithFade(itemCD, loadHangar=True):
    selectVehicleInHangar(itemCD, loadHangar)