from sound_gui_manager import CommonSoundSpaceSettings
from shared_utils import CONST_CONTAINER

class AnniversarySounds(CONST_CONTAINER):
    INTERESTING_FACT_AND_BONUS_NAME = 'interesting_fact_and_bonus_sound'
    INTRO_SCREEN_SOUND_NAME = 'interesting_fact_and_bonus_sound'
    REWARD_SCREEN_SOUND_NAME = 'interesting_fact_and_bonus_sound'
    WELCOM_WINDOW_SOUND_NAME = 'interesting_fact_and_bonus_sound'
    HANGAR_OVERLAY_STATE = 'STATE_overlay_hangar_general'
    HANGAR_OVERLAY_STATE_ON = 'STATE_overlay_hangar_general_on'
    HANGAR_OVERLAY_STATE_OFF = 'STATE_overlay_hangar_general_off'
    INTERESTING_FACT_AND_BONUS_SOUND = 'bday_2023_shutter'
    INTERESTING_INTRO_SCREEN_SOUND = 'ev_bday_12_intro'
    INTERESTING_REWARD_SCREEN_SOUND = 'ev_bday_12_reward'


WOT_ANNIVERSARY_INTERESTING_FACT_AND_BONUS_SOUND = CommonSoundSpaceSettings(name=AnniversarySounds.INTERESTING_FACT_AND_BONUS_NAME, entranceStates={AnniversarySounds.HANGAR_OVERLAY_STATE: AnniversarySounds.HANGAR_OVERLAY_STATE_ON}, exitStates={AnniversarySounds.HANGAR_OVERLAY_STATE: AnniversarySounds.HANGAR_OVERLAY_STATE_OFF}, persistentSounds=(), stoppableSounds=(), priorities=(), autoStart=True, enterEvent=AnniversarySounds.INTERESTING_FACT_AND_BONUS_SOUND, exitEvent=None)
WOT_ANNIVERSARY_INTRO_SCREEN_SOUND = CommonSoundSpaceSettings(name=AnniversarySounds.INTRO_SCREEN_SOUND_NAME, entranceStates={AnniversarySounds.HANGAR_OVERLAY_STATE: AnniversarySounds.HANGAR_OVERLAY_STATE_ON}, exitStates={AnniversarySounds.HANGAR_OVERLAY_STATE: AnniversarySounds.HANGAR_OVERLAY_STATE_OFF}, persistentSounds=(), stoppableSounds=(), priorities=(), autoStart=True, enterEvent=AnniversarySounds.INTERESTING_INTRO_SCREEN_SOUND, exitEvent=None)
WOT_ANNIVERSARY_REWARD_SCREEN_SOUND = CommonSoundSpaceSettings(name=AnniversarySounds.REWARD_SCREEN_SOUND_NAME, entranceStates={AnniversarySounds.HANGAR_OVERLAY_STATE: AnniversarySounds.HANGAR_OVERLAY_STATE_ON}, exitStates={AnniversarySounds.HANGAR_OVERLAY_STATE: AnniversarySounds.HANGAR_OVERLAY_STATE_OFF}, persistentSounds=(), stoppableSounds=(), priorities=(), autoStart=True, enterEvent=AnniversarySounds.INTERESTING_REWARD_SCREEN_SOUND, exitEvent=None)
WOT_ANNIVERSARY_WELCOM_WINDOW_SOUND = CommonSoundSpaceSettings(name=AnniversarySounds.WELCOM_WINDOW_SOUND_NAME, entranceStates={AnniversarySounds.HANGAR_OVERLAY_STATE: AnniversarySounds.HANGAR_OVERLAY_STATE_ON}, exitStates={AnniversarySounds.HANGAR_OVERLAY_STATE: AnniversarySounds.HANGAR_OVERLAY_STATE_OFF}, persistentSounds=(), stoppableSounds=(), priorities=(), autoStart=True, enterEvent=None, exitEvent=None)