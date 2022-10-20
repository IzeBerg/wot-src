from halloween.messenger.formatters import service_channel as _sc
from messenger.formatters.collections_by_type import addClientFormatters
from messenger.m_constants import SCH_CLIENT_MSG_TYPE
CLIENT_FORMATTERS = {SCH_CLIENT_MSG_TYPE.EVENT_LIFETIME_TYPE: _sc.EventLifetimeFormatter()}

def addHW22ClientFormatters():
    addClientFormatters(CLIENT_FORMATTERS)