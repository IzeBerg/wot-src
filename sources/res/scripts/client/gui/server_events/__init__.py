from gui.server_events.EventsCache import EventsCache as _EventsCache
from skeletons.gui.server_events import IEventsCache
from skeletons.gui.battle_matters import IBattleMattersController
__all__ = ('getServerEventsConfig', 'getBattleMattersController')

def getServerEventsConfig(manager):
    cache = _EventsCache()
    cache.init()
    manager.addInstance(IEventsCache, cache, finalizer='fini')


def getBattleMattersController(manager):
    from gui.game_control.battle_matters_controller import BattleMattersController
    controller = BattleMattersController()
    controller.init()
    manager.addInstance(IBattleMattersController, controller, finalizer='fini')