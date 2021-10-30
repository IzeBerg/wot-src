from sound_gui_manager import CommonSoundSpaceSettings
from gui.sounds.filters import States, StatesGroup
FIELD_POST_SOUND_SETTINGS = CommonSoundSpaceSettings(name='field_post', entranceStates={'STATE_hangar_place': 'STATE_hangar_place_garage', 
   StatesGroup.HANGAR_FILTERED: States.HANGAR_FILTERED_ON}, exitStates={}, persistentSounds=(), stoppableSounds=(), priorities=(), autoStart=True, enterEvent='', exitEvent='')
BROWSER_VIEW_SOUND_SPACES = {FIELD_POST_SOUND_SETTINGS.name: FIELD_POST_SOUND_SETTINGS}