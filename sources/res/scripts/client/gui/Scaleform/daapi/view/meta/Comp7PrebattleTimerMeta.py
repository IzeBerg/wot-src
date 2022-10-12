from gui.Scaleform.daapi.view.battle.shared.battle_timers import PreBattleTimer

class Comp7PrebattleTimerMeta(PreBattleTimer):

    def onReadyBtnClick(self):
        self._printOverrideError('onReadyBtnClick')

    def as_hideInfoS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideInfo()