from gui.Scaleform.daapi.view.lobby.shared.web_view import WebView
from gui.impl.lobby.mapbox.sound import getMapboxViewSoundSpace

class MapBoxInfoOverlay(WebView):
    _COMMON_SOUND_SPACE = getMapboxViewSoundSpace()