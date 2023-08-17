from adisp import adisp_process
from gui import SystemMessages
from gui.impl import backport
from gui.impl.gen import R
from gui.periodic_battles.models import PrimeTimeStatus
from gui.prb_control import prbDispatcherProperty
from gui.prb_control.entities.base.ctx import LeavePrbAction
from gui.prb_control.entities.base.scheduler import BaseScheduler
from gui.prb_control.events_dispatcher import g_eventDispatcher
from helpers import dependency
from skeletons.gui.game_control import IComp7Controller

class Comp7Scheduler(BaseScheduler):
    comp7Controller = dependency.descriptor(IComp7Controller)

    def __init__(self, entity):
        super(Comp7Scheduler, self).__init__(entity)
        self.__isPrimeTime = False
        self.__hasPrimeTimePeripheries = False

    @prbDispatcherProperty
    def prbDispatcher(self):
        return

    def init(self):
        status, _, _ = self.comp7Controller.getPrimeTimeStatus()
        self.__isPrimeTime = status == PrimeTimeStatus.AVAILABLE
        self.__hasPrimeTimePeripheries = self.comp7Controller.hasAvailablePrimeTimeServers()
        self.comp7Controller.onStatusUpdated += self.__update

    def fini(self):
        self.comp7Controller.onStatusUpdated -= self.__update

    @adisp_process
    def __doLeave(self, isExit=True):
        yield self.prbDispatcher.doLeaveAction(LeavePrbAction(isExit))

    def __update(self, status):
        if not self.comp7Controller.isEnabled() or self.comp7Controller.isFrozen():
            self.__doLeave()
            return
        else:
            isPrimeTime = status == PrimeTimeStatus.AVAILABLE
            hasPrimeTimePeripheries = self.comp7Controller.hasAvailablePrimeTimeServers()
            if isPrimeTime != self.__isPrimeTime:
                self.__isPrimeTime = isPrimeTime
                if self.comp7Controller.getCurrentCycleID() is not None:
                    if self.__isPrimeTime and not self.__hasPrimeTimePeripheries:
                        SystemMessages.pushMessage(text=backport.text(R.strings.comp7.system_messages.primeTime.start.body()), type=SystemMessages.SM_TYPE.PrimeTime, messageData={'title': backport.text(R.strings.comp7.system_messages.primeTime.start.title())})
                    elif not hasPrimeTimePeripheries:
                        SystemMessages.pushMessage(text=backport.text(R.strings.comp7.system_messages.primeTime.end.body()), type=SystemMessages.SM_TYPE.PrimeTime, messageData={'title': backport.text(R.strings.comp7.system_messages.primeTime.end.title())})
                g_eventDispatcher.updateUI()
            self.__hasPrimeTimePeripheries = hasPrimeTimePeripheries
            return