from gui.Scaleform.daapi.view.lobby.shared.web_view import WebView
from gui.sounds.filters import switchHangarOverlaySoundFilter
from helpers import dependency
from skeletons.gui.game_control import IBattlePassController
from web.web_client_api import sound as sound_web_api, ui as ui_web_api, webApiCollection
from web.web_client_api.battle_pass import BattlePassWebApi
from web.web_client_api.sound import SoundStateWebApi

class BattlePassBrowserView(WebView):
    __battlePassController = dependency.descriptor(IBattlePassController)

    def webHandlers(self):
        return webApiCollection(BattlePassWebApi, ui_web_api.OpenWindowWebApi, ui_web_api.CloseWindowWebApi, ui_web_api.OpenTabWebApi, ui_web_api.NotificationWebApi, ui_web_api.ContextMenuWebApi, ui_web_api.UtilWebApi, sound_web_api.SoundWebApi, sound_web_api.HangarSoundWebApi, SoundStateWebApi)

    def _populate(self):
        super(BattlePassBrowserView, self)._populate()
        self.__battlePassController.onBattlePassSettingsChange += self.__onSettingsChange
        switchHangarOverlaySoundFilter(on=True)

    def _dispose(self):
        super(BattlePassBrowserView, self)._dispose()
        self.__battlePassController.onBattlePassSettingsChange -= self.__onSettingsChange
        switchHangarOverlaySoundFilter(on=False)

    def __onSettingsChange(self, *_):
        if not self.__battlePassController.isVisible() or self.__battlePassController.isPaused():
            self.destroy()