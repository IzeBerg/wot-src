from frameworks.wulf import ViewFlags
from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
from gui.Scaleform.daapi.view.meta.WotAnniversaryViewMeta import WotAnniversaryViewMeta
from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor
from gui.Scaleform.framework.managers.loaders import SFViewLoadParams
from gui.Scaleform.genConsts.QUESTS_ALIASES import QUESTS_ALIASES
from gui.impl.gen import R
from gui.impl.lobby.common.browser_view import BrowserView, makeSettings
from gui.server_events import caches
from gui.shared import EVENT_BUS_SCOPE, events, g_eventBus
from gui.shared.event_dispatcher import showHangar
from gui.wot_anniversary.web_handlers import createWotAnniversaryWebHandlers
from gui.wot_anniversary.wot_anniversary_helpers import fireMainViewOpened, isAnniversaryIntroShowed, showWotAnniversaryIntroWindow, fireMainViewClosed
from helpers import dependency
from skeletons.gui.game_control import IWotAnniversaryController
from wot_anniversary_common import WotAnniversaryUrls

class WotAnniversaryInjectorView(InjectComponentAdaptor, WotAnniversaryViewMeta):

    def markVisited(self):
        pass

    def finalize(self):
        self.destroy()

    def _makeInjectView(self):
        return WotAnniversaryBrowserView()


class WotAnniversaryBrowserView(BrowserView):
    __wotAnniversaryCtrl = dependency.descriptor(IWotAnniversaryController)

    def __init__(self):
        super(WotAnniversaryBrowserView, self).__init__(R.views.lobby.common.BrowserView(), settings=makeSettings(url=self.__wotAnniversaryCtrl.getUrl(WotAnniversaryUrls.MAIN), webHandlers=createWotAnniversaryWebHandlers(), viewFlags=ViewFlags.COMPONENT, returnClb=self.__returnCallback, setBackAlpha=False))
        self.__wasAnniversaryPageActive = False

    @staticmethod
    def isCurrentTabSelected():
        return caches.getNavInfo().getMissionsTab() == QUESTS_ALIASES.WOT_ANNIVERSARY_VIEW_PY_ALIAS

    def _onLoading(self, *args, **kwargs):
        if not isAnniversaryIntroShowed():
            showWotAnniversaryIntroWindow(closeCallback=None)
        super(WotAnniversaryBrowserView, self)._onLoading(*args, **kwargs)
        return

    def _finalize(self):
        super(WotAnniversaryBrowserView, self)._finalize()
        if self.isCurrentTabSelected():
            fireMainViewClosed()

    def _getListeners(self):
        return super(WotAnniversaryBrowserView, self)._getListeners() + (
         (
          events.MissionsEvent.ON_TAB_CHANGED, self.__updateBrowserProperties, EVENT_BUS_SCOPE.LOBBY),)

    def _getEvents(self):
        return super(WotAnniversaryBrowserView, self)._getEvents() + (
         (
          self.__wotAnniversaryCtrl.onSettingsChanged, self.__onSettingsChange),)

    def __onSettingsChange(self):
        if not self.__wotAnniversaryCtrl.isAvailableAndActivePhase():
            showHangar()

    def __updateBrowserProperties(self, *args):
        viewActive = self.isCurrentTabSelected()
        if viewActive:
            fireMainViewOpened()
            self.__wasAnniversaryPageActive = True
        elif not viewActive and self.__wasAnniversaryPageActive:
            self.__wotAnniversaryCtrl.onAnniversaryTabSwitched()
            self.__wasAnniversaryPageActive = False

    @staticmethod
    def __returnCallback(*args, **kwargs):
        if kwargs.pop('forceClosed', False):
            g_eventBus.handleEvent(events.LoadViewEvent(SFViewLoadParams(VIEW_ALIAS.LOBBY_HANGAR)), EVENT_BUS_SCOPE.LOBBY)