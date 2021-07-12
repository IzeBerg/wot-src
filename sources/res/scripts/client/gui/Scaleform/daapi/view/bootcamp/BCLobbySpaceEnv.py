from gui.sounds.ambients import SoundEnv
from gui.sounds.ambients import NoMusic
from gui.sounds.ambients import NoAmbient

class BCLobbySpaceEnv(SoundEnv):

    def __init__(self, soundsCtrl):
        super(BCLobbySpaceEnv, self).__init__(soundsCtrl, 'lobby', music=NoMusic(), ambient=NoAmbient())