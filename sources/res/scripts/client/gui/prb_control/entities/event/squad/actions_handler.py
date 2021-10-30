from constants import SQUAD_SETTINGS
from gui.prb_control.entities.base.squad.actions_handler import SquadActionsHandler
from gui.prb_control.events_dispatcher import g_eventDispatcher

class EventBattleSquadActionsHandler(SquadActionsHandler):

    def __init__(self, entity):
        super(EventBattleSquadActionsHandler, self).__init__(entity)
        self._minOccupiedSlotsCount = SQUAD_SETTINGS.EVENT_MIN_OCCUPIED_SLOTS_COUNT

    def _showBattleQueueGUI(self):
        g_eventDispatcher.loadEventBattleQueue()