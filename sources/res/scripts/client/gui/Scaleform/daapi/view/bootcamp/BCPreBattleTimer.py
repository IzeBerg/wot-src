from gui.impl.gen import R
from gui.impl import backport
from gui.Scaleform.daapi.view.battle.shared.prebattle_timers.timer_base import PreBattleTimerBase

class BCPreBattleTimer(PreBattleTimerBase):

    def updateBattleCtx(self, battleCtx):
        self._battleTypeStr = battleCtx.getArenaWinString()
        self.as_setMessageS(self._getMessage())
        if self._isDisplayWinCondition():
            self.as_setWinConditionTextS(backport.text(R.strings.bootcamp.arena.name()))

    def _getMessage(self):
        return self._battleTypeStr