

def initProgression():
    from gui.game_control import registerHBProgressionAwardControllers, registerHBGameControllers
    from messenger.formatters import registerMessengerClientFormatters
    from notification import registerClientNotificationHandlers
    registerHBProgressionAwardControllers()
    registerClientNotificationHandlers()
    registerMessengerClientFormatters()
    registerHBGameControllers()