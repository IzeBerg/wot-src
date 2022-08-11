from gui.ClientUpdateManager import g_clientUpdateManager
from gui.wot_anniversary.wot_anniversary_helpers import WOT_ANNIVERSARY_PREFIX
from web.client_web_api.api import C2WHandler, c2w

class WotAnniversaryEventHandler(C2WHandler):

    def init(self):
        super(WotAnniversaryEventHandler, self).init()
        g_clientUpdateManager.addCallback('tokens', self.__onTokensUpdate)

    def fini(self):
        g_clientUpdateManager.removeObjectCallbacks(self, True)
        super(WotAnniversaryEventHandler, self).fini()

    def __onTokensUpdate(self, diff):
        for tID in diff.keys():
            if tID.startswith(WOT_ANNIVERSARY_PREFIX):
                self.__sendTokens()
                return

    @c2w(name='wot_anniversary_tokens_changed')
    def __sendTokens(self):
        return