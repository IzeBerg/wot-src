from __future__ import absolute_import
import logging, Steam
from constants import DISTRIBUTION_PLATFORM
from web.web_client_api.platform.base import IPlatformWebApi
_logger = logging.getLogger(__name__)

class SteamPlatformWebApi(IPlatformWebApi):

    def getType(self):
        return DISTRIBUTION_PLATFORM.STEAM.value

    def isInited(self):
        return Steam.isInited()

    def isConnected(self):
        return Steam.isInited()