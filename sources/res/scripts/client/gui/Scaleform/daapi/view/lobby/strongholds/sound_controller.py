from gui.app_loader import sf_lobby
from gui.shared.SoundEffectsId import SoundEffectsId

class _StrongholdSoundController(object):

    @sf_lobby
    def app(self):
        return

    def init(self):
        pass

    def fini(self):
        pass

    def playBattleRoomTimerAlert(self):
        self.__playSound(SoundEffectsId.BATTLE_ROOM_TIMER_ALERT)

    def __playSound(self, soundID):
        app = self.app
        if app is not None and app.soundManager is not None:
            app.soundManager.playEffectSound(soundID)
        return


g_strongholdSoundController = _StrongholdSoundController()