from gui.Scaleform.daapi.view.battle.shared import battle_timers
from gui.battle_control.battle_constants import COUNTDOWN_STATE
from gui.impl import backport
from gui.impl.gen import R

class PreBattleTimer(battle_timers.PreBattleTimer):

    def updateBattleCtx(self, battleCtx):
        self._battleTypeStr = battleCtx.getArenaDescriptionString(isInBattle=False)
        self.as_setMessageS(self._getMessage())
        self.as_setWinConditionTextS(self._getWinMessage())

    def _getMessage(self):
        if self._state == COUNTDOWN_STATE.WAIT:
            return backport.text(R.strings.halloween_battle.prebattle.waiting.title())
        return backport.text(R.strings.halloween_battle.prebattle.description.title())

    def _getWinMessage(self):
        return backport.text(R.strings.halloween_battle.prebattle.description.message())