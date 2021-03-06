from sound_gui_manager import CommonSoundSpaceSettings
from shared_utils import CONST_CONTAINER

class SOUNDS(CONST_CONTAINER):
    COMMON_SOUND_SPACE = 'warehouse'
    STATE_PLACE = 'STATE_hangar_place'
    STATE_PLACE_STORAGE = 'STATE_hangar_place_warehouse'
    ENTER = 'warehouse_enter'
    EXIT = 'warehouse_exit'


STORAGE_SOUND_SPACE = CommonSoundSpaceSettings(name=SOUNDS.COMMON_SOUND_SPACE, entranceStates={SOUNDS.STATE_PLACE: SOUNDS.STATE_PLACE_STORAGE}, exitStates={}, persistentSounds=(), stoppableSounds=(), priorities=(), autoStart=True, enterEvent=SOUNDS.ENTER, exitEvent=SOUNDS.EXIT)