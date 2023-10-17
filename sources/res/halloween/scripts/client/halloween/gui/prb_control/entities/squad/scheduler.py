from shared_utils import nextTick
from halloween.gui.prb_control.entities.pre_queue.scheduler import HalloweenBattleScheduler

class HalloweenSquadScheduler(HalloweenBattleScheduler):

    def __init__(self, entity):
        super(HalloweenSquadScheduler, self).__init__(entity)
        self.__isLeaveRequestSent = False

    def _doLeave(self):
        if self._entity and self._entity.getFlags().isInQueue():
            if self._entity.getPlayerInfo().isCommander() and not self.__isLeaveRequestSent:
                self._entity.exitFromQueue()
                self.__isLeaveRequestSent = True
            nextTick(self._doLeave)()
        else:
            self._showRandomHangar()
            self.__isLeaveRequestSent = False