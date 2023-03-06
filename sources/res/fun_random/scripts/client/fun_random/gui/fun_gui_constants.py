from constants_utils import ConstInjector
from gui.prb_control import settings
from messenger import m_constants
ATTR_NAME = 'FUN_RANDOM'
PRB_REQ_TYPE_ATTR_NAME = 'CHANGE_FUN_SUB_MODE'

class FUNCTIONAL_FLAG(settings.FUNCTIONAL_FLAG, ConstInjector):
    FUN_RANDOM = 268435456


class PREBATTLE_ACTION_NAME(settings.PREBATTLE_ACTION_NAME, ConstInjector):
    _const_type = str
    FUN_RANDOM = 'fun_random'
    FUN_RANDOM_SQUAD = 'funRandomSquad'


class SELECTOR_BATTLE_TYPES(settings.SELECTOR_BATTLE_TYPES, ConstInjector):
    _const_type = str
    FUN_RANDOM = 'funRandom'


class REQUEST_TYPE(settings.REQUEST_TYPE, ConstInjector):
    CHANGE_FUN_SUB_MODE = 47


class SCH_CLIENT_MSG_TYPE(m_constants.SCH_CLIENT_MSG_TYPE, ConstInjector):
    FUN_RANDOM_NOTIFICATIONS = 100
    FUN_RANDOM_PROGRESSION = 101