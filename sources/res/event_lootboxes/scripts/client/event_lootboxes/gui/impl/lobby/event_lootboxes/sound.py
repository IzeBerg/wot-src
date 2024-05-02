from enum import Enum
import cosmic_sound, WWISE

class _EventLootBoxesSounds(Enum):
    LOOT_BOX_ENTER = 'ev_cosmic_lootbox_award'
    LOOT_BOX_ENTER_SHORT = 'ev_cosmic_lootbox_award_short'
    LOOT_BOX_EXIT = 'ev_cosmic_lootbox_award_stop'
    LOOT_BOX_HIGHLIGHT = 'ev_cosmic_lootbox_highlight'
    STATE_GROUP = 'STATE_overlay_hangar_general'
    STATE_LOOTBOXES = 'STATE_overlay_hangar_general_on'
    STATE_GARAGE = 'STATE_overlay_hangar_general_off'


def enterLootBoxSoundState():
    WWISE.WW_setState(_EventLootBoxesSounds.STATE_GROUP.value, _EventLootBoxesSounds.STATE_LOOTBOXES.value)


def exitLootBoxSoundState():
    WWISE.WW_setState(_EventLootBoxesSounds.STATE_GROUP.value, _EventLootBoxesSounds.STATE_GARAGE.value)


def playStorageOpened(hasBoxes=False, animationEnabled=True):
    names = []
    if hasBoxes:
        names.append(_EventLootBoxesSounds.LOOT_BOX_HIGHLIGHT.value)
    if animationEnabled:
        names.append(_EventLootBoxesSounds.LOOT_BOX_ENTER.value)
    else:
        names.append(_EventLootBoxesSounds.LOOT_BOX_ENTER_SHORT.value)
    _playSound(names)


def playStorageClosed():
    _playSound((_EventLootBoxesSounds.LOOT_BOX_EXIT.value,))


def _playSound(names):
    for name in names:
        cosmic_sound.play2DSoundEvent(name)