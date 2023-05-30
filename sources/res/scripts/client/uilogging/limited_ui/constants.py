from enum import Enum
FEATURE = 'limited_ui'

class LimitedUILogItem(Enum):
    DISABLE_LIMITED_UI_BUTTON = 'disable_limited_ui_button'


class LimitedUILogScreenParent(Enum):
    SETTINGS_WINDOW = 'settings_window'


class LimitedUILogActions(Enum):
    CLICK = 'click'