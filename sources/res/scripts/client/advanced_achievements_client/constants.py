from enum import Enum

class AchievementType(Enum):
    REGULAR = 'regular'
    STEPPED = 'stepped'
    CUMULATIVE = 'cumulative'
    SUBCATEGORY = 'subcategory'


NEAREST_REQUIRED_COUNT = 3
TROPHIES_ACHIEVEMENT_ID = -1
BONUS_PRIORITY_MAP = {'dogTagComponents': 1, 
   'customizations': 2}