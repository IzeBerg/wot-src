from constants_utils import ConstInjector
from gui.prb_control import settings
DEFAULT_QUEUE_TYPE_PRIORITY = 0
NOOB_MIN_BATTLES_COUNT = 10

class FUNCTIONAL_FLAG(settings.FUNCTIONAL_FLAG, ConstInjector):
    VERSUS_AI = 9223372036854775808


class PREBATTLE_ACTION_NAME(settings.PREBATTLE_ACTION_NAME, ConstInjector):
    _const_type = str
    VERSUS_AI = 'versusAI'
    VERSUS_AI_SQUAD = 'versusAISquad'


class SELECTOR_BATTLE_TYPES(settings.SELECTOR_BATTLE_TYPES, ConstInjector):
    _const_type = str
    VERSUS_AI = 'versusAI'