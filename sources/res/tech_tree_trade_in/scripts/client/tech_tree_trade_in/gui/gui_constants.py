from constants_utils import ConstInjector
from messenger import m_constants

class SCH_CLIENT_MSG_TYPE(m_constants.SCH_CLIENT_MSG_TYPE, ConstInjector):
    TECH_TREE_TRADE_IN_COMPLETED_NOTIFICATION = 400
    TECH_TREE_TRADE_IN_DETAILS_NOTIFICATION = 401