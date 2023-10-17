from gui.Scaleform.daapi.view.lobby.shared.web_view import WebViewTransparent
from halloween.gui.sounds import playSound
from halloween.gui.sounds.sound_constants import ABOUT_ENTER, ABOUT_EXIT

class HalloweenBrowser(WebViewTransparent):

    def __init__(self, ctx=None):
        super(HalloweenBrowser, self).__init__(ctx)
        playSound(ABOUT_ENTER)

    def _dispose(self):
        playSound(ABOUT_EXIT)
        super(HalloweenBrowser, self)._dispose()