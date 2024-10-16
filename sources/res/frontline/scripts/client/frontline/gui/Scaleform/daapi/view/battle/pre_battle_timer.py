import BigWorld
from constants import ARENA_GUI_TYPE
from gui.impl import backport
from gui.Scaleform.daapi.view.battle.shared.prebattle_timers.timer_base import PreBattleTimerBase
from gui.impl.gen import R
from gui.shared.utils import functions

class EpicPreBattleTimer(PreBattleTimerBase):

    def updateBattleCtx(self, battleCtx):
        player = BigWorld.player()
        self._battleTypeStr = self.__getTitle()
        self.as_setMessageS(self._getMessage())
        if self._isDisplayWinCondition():
            self.as_setWinConditionTextS(functions.getBattleSubTypeWinText(player.arenaTypeID, player.team))

    @staticmethod
    def __getTitle():
        descriptionRes = R.strings.menu.loading.battleTypes.num(ARENA_GUI_TYPE.EPIC_BATTLE)
        if descriptionRes.exists():
            return backport.text(descriptionRes())
        return ''