from fun_random.notification.actions_handlers import SelectFunRandomMode
from fun_random.notification.listeners import FunRandomEventsListener
from gui.shared.system_factory import registerNotificationsListeners, registerNotificationsActionsHandlers

def registerFunRandomNotifications():
    registerNotificationsListeners((FunRandomEventsListener,))
    registerNotificationsActionsHandlers((SelectFunRandomMode,))