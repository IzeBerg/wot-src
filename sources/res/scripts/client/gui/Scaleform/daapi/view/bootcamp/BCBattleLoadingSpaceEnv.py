from gui.sounds.ambients import SoundEnv
from gui.sounds.ambients import NoMusic
from gui.sounds.ambients import NoAmbient

class BCBattleLoadingSpaceEnv(SoundEnv):

    def __init__(self, soundsCtrl):
        super(BCBattleLoadingSpaceEnv, self).__init__(soundsCtrl, 'battleLoading', music=NoMusic(), ambient=NoAmbient())