from gui.ClientUpdateManager import g_clientUpdateManager
from helpers import dependency
from skeletons.gui.game_control import IWotAnniversaryController
from web.client_web_api.api import C2WHandler, c2w

class WotAnniversaryEventHandler(C2WHandler):
    __wotAnniversaryCtrl = dependency.descriptor(IWotAnniversaryController)

    def init(self):
        super(WotAnniversaryEventHandler, self).init()
        g_clientUpdateManager.addCallbacks({'stats.eventCoin': self.__onTokensUpdate})
        self.__wotAnniversaryCtrl.onSecretMessageStateChanged += self.__secretMessageStateChanged
        self.__wotAnniversaryCtrl.onAnniversaryTabSwitched += self.__anniversaryTabSwitched

    def fini(self):
        self.__wotAnniversaryCtrl.onAnniversaryTabSwitched += self.__anniversaryTabSwitched
        self.__wotAnniversaryCtrl.onSecretMessageStateChanged -= self.__secretMessageStateChanged
        g_clientUpdateManager.removeObjectCallbacks(self, True)
        super(WotAnniversaryEventHandler, self).fini()

    def __onTokensUpdate(self, diff):
        return self.__tokensChanged()

    @c2w(name='wot_anniversary_tokens_changed')
    def __tokensChanged(self):
        return

    @c2w(name='wot_anniversary_secret_message_state_changed')
    def __secretMessageStateChanged(self):
        return {'isSecretMessageActive': self.__wotAnniversaryCtrl.isSecretMessageActive()}

    @c2w(name='wot_anniversary_tab_switched')
    def __anniversaryTabSwitched(self):
        return