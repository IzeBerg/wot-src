from gui.Scaleform.daapi.view.battle.shared.prebattle_timers.timer_base import PreBattleTimerBase
from gui.battle_control.battle_constants import COUNTDOWN_STATE
from helpers import dependency
from pve_battle_hud import WidgetType
from skeletons.gui.battle_session import IBattleSessionProvider

class PvePrebattleTimer(PreBattleTimerBase):
    _sessionProvider = dependency.descriptor(IBattleSessionProvider)

    def updateBattleCtx(self, battleCtx):
        self._battleTypeStr = battleCtx.getArenaDescriptionString(isInBattle=False)
        self.as_setMessageS(self._getMessage())

    def setCountdown(self, state, timeLeft):
        settingsCtrl = self._sessionProvider.dynamic.vseHUDSettings
        if settingsCtrl:
            countdownSettings = settingsCtrl.getSettings(WidgetType.COUNTDOWN)
            if countdownSettings:
                self.as_setWinConditionTextS(countdownSettings.getSubheader())
        self.as_setMessageS(self._getMessage())
        super(PvePrebattleTimer, self).setCountdown(state, timeLeft)

    def hideCountdown(self, state, speed):
        settingsCtrl = self._sessionProvider.dynamic.vseHUDSettings
        if settingsCtrl:
            countdownSettings = settingsCtrl.getSettings(WidgetType.COUNTDOWN)
            if countdownSettings:
                self.as_setMessageS(countdownSettings.getBattleStartMessage())
        self._clearTimeShiftCallback()
        self.as_hideAllS(speed != 0)

    def _getMessage(self):
        if self._state == COUNTDOWN_STATE.WAIT:
            msg = super(PvePrebattleTimer, self)._getMessage()
        else:
            msg = ''
            settingsCtrl = self._sessionProvider.dynamic.vseHUDSettings
            if settingsCtrl:
                countdownSettings = settingsCtrl.getSettings(WidgetType.COUNTDOWN)
                if countdownSettings:
                    msg = countdownSettings.getHeader()
        return msg