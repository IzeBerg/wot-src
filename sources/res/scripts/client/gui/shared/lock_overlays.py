from helpers import dependency
from skeletons.gui.impl import INotificationWindowController

@dependency.replace_none_kwargs(notificationManager=INotificationWindowController)
def lockNotificationManager(lock, source=__name__, releasePostponed=False, fireReleased=True, notificationManager=None):
    isLocked = notificationManager.hasLock(source)
    if lock and not isLocked:
        notificationManager.lock(source)
    elif not lock and isLocked:
        notificationManager.unlock(source)
        if releasePostponed:
            notificationManager.releasePostponed(fireReleased)