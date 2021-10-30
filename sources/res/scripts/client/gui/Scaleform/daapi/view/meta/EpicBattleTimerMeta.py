from gui.Scaleform.daapi.view.battle.shared.battle_timers import BattleTimer

class EpicBattleTimerMeta(BattleTimer):

    def as_setTotalTimeWithSecondsS(self, minutes, seconds, timeFactor):
        if self._isDAAPIInited():
            return self.flashObject.as_setTotalTimeWithSeconds(minutes, seconds, timeFactor)

    def as_enableOvertimeS(self, enabled):
        if self._isDAAPIInited():
            return self.flashObject.as_enableOvertime(enabled)