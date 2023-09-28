from gui.prb_control.entities.event.pre_queue.scheduler import EventScheduler

class HalloweenSquadScheduler(EventScheduler):

    def _doLeave(self):
        if self._entity.getFlags().isInQueue():
            if self._entity.getPlayerInfo().isCommander():
                self._entity.exitFromQueue()
        else:
            self._showRandomHangar()