from gui.Scaleform.daapi.view.lobby.shared.web_view import WebView
from helpers import dependency
from skeletons.gui.game_control import IBattleRoyaleController
from web.web_client_api.battle_royale import createBattleRoyaleWebHanlders

class BattleRoyaleBrowserView(WebView):
    __battleRoyaleController = dependency.descriptor(IBattleRoyaleController)

    def webHandlers(self):
        return createBattleRoyaleWebHanlders()

    def _populate(self):
        super(BattleRoyaleBrowserView, self)._populate()
        self.__battleRoyaleController.onUpdated += self.__onSettingsChange

    def _dispose(self):
        super(BattleRoyaleBrowserView, self)._dispose()
        self.__battleRoyaleController.onUpdated -= self.__onSettingsChange

    def __onSettingsChange(self, diff):
        if not self.__battleRoyaleController.isEnabled():
            self.destroy()