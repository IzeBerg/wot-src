from gui.Scaleform.daapi.view.lobby.shared.web_view import WebView
from gui.shared import g_eventBus, events, EVENT_BUS_SCOPE

class BattlePassVideoBrowserView(WebView):

    def _dispose(self):
        g_eventBus.handleEvent(events.BattlePassEvent(events.BattlePassEvent.VIDEO_SHOWN), scope=EVENT_BUS_SCOPE.LOBBY)
        super(BattlePassVideoBrowserView, self)._dispose()