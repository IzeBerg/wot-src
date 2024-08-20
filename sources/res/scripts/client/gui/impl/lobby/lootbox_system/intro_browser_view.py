from gui.Scaleform.daapi.view.lobby.shared.web_view import WebView
from gui.sounds.filters import switchHangarOverlaySoundFilter

class LootBoxSystemIntroBrowserView(WebView):

    def _populate(self):
        super(LootBoxSystemIntroBrowserView, self)._populate()
        switchHangarOverlaySoundFilter(on=True)

    def _dispose(self):
        switchHangarOverlaySoundFilter(on=False)
        super(LootBoxSystemIntroBrowserView, self)._dispose()