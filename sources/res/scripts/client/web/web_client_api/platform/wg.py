from constants import DISTRIBUTION_PLATFORM
from web.web_client_api.platform.base import IPlatformWebApi

class WgPlatformWebApi(IPlatformWebApi):

    def getType(self):
        return DISTRIBUTION_PLATFORM.WG.value

    def isInited(self):
        return True

    def isConnected(self):
        return True