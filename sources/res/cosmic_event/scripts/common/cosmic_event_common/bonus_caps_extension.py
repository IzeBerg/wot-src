import constants_utils
from constants import ARENA_GUI_TYPE, ARENA_BONUS_TYPE, QUEUE_TYPE, PREBATTLE_TYPE
ATTR_NAME = 'COSMIC_EVENT'

def attrValidator(personality):
    constants_utils.checkAttrNameExist(ATTR_NAME, [ARENA_GUI_TYPE, ARENA_BONUS_TYPE, QUEUE_TYPE, PREBATTLE_TYPE], personality)