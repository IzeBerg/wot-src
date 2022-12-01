from gui.prb_control import settings
ATTR_NAME = 'FUN_RANDOM'
PRB_REQ_TYPE_ATTR_NAME = 'CHANGE_FUN_SUB_MODE'

class FunctionalFlag(settings.FUNCTIONAL_FLAG):
    FUN_RANDOM = 268435456


class PrebattleActionName(settings.PREBATTLE_ACTION_NAME):
    FUN_RANDOM = 'fun_random'


class RequestType(settings.REQUEST_TYPE):
    CHANGE_FUN_SUB_MODE = 47


class SelectorBattleTypes(settings.SELECTOR_BATTLE_TYPES):
    FUN_RANDOM = 'funRandom'