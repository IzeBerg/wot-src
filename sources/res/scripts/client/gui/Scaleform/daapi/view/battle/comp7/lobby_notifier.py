import BigWorld
from gui.battle_control.controllers.period_ctrl import IAbstractPeriodView
from constants import ARENA_PERIOD
_NOTIFICATION_TIME = 20.0

class LobbyNotifier(IAbstractPeriodView):

    def __init__(self):
        super(LobbyNotifier, self).__init__()
        self.__isNotified = False

    def setCountdown(self, state, timeLeft):
        if state == ARENA_PERIOD.PREBATTLE and timeLeft <= _NOTIFICATION_TIME:
            self.__doNotify()

    def __doNotify(self):
        if not self.__isNotified:
            BigWorld.WGWindowsNotifier.onBattleBeginning()
            self.__isNotified = True