from gui import GUI_SETTINGS
from skeletons.gui.login_manager import ILoginManager
__all__ = ('getLoginManagerConfig', )

def getLoginManagerConfig(manager):
    if GUI_SETTINGS.socialNetworkLogin['enabled']:
        from social_networks import Manager
        instance = Manager()
    else:
        from Manager import Manager
        instance = Manager()
    instance.init()
    manager.addInstance(ILoginManager, instance, finalizer='fini')