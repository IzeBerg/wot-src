import BigWorld
from helpers import dependency
from halloween.gui.sounds import playSound
from halloween.skeletons.difficulty_level_controller import IDifficultyLevelController
from halloween.gui.halloween_account_settings import isSoundPlayed, setSoundPlayed
from gui.battle_control.avatar_getter import getSoundNotifications
from gui.IngameSoundNotifications import LOG_VO

class Voiceover(object):
    _difficultyCtrl = dependency.descriptor(IDifficultyLevelController)

    def __init__(self, standardVoiceover, expositionVoiceover=None, useNotificationSystem=True, aliveOnly=False):
        self._standardVoiceover = standardVoiceover
        self._expositionVoiceover = expositionVoiceover
        self._useNotificationSystem = useNotificationSystem
        self._aliveOnly = aliveOnly

    def play(self):
        if self._aliveOnly and not BigWorld.player().isVehicleAlive:
            LOG_VO(('HW Request "{}" is rejected. Reason: player is dead').format(self._standardVoiceover))
            return
        else:
            voiceover = self._standardVoiceover
            if self._expositionVoiceover is not None:
                difficultyLevel = self._difficultyCtrl.getSelectedLevel()
                if not isSoundPlayed(self._expositionVoiceover, difficultyLevel):
                    voiceover = self._expositionVoiceover
                    setSoundPlayed(self._expositionVoiceover, difficultyLevel)
            if voiceover:
                if self._useNotificationSystem:
                    soundNotifications = getSoundNotifications()
                    if soundNotifications and hasattr(soundNotifications, 'play'):
                        soundNotifications.play(voiceover)
                else:
                    playSound(voiceover)
            return