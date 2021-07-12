from gui.server_events.EventsCache import EventsCache as _EventsCache
from gui.server_events.linkedset_controller import LinkedSetController as _LinkedSetController
from skeletons.gui.server_events import IEventsCache
from skeletons.gui.linkedset import ILinkedSetController
__all__ = ('getServerEventsConfig', 'getLinkedSetController')

def getServerEventsConfig(manager):
    cache = _EventsCache()
    cache.init()
    manager.addInstance(IEventsCache, cache, finalizer='fini')


def getLinkedSetController(manager):
    controller = _LinkedSetController()
    controller.init()
    manager.addInstance(ILinkedSetController, controller, finalizer='fini')