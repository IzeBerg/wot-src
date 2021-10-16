from enum import Enum
FEATURE = 'manual'

class ManualLogActions(Enum):
    OPEN = 'open'
    CLOSE = 'close'
    CLICK = 'click'


class ManualLogKeys(Enum):
    LOBBY_MENU_BUTTON = 'lobby_menu_button'
    CHAPTER_VIDEO = 'chapter_video'