from enum import Enum
DT_PDATA_KEY = 'dogTags'

class Settings(Enum):
    SHOW_VICTIMS_DT = 'showVictimsDogTag'
    SHOW_DT_TO_KILLER = 'showDogTagToKiller'

    def __lt__(self, other):
        return self.value < other.value


SETTINGS_POSITIONS = {Settings.SHOW_VICTIMS_DT: 1, 
   Settings.SHOW_DT_TO_KILLER: 2}