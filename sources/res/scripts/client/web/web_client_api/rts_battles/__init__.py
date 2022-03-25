from web.web_client_api import webApiCollection
from web.web_client_api.request import RequestWebApi
from web.web_client_api.sound import SoundWebApi, HangarSoundWebApi
from web.web_client_api.ui import NotificationWebApi, OpenWindowWebApi, CloseViewWebApi

def createRTSBattlesWebHanlders():
    return webApiCollection(NotificationWebApi, RequestWebApi, OpenWindowWebApi, CloseViewWebApi, SoundWebApi, HangarSoundWebApi)