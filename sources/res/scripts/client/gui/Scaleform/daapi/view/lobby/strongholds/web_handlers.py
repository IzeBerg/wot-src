from web.web_client_api import webApiCollection
from web.web_client_api.clans import ClansWebApi
from web.web_client_api.exchange import PersonalExchangeRatesDiscountsWebApi
from web.web_client_api.reactive_comm import ReactiveCommunicationWebApi
from web.web_client_api.request import RequestWebApi
from web.web_client_api.shop import ShopWebApi
from web.web_client_api.sound import SoundWebApi, SoundStateWebApi
from web.web_client_api.strongholds import StrongholdsWebApi
from web.web_client_api.ui import NotificationWebApi, OpenWindowWebApi, OpenTabWebApi, ContextMenuWebApi, CloseWindowWebApi, UtilWebApi
from web.web_client_api.vehicles import VehiclesWebApi
from web.web_client_api.arenas import ArenasWebApi
from web.web_client_api.uilogging import UILoggingWebApi

class _OpenWindowWebApi(OpenWindowWebApi):

    def __init__(self, onOpen=None, onClose=None):
        super(_OpenWindowWebApi, self).__init__()
        self.__onBrowserOpen = onOpen
        self.__onBrowserClose = onClose

    def _createHandlers(self):
        return createStrongholdsWebHandlers(self.__onBrowserOpen, self.__onBrowserClose)

    def _onBrowserOpen(self, alias):
        if self.__onBrowserOpen is not None:
            self.__onBrowserOpen(alias)
        return


class _CloseWindowWebApi(CloseWindowWebApi):

    def __init__(self, close=None):
        super(_CloseWindowWebApi, self).__init__()
        self.__onBrowserClose = close

    def _onBrowserClose(self):
        if self.__onBrowserClose is not None:
            self.__onBrowserClose()
        return


def _createOpenWindowWebApi(onBrowserOpen=None, onBrowserClose=None):

    def _doCreate():
        return _OpenWindowWebApi(onOpen=onBrowserOpen, onClose=onBrowserClose)

    return _doCreate


def _createCloseWindowWebApi(onBrowserClose=None):

    def _doCreate():
        return _CloseWindowWebApi(close=onBrowserClose)

    return _doCreate


def createStrongholdsWebHandlers(onBrowserOpen=None, onBrowserClose=None):
    return webApiCollection(_createCloseWindowWebApi(onBrowserClose=onBrowserClose), _createOpenWindowWebApi(onBrowserOpen=onBrowserOpen, onBrowserClose=onBrowserClose), ClansWebApi, ContextMenuWebApi, NotificationWebApi, OpenTabWebApi, ReactiveCommunicationWebApi, RequestWebApi, StrongholdsWebApi, ShopWebApi, SoundWebApi, SoundStateWebApi, VehiclesWebApi, ArenasWebApi, UtilWebApi, UILoggingWebApi, PersonalExchangeRatesDiscountsWebApi)