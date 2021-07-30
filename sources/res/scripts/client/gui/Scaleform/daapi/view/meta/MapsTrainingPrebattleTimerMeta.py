from gui.Scaleform.daapi.view.battle.shared.prebattle_timers.timer_base import PreBattleTimerBase

class MapsTrainingPrebattleTimerMeta(PreBattleTimerBase):

    def as_updateS(self, data, text):
        if self._isDAAPIInited():
            return self.flashObject.as_update(data, text)

    def as_setSideS(self, side):
        if self._isDAAPIInited():
            return self.flashObject.as_setSide(side)