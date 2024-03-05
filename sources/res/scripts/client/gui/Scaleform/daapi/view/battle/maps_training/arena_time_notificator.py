from gui.battle_control.controllers.period_ctrl import IAbstractPeriodView
from helpers import dependency
from skeletons.gui.battle_session import IBattleSessionProvider
_TIME_TO_NOTIFY_BATTLE_END = 120

class MapsTrainingArenaTimeNotificator(IAbstractPeriodView):
    sessionProvider = dependency.descriptor(IBattleSessionProvider)

    def __init__(self):
        super(MapsTrainingArenaTimeNotificator, self).__init__()
        self.__prevLength = None
        self.__period = None
        self.__lastNotifiedTime = None
        return

    def setTotalTime(self, totalTime):
        if self.__lastNotifiedTime is None:
            self.__lastNotifiedTime = totalTime
        if totalTime == _TIME_TO_NOTIFY_BATTLE_END or totalTime < _TIME_TO_NOTIFY_BATTLE_END < self.__lastNotifiedTime:
            self.sessionProvider.dynamic.battleHints.showHint('maps_training.timeRunsOut', {'param1': _TIME_TO_NOTIFY_BATTLE_END})
        self.__lastNotifiedTime = totalTime
        return