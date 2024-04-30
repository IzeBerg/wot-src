from gui.Scaleform.daapi.view.battle.shared.postmortem_panel import PostmortemPanel

class HBPostmortemPanelMeta(PostmortemPanel):

    def as_setHintTitleS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setHintTitle(value)

    def as_setHintDescrS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setHintDescr(value)

    def as_setTimerS(self, time):
        if self._isDAAPIInited():
            return self.flashObject.as_setTimer(time)

    def as_setCanExitS(self, canExit):
        if self._isDAAPIInited():
            return self.flashObject.as_setCanExit(canExit)

    def as_setIsLockedS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setIsLocked(value)