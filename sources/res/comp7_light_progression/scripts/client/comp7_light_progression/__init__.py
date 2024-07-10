

def initProgression():
    from gui.game_control import registerComp7LightProgressionAwardControllers, registerComp7LightGameControllers
    from gui.gui_constants import registerSystemMessagesTypes
    from messenger.formatters import registerMessengerClientFormatters
    from notification import registerClientNotificationHandlers
    registerSystemMessagesTypes()
    registerComp7LightProgressionAwardControllers()
    registerClientNotificationHandlers()
    registerMessengerClientFormatters()
    registerComp7LightGameControllers()