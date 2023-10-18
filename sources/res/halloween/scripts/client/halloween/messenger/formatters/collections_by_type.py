from halloween.messenger.formatters import service_channel as _sc
from messenger.m_constants import SCH_CLIENT_MSG_TYPE
from gui.shared.system_factory import registerMessengerClientFormatter

def addHW22ClientFormatters():
    registerMessengerClientFormatter(SCH_CLIENT_MSG_TYPE.EVENT_LIFETIME_TYPE, _sc.EventLifetimeFormatter())