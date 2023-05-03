from battle_royale_progression.gui import gui_constants
from battle_royale_progression.messenger.formatters.service_channel import BRProgressionSystemMessageFormatter
from gui.shared.system_factory import registerMessengerClientFormatter
clientFormatters = {gui_constants.SCH_CLIENT_MSG_TYPE.BR_PROGRESSION_NOTIFICATIONS: BRProgressionSystemMessageFormatter()}

def registerMessengerClientFormatters():
    for sysMsgType, formatter in clientFormatters.iteritems():
        registerMessengerClientFormatter(sysMsgType, formatter)