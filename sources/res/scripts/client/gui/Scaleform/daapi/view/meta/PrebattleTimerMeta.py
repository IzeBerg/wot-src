from gui.Scaleform.daapi.view.battle.shared.prebattle_timers.timer_base import PreBattleTimerBase

class PrebattleTimerMeta(PreBattleTimerBase):

    def onShowInfo(self):
        self._printOverrideError('onShowInfo')

    def onHideInfo(self):
        self._printOverrideError('onHideInfo')

    def as_addInfoS(self, linkage, data):
        if self._isDAAPIInited():
            return self.flashObject.as_addInfo(linkage, data)

    def as_setInfoHintS(self, hint):
        if self._isDAAPIInited():
            return self.flashObject.as_setInfoHint(hint)

    def as_showInfoS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_showInfo()