from gui.battle_results.composer import IStatsComposer
from gui.prb_control import prbEntityProperty
from halloween.gui.battle_results import templates
from halloween.gui.shared import event_dispatcher

class HalloweenBattleStatsComposer(IStatsComposer):

    def __init__(self, _):
        super(HalloweenBattleStatsComposer, self).__init__()
        self._block = templates.HW_TOTAL_RESULTS_BLOCK.clone()

    @prbEntityProperty
    def prbEntity(self):
        return

    def clear(self):
        self._block.clear()

    def setResults(self, results, reusable):
        self._block.setRecord(results, reusable)

    def getVO(self):
        return self._block.getVO()

    def popAnimation(self):
        return

    @staticmethod
    def onShowResults(arenaUniqueID):
        pass

    @staticmethod
    def onResultsPosted(arenaUniqueID):
        if HalloweenBattleStatsComposer.prbEntity.isInQueue():
            return
        event_dispatcher.showBattleResult(arenaUniqueID)