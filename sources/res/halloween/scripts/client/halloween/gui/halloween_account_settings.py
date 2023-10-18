from copy import deepcopy
from account_helpers import AccountSettings
from halloween.gui.halloween_gui_constants import DifficultyLevel

class AccountSettingsKeys(object):
    EVENT_KEY = 'hw23_keys'
    SELECTED_LEVEL = 'selected_level'
    UNLOCK_LEVELS = 'unlock_levels'
    META_INTRO_VIEW_SHOWED = 'meta_into_view_showed'
    FAVORITES_VEHICLE = 'favorites'
    SOUND = 'sound'
    CHAT_FIRST_SEEN = 'chat_first_seen'


ACCOUNT_DEFAULT_SETTINGS = {AccountSettingsKeys.EVENT_KEY: {AccountSettingsKeys.SELECTED_LEVEL: DifficultyLevel.EASY.value, 
                                   AccountSettingsKeys.UNLOCK_LEVELS: [], AccountSettingsKeys.META_INTRO_VIEW_SHOWED: False, 
                                   AccountSettingsKeys.FAVORITES_VEHICLE: 0, 
                                   AccountSettingsKeys.SOUND: {}, AccountSettingsKeys.CHAT_FIRST_SEEN: False}}

def getSettings(name):
    settings = AccountSettings.getSettings(AccountSettingsKeys.EVENT_KEY)
    return settings.get(name, deepcopy(AccountSettings.getSettingsDefault(AccountSettingsKeys.EVENT_KEY)[name]))


def setSettings(name, value):
    settings = AccountSettings.getSettings(AccountSettingsKeys.EVENT_KEY)
    settings[name] = value
    AccountSettings.setSettings(AccountSettingsKeys.EVENT_KEY, settings)


def isSoundPlayed(name, difficultyLevel):
    soundsSettings = getSettings(AccountSettingsKeys.SOUND)
    soundsByDifficultyLevel = soundsSettings.get(difficultyLevel.value)
    if soundsByDifficultyLevel:
        return name in soundsByDifficultyLevel
    return False


def setSoundPlayed(name, difficultyLevel):
    soundsSettings = getSettings(AccountSettingsKeys.SOUND)
    soundsByDifficultyLevel = soundsSettings.setdefault(difficultyLevel.value, set())
    soundsByDifficultyLevel.add(name)
    setSettings(AccountSettingsKeys.SOUND, soundsSettings)


def setUnlockedLevel(level):
    settings = AccountSettings.getSettings(AccountSettingsKeys.EVENT_KEY)
    unlockedLevels = settings[AccountSettingsKeys.UNLOCK_LEVELS]
    if level not in unlockedLevels and level in (DifficultyLevel.EASY.value,
     DifficultyLevel.MEDIUM.value,
     DifficultyLevel.HARD.value):
        unlockedLevels.append(level)
        settings[AccountSettingsKeys.UNLOCK_LEVELS] = unlockedLevels
        AccountSettings.setSettings(AccountSettingsKeys.EVENT_KEY, settings)