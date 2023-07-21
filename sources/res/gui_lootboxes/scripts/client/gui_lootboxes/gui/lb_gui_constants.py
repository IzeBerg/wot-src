from constants_utils import ConstInjector
from messenger import m_constants

class SCH_CLIENT_MSG_TYPE(m_constants.SCH_CLIENT_MSG_TYPE, ConstInjector):
    LB_OPENED = 30001