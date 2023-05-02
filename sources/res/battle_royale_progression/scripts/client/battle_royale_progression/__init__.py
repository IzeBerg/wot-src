

def initProgression():
    from gui.game_control import registerBRProgressionAwardControllers, registerBRGameControllers
    from gui.gui_constants import registerSystemMessagesTypes
    from messenger.formatters import registerMessengerClientFormatters
    from notification import registerClientNotificationHandlers
    registerSystemMessagesTypes()
    registerBRProgressionAwardControllers()
    registerClientNotificationHandlers()
    registerMessengerClientFormatters()
    registerBRGameControllers()