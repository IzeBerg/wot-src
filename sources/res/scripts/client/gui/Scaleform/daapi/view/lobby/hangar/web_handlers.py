from web.web_client_api import webApiCollection
from web.web_client_api.quests import QuestsWebApi
from web.web_client_api.request import RequestWebApi
from web.web_client_api.sound import SoundWebApi
from web.web_client_api.ui import OpenWindowWebApi, CloseWindowWebApi, OpenTabWebApi, UtilWebApi

class _OpenWindowWebApi(OpenWindowWebApi):

    def __init__(self, onOpen=None, onClose=None):
        super(_OpenWindowWebApi, self).__init__()
        self.__onBrowserOpen = onOpen
        self.__onBrowserClose = onClose

    def _createHandlers(self):
        return createHangarWebHandlers(self.__onBrowserOpen, self.__onBrowserClose)

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


def createHangarWebHandlers(onBrowserOpen=None, onBrowserClose=None):
    return webApiCollection(_createCloseWindowWebApi(onBrowserClose=onBrowserClose), _createOpenWindowWebApi(onBrowserOpen=onBrowserOpen, onBrowserClose=onBrowserClose), QuestsWebApi, SoundWebApi, RequestWebApi, UtilWebApi, OpenTabWebApi)