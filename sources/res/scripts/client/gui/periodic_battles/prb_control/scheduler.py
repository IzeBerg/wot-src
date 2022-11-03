import BigWorld
from gui.impl import backport
from gui import SystemMessages
from gui.prb_control.entities.base.pre_queue.ctx import LeavePreQueueCtx
from gui.prb_control.entities.base.scheduler import BaseScheduler
from gui.prb_control.events_dispatcher import g_eventDispatcher
from gui.periodic_battles.models import PrimeTimeStatus
from shared_utils import first

class PeriodicScheduler(BaseScheduler):
    _RES_ROOT = None

    def __init__(self, entity):
        super(PeriodicScheduler, self).__init__(entity)
        self.__isPrimeTime = False
        self.__isConfigured = False

    def init(self):
        self._startListening()
        self._initScheduler()

    def fini(self):
        self._stopListening()

    def _hasConfiguredNotification(self):
        return True

    def _getController(self):
        raise NotImplementedError

    def _getMessageParams(self):
        return {}

    def _getPrimeTimeStatus(self, controller=None):
        controller = controller or self._getController()
        if controller:
            return first(controller.getPrimeTimeStatus())
        else:
            return

    def _checkLeave(self, controller=None, status=None):
        controller = controller or self._getController()
        status = status if status is not None else self._getPrimeTimeStatus(controller)
        if controller is None or status is None or not controller.isAvailable():
            BigWorld.callback(0.0, self._doLeave)
            return True
        else:
            return False

    def _doLeave(self):
        if self._entity is None:
            return
        else:
            self._entity.leave(LeavePreQueueCtx(waitingID='prebattle/leave'))
            return

    def _initScheduler(self):
        status = self._getPrimeTimeStatus()
        if self._checkLeave(status=status):
            return
        self.__isPrimeTime = status == PrimeTimeStatus.AVAILABLE
        self.__isConfigured = status != PrimeTimeStatus.NOT_SET
        self.__show(isInit=True)

    def _startListening(self):
        self._getController().onGameModeStatusUpdated += self._updateScheduler

    def _stopListening(self):
        self._getController().onGameModeStatusUpdated -= self._updateScheduler

    def _updateScheduler(self, status):
        if self._checkLeave(status=status):
            return
        isPrimeTime = status == PrimeTimeStatus.AVAILABLE
        isConfigured = status != PrimeTimeStatus.NOT_SET
        if isPrimeTime != self.__isPrimeTime or isConfigured != self.__isConfigured:
            self.__isPrimeTime = isPrimeTime
            self.__isConfigured = isConfigured
            self.__show()
            g_eventDispatcher.updateUI()

    def __show(self, isInit=False):
        controller = self._getController()
        if controller is None or not controller.isBattlesPossible():
            return
        if not self.__isConfigured and self._hasConfiguredNotification():
            SystemMessages.pushMessage(backport.text(self._RES_ROOT.notification.notSet(), **self._getMessageParams()), messageData={'title': backport.text(self._RES_ROOT.notification.notSet.title())}, type=SystemMessages.SM_TYPE.PeriodicBattlesNotSet)
        elif not self.__isPrimeTime:
            SystemMessages.pushMessage(backport.text(self._RES_ROOT.notification.primeTime(), **self._getMessageParams()), messageData={'title': backport.text(self._RES_ROOT.notification.primeTime.title())}, type=SystemMessages.SM_TYPE.PrimeTime)
        elif not isInit:
            SystemMessages.pushMessage(backport.text(self._RES_ROOT.notification.available(), **self._getMessageParams()), messageData={'title': backport.text(self._RES_ROOT.notification.available.title())}, type=SystemMessages.SM_TYPE.PeriodicBattlesAvailable)
        return