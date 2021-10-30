from sound_gui_manager import CommonSoundSpaceSettings
from shared_utils import CONST_CONTAINER

class SOUNDS(CONST_CONTAINER):
    COMMON_SOUND_SPACE = 'achievements'
    STATE_PLACE = 'STATE_hangar_place'
    STATE_PLACE_ACHIEVEMENTS = 'STATE_hangar_place_achievements'


ACHIEVEMENTS_SOUND_SPACE = CommonSoundSpaceSettings(name=SOUNDS.COMMON_SOUND_SPACE, entranceStates={SOUNDS.STATE_PLACE: SOUNDS.STATE_PLACE_ACHIEVEMENTS}, exitStates={}, persistentSounds=(), stoppableSounds=(), priorities=(), autoStart=True, enterEvent='', exitEvent='')