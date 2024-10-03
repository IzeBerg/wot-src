from gui.battle_results.composer import RegularStatsComposer
from white_tiger.gui.shared.event_dispatcher import showBattleResultsWindow

class WhiteTigerBattleStatsComposer(RegularStatsComposer):

    @staticmethod
    def onShowResults(arenaUniqueID):
        return

    @staticmethod
    def onResultsPosted(arenaUniqueID):
        showBattleResultsWindow(arenaUniqueID)