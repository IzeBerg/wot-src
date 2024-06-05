from enum import Enum
FEATURE = 'dog_tags'
MIN_VIEW_TIME = 2

class DogTagActions(Enum):
    CLICK = 'click'
    VIEWED = 'viewed'
    DISPLAY = 'display'


class DogTagsViewKeys(Enum):
    HANGAR = 'hangar'
    DOG_TAG = 'dog_tag_view'
    ACCOUNT_DASHBOARD = 'account_dashboard'
    ANIMATED_DOG_TAG = 'animated_dog_tag'


class DogTagButtons(Enum):
    INFO = 'dog_tag_info_button'


class DogTagKeys(Enum):
    ANIMATION_TOOLTIP = 'animated_dog_tag_tooltip'
    ACHIEVEMENT_CARD = 'achievement_card'


class DogTagAchievementStates(Enum):
    IN_PROGRESS = 'in_progress'
    NO_PROGRESS = 'no_progress'
    COMPLETED = 'completed'