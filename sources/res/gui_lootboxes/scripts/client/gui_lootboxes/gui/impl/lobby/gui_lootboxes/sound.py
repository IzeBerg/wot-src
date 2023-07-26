from enum import Enum
import SoundGroups
from sound_gui_manager import CommonSoundSpaceSettings

class Sounds(Enum):
    STORAGE_SPACE_NAME = 'loot_box_storage'
    LOOT_BOX_ENTER = 'lootboxes_enter'
    LOOT_BOX_EXIT = 'lootboxes_exit'
    STATE_PLACE = 'STATE_hangar_place'
    STATE_LOOTBOXES = 'STATE_hangar_place_lootboxes'
    STATE_HANGAR_PLACE = 'STATE_hangar_place_garage'
    OVERLAY_SPACE_NAME = 'loot_boxes_overlay'
    OVERLAY_HANGAR_GENERAL = 'STATE_overlay_hangar_general'
    OVERLAY_HANGAR_GENERAL_ON = 'STATE_overlay_hangar_general_on'
    OVERLAY_HANGAR_GENERAL_OFF = 'STATE_overlay_hangar_general_off'
    INTRO_SPACE_NAME = 'loot_boxes_intro'
    LOOT_BOX_ENTER_FIRST = 'lootboxes_enter_first'


LOOT_BOXES_SOUND_SPACE = CommonSoundSpaceSettings(name=Sounds.STORAGE_SPACE_NAME.value, entranceStates={Sounds.STATE_PLACE.value: Sounds.STATE_LOOTBOXES.value}, exitStates={Sounds.STATE_PLACE.value: Sounds.STATE_HANGAR_PLACE.value}, persistentSounds=(), stoppableSounds=(), priorities=(), autoStart=True, enterEvent='', exitEvent=Sounds.LOOT_BOX_EXIT.value)
LOOT_BOXES_OVERLAY_SOUND_SPACE = CommonSoundSpaceSettings(name=Sounds.OVERLAY_SPACE_NAME.value, entranceStates={Sounds.OVERLAY_HANGAR_GENERAL.value: Sounds.OVERLAY_HANGAR_GENERAL_ON.value}, exitStates={Sounds.OVERLAY_HANGAR_GENERAL.value: Sounds.OVERLAY_HANGAR_GENERAL_OFF.value}, persistentSounds=(), stoppableSounds=(), priorities=(), autoStart=True)

def playEnterSound(isFirstEnter):
    soundName = Sounds.LOOT_BOX_ENTER_FIRST.value if isFirstEnter else Sounds.LOOT_BOX_ENTER.value
    SoundGroups.g_instance.playSound2D(soundName)