from white_tiger.notification.actions_handlers import ShowWTBattleResultsHandler, OpenWTEventPortalsHandler, OpenWTEventCollectionHandler, OpenWTEventHandler, OpenWTEventQuestsHandler, OpenWTEventTicketPurchasingHandler
from gui.shared.system_factory import registerNotificationsActionsHandlers

def registerClientNotificationHandlers():
    registerNotificationsActionsHandlers((
     ShowWTBattleResultsHandler,
     OpenWTEventPortalsHandler,
     OpenWTEventCollectionHandler,
     OpenWTEventHandler,
     OpenWTEventQuestsHandler,
     OpenWTEventTicketPurchasingHandler))