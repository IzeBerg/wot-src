from gui.Scaleform.daapi.view.lobby.shared.web_view import WebView
from gui.Scaleform.daapi.view.lobby.wot_plus.sound_constants import VEHICLE_RENTAL_SOUND_SPACE, WOT_PLUS_INFO_SOUND_SPACE

class WotPlusInfoView(WebView):
    _COMMON_SOUND_SPACE = WOT_PLUS_INFO_SOUND_SPACE

    def __init__(self, ctx=None):
        self._COMMON_SOUND_SPACE = WOT_PLUS_INFO_SOUND_SPACE if ctx.get('useCustomSoundSpace', False) else None
        super(WotPlusInfoView, self).__init__(ctx)
        return


class VehicleRentalView(WebView):
    _COMMON_SOUND_SPACE = VEHICLE_RENTAL_SOUND_SPACE