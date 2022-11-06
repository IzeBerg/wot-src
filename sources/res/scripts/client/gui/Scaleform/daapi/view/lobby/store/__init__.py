from frameworks.wulf import WindowLayer
from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
from gui.Scaleform.framework.package_layout import PackageBusinessHandler
from gui.app_loader import settings as app_settings
from gui.shared import EVENT_BUS_SCOPE

def getContextMenuHandlers():
    return ()


def getViewSettings():
    from gui.Scaleform.daapi.view.lobby.store.browser.shop_view import ShopView, ShopOverlay
    from gui.Scaleform.daapi.view.lobby.shared.web_view import WebViewTransparent
    from gui.Scaleform.framework import ViewSettings, ScopeTemplates
    return (
     ViewSettings(VIEW_ALIAS.LOBBY_STORE, ShopView, 'browserScreen.swf', WindowLayer.SUB_VIEW, VIEW_ALIAS.LOBBY_STORE, ScopeTemplates.LOBBY_SUB_SCOPE),
     ViewSettings(VIEW_ALIAS.OVERLAY_WEB_STORE, ShopOverlay, 'browserScreen.swf', WindowLayer.TOP_WINDOW, VIEW_ALIAS.OVERLAY_WEB_STORE, ScopeTemplates.LOBBY_SUB_SCOPE),
     ViewSettings(VIEW_ALIAS.WEB_VIEW_TRANSPARENT, WebViewTransparent, 'browserScreen.swf', WindowLayer.FULLSCREEN_WINDOW, VIEW_ALIAS.WEB_VIEW_TRANSPARENT, ScopeTemplates.LOBBY_SUB_SCOPE))


def getBusinessHandlers():
    return (
     StorePackageBusinessHandler(),)


class StorePackageBusinessHandler(PackageBusinessHandler):

    def __init__(self):
        listeners = (
         (
          VIEW_ALIAS.LOBBY_STORE, self.loadViewByCtxEvent),
         (
          VIEW_ALIAS.WEB_VIEW_TRANSPARENT, self.loadViewByCtxEvent),
         (
          VIEW_ALIAS.OVERLAY_WEB_STORE, self.loadViewByCtxEvent))
        super(StorePackageBusinessHandler, self).__init__(listeners, app_settings.APP_NAME_SPACE.SF_LOBBY, EVENT_BUS_SCOPE.LOBBY)