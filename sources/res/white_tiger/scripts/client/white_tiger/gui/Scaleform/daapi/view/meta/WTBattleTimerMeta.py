from gui.Scaleform.daapi.view.battle.shared.battle_timers import BattleTimer

class WTBattleTimerMeta(BattleTimer):

    def as_setPlayerTypeS(self, isBoss):
        if self._isDAAPIInited():
            return self.flashObject.as_setPlayerType(isBoss)

    def as_showAdditionalTimeS(self, time):
        if self._isDAAPIInited():
            return self.flashObject.as_showAdditionalTime(time)

    def as_showMessageS(self, message, isOverTime=False):
        if self._isDAAPIInited():
            return self.flashObject.as_showMessage(message, isOverTime)

    def as_hideMessageS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideMessage()