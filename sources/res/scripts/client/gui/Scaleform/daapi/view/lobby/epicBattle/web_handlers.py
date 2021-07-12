from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
from gui.Scaleform.framework.managers.loaders import SFViewLoadParams
from gui.shared import g_eventBus, events, EVENT_BUS_SCOPE
from web.web_client_api import webApiCollection
from web.web_client_api.frontline import FrontLineWebApi
from web.web_client_api.quests import QuestsWebApi
from web.web_client_api.request import RequestWebApi
from web.web_client_api.sound import SoundWebApi, HangarSoundWebApi, SoundStateWebApi
from web.web_client_api.shop import ShopWebApi
from web.web_client_api.ui import NotificationWebApi, OpenWindowWebApi, OpenTabWebApi
from web.web_client_api.ui import CloseWindowWebApi, UtilWebApi, ContextMenuWebApi
from web.web_client_api.vehicles import VehiclesWebApi

class _OpenTabWebApi(OpenTabWebApi):

    def _getVehiclePreviewReturnAlias(self, cmd):
        return VIEW_ALIAS.EPIC_BATTLE_PAGE

    def _getVehiclePreviewReturnCallback(self, cmd):
        return self.__getReturnCallback(cmd.back_url)

    def _getVehicleStylePreviewCallback(self, cmd):
        return self.__getReturnCallback(cmd.back_url)

    def __getReturnCallback(self, backUrl):
        if backUrl is not None:
            return lambda : _goBack(backUrl)
        else:
            return


def _goBack(url):
    webHandlers = createFrontlineWebHandlers()
    g_eventBus.handleEvent(events.LoadViewEvent(SFViewLoadParams(VIEW_ALIAS.BROWSER_VIEW), ctx={'url': url, 
       'webHandlers': webHandlers, 
       'returnAlias': VIEW_ALIAS.LOBBY_HANGAR}), EVENT_BUS_SCOPE.LOBBY)


def createFrontlineWebHandlers():
    return webApiCollection(FrontLineWebApi, VehiclesWebApi, RequestWebApi, ShopWebApi, OpenWindowWebApi, CloseWindowWebApi, _OpenTabWebApi, NotificationWebApi, ContextMenuWebApi, UtilWebApi, SoundWebApi, SoundStateWebApi, HangarSoundWebApi, QuestsWebApi)