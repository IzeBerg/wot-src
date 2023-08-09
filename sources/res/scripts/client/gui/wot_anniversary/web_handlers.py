from gui.shared.event_dispatcher import showHangar
from gui.wot_anniversary.wot_anniversary_helpers import WOT_ANNIVERSARY_VEHICLE_PREVIEW, showMainView
from helpers import dependency
from skeletons.gui.game_control import IWotAnniversaryController
from web.web_client_api import w2capi, webApiCollection
from web.web_client_api.platform import PlatformWebApi
from web.web_client_api.quests import QuestsWebApi
from web.web_client_api.request import RequestWebApi
from web.web_client_api.rewards import RewardsWebApi
from web.web_client_api.shop import ShopWebApi
from web.web_client_api.sound import SoundWebApi, SoundStateWebApi
from web.web_client_api.ui import VehiclePreviewWebApiMixin, ShopWebApiMixin, CloseWindowWebApi, OpenWindowWebApi, NotificationWebApi, UtilWebApi
from web.web_client_api.ui.hangar import HangarTabWebApiMixin
from web.web_client_api.uilogging import UILoggingWebApi
from web.web_client_api.vehicles import VehiclesWebApi
from web.web_client_api.wot_anniversary import WotAnniversaryWebApi

def createWotAnniversaryWebHandlers():
    return webApiCollection(CloseWindowWebApi, OpenWindowWebApi, NotificationWebApi, RequestWebApi, ShopWebApi, SoundWebApi, SoundStateWebApi, UtilWebApi, QuestsWebApi, VehiclesWebApi, RewardsWebApi, PlatformWebApi, WotAnniversaryWebApi, _OpenTabWebApi, UILoggingWebApi)


@w2capi(name='open_tab', key='tab_id')
class _OpenTabWebApi(HangarTabWebApiMixin, VehiclePreviewWebApiMixin, ShopWebApiMixin):
    __wotAnniversaryCtrl = dependency.descriptor(IWotAnniversaryController)

    def _getVehiclePreviewReturnAlias(self, cmd):
        return WOT_ANNIVERSARY_VEHICLE_PREVIEW

    def _getVehiclePreviewReturnCallback(self, cmd):
        return self.__getReturnCallback()

    def __getReturnCallback(self):

        def _returnToEventPage():
            showHangar()
            if self.__wotAnniversaryCtrl.isAvailableAndActivePhase():
                showMainView()

        return _returnToEventPage