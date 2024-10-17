import BigWorld
from gui import SystemMessages
from gui.battle_results.composer import IBattleResultStatsCtrl
from gui.prb_control import prbEntityProperty
from gui.impl import backport
from gui.impl.gen import R
from gui.shared.notifications import NotificationPriorityLevel
from halloween.gui.battle_results import templates
from halloween.gui.shared import event_dispatcher

def showErrorMessage():
    SystemMessages.pushI18nMessage(backport.text(R.strings.system_messages.queue.isInQueue()), type=SystemMessages.SM_TYPE.Error, priority=NotificationPriorityLevel.HIGH)


class HalloweenBattleStatsComposer(IBattleResultStatsCtrl):

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
            BigWorld.callback(0, showErrorMessage)
            return
        event_dispatcher.showBattleResult(arenaUniqueID)