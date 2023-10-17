from gui.prb_control.entities.base.scheduler import BaseScheduler
from gui.prb_control.entities.base.pre_queue.ctx import LeavePreQueueCtx
from gui.prb_control.events_dispatcher import g_eventDispatcher
from shared_utils import nextTick
from helpers import dependency
from halloween.skeletons.halloween_controller import IHalloweenController

class HalloweenBattleScheduler(BaseScheduler):
    __halloweenBattleCtrl = dependency.descriptor(IHalloweenController)

    def init(self):
        self.__halloweenBattleCtrl.onEventDisabled += self.__onEventDisabled
        self.__halloweenBattleCtrl.onSettingsUpdate += self.__onSettingsUpdate

    def fini(self):
        self.__halloweenBattleCtrl.onEventDisabled -= self.__onEventDisabled
        self.__halloweenBattleCtrl.onSettingsUpdate -= self.__onSettingsUpdate

    def _doLeave(self):
        if self._entity:
            self._entity.leave(LeavePreQueueCtx(waitingID='prebattle/leave'))
        self._showRandomHangar()

    def _showRandomHangar(self):
        self.__halloweenBattleCtrl.selectRandomMode()

    def __onEventDisabled(self):
        nextTick(self._doLeave)()

    def __onSettingsUpdate(self):
        g_eventDispatcher.updateUI()