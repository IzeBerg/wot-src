from gui.prb_control.entities.base.squad.actions_handler import SquadActionsHandler
from gui.prb_control.events_dispatcher import g_eventDispatcher

class WhiteTigerBattleSquadActionsHandler(SquadActionsHandler):

    @classmethod
    def _loadBattleQueue(cls):
        g_eventDispatcher.loadEventBattleQueue()