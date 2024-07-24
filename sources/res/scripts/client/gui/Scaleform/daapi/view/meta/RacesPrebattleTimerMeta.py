from gui.Scaleform.daapi.view.battle.shared.battle_timers import PreBattleTimer

class RacesPrebattleTimerMeta(PreBattleTimer):

    def onFirstLight(self):
        self._printOverrideError('onFirstLight')

    def onLastLights(self):
        self._printOverrideError('onLastLights')

    def as_setColorBlindS(self, enabled):
        if self._isDAAPIInited():
            return self.flashObject.as_setColorBlind(enabled)