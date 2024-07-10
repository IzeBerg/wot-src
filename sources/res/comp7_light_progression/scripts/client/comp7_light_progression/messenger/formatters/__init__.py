from comp7_light_progression.gui.gui_constants import SCH_CLIENT_MSG_TYPE
from comp7_light_progression.messenger.formatters.service_channel import Comp7LightProgressionSystemMessageFormatter
from gui.shared.system_factory import registerMessengerClientFormatter
clientFormatters = {SCH_CLIENT_MSG_TYPE.COMP7_LIGHT_PROGRESSION_NOTIFICATIONS: Comp7LightProgressionSystemMessageFormatter()}

def registerMessengerClientFormatters():
    for sysMsgType, formatter in clientFormatters.iteritems():
        registerMessengerClientFormatter(sysMsgType, formatter)