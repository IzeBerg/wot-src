from gui.prb_control.events_dispatcher import g_eventDispatcher
from gui.prb_control.entities.stronghold.unit.actions_handler import StrongholdActionsHandler

class TournamentActionsHandler(StrongholdActionsHandler):

    def showGUI(self):
        g_eventDispatcher.showTournamentWindow()