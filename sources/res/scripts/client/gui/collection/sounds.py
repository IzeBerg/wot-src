from enum import Enum
from sound_gui_manager import CommonSoundSpaceSettings

class Sounds(Enum):
    SPACE = 'collections_space'
    COMMON_ENTER = 'achievements_enter'
    COMMON_EXIT = 'achievements_exit'
    STATE_PLACE = 'STATE_hangar_place'
    STATE_PLACE_ACHIEVEMENTS = 'STATE_hangar_place_achievements'
    STATE_PLACE_TASKS = 'STATE_hangar_place_tasks'
    REWARD_SCREEN = 'bp_reward_screen'


COLLECTIONS_SOUND_SPACE = CommonSoundSpaceSettings(name=Sounds.SPACE.value, entranceStates={Sounds.STATE_PLACE.value: Sounds.STATE_PLACE_ACHIEVEMENTS.value}, exitStates={}, persistentSounds=(), stoppableSounds=(), priorities=(), autoStart=True, enterEvent=Sounds.COMMON_ENTER.value, exitEvent=Sounds.COMMON_EXIT.value)