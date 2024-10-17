import BigWorld
from gui.Scaleform.daapi.view.battle.shared import battle_timers
from gui.battle_control.battle_constants import COUNTDOWN_STATE
from gui.impl import backport
from gui.impl.gen import R
from halloween_common.halloween_constants import ARENA_BONUS_TYPE
_HIDE_ALL_DELAY = 1.0

class PreBattleTimer(battle_timers.PreBattleTimer):

    def __init__(self):
        super(PreBattleTimer, self).__init__()
        self._hideAllCB = None
        return

    def _dispose(self):
        self._clearHideAllCB()
        super(PreBattleTimer, self)._dispose()

    def updateBattleCtx(self, battleCtx):
        self._battleTypeStr = battleCtx.getArenaDescriptionString(isInBattle=False)
        self.as_setMessageS(self._getMessage())
        self.as_setWinConditionTextS(self._getWinMessage())

    def _getMessage(self):
        return backport.text(self.__getMessageId())

    def _getWinMessage(self):
        if self.__isDefence:
            messageId = R.strings.halloween_battle.prebattle.defence.message()
        else:
            messageId = R.strings.halloween_battle.prebattle.description.message()
        return backport.text(messageId)

    def _onHideAll(self, speed):
        self._clearHideAllCB()
        self._hideAllCB = BigWorld.callback(_HIDE_ALL_DELAY, self._doHideAll)

    def _doHideAll(self):
        self._clearHideAllCB()
        self.as_hideAllS(False)

    def _clearHideAllCB(self):
        if self._hideAllCB is not None:
            BigWorld.cancelCallback(self._hideAllCB)
            self._hideAllCB = None
        return

    @property
    def __isDefence(self):
        return self.sessionProvider.arenaVisitor.getArenaBonusType() == ARENA_BONUS_TYPE.HALLOWEEN_DEFENCE

    def __getMessageId(self):
        if self._state == COUNTDOWN_STATE.WAIT:
            return R.strings.halloween_battle.prebattle.waiting.title()
        if self.__isDefence:
            return R.strings.halloween_battle.prebattle.defence.title()
        return R.strings.halloween_battle.prebattle.description.title()