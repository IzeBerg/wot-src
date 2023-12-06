from gui.shared.lock_overlays import lockNotificationManager as doLock
_LOCK_SOURCE_NAME = 'BATTLE_PASS_REWARD_LOGIC'

def lockNotificationManager(lock, notificationManager=None):
    doLock(lock, source=_LOCK_SOURCE_NAME, notificationManager=notificationManager)