from gui.Scaleform.daapi.view.battle.shared.battle_timers import PreBattleTimer
from gui.battle_control.battle_constants import COUNTDOWN_STATE
from gui.impl import backport
from gui.impl.gen import R

class HistoricalBattlesPreBattleTimer(PreBattleTimer):
    _ALT_MESSAGE_TIME = 2

    def setCountdown(self, state, timeLeft):
        super(HistoricalBattlesPreBattleTimer, self).setCountdown(state, timeLeft)
        if timeLeft <= self._ALT_MESSAGE_TIME:
            self.as_setMessageS(backport.text(R.strings.ingame_gui.timer.started()))

    def _getMessage(self):
        if self._state == COUNTDOWN_STATE.WAIT:
            return backport.text(R.strings.hb_battle.battleTimer.waiting())
        return backport.text(R.strings.hb_battle.battleTimer.defend())

    def _isDisplayWinCondition(self):
        return False