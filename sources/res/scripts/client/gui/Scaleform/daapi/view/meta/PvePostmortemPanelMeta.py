from gui.Scaleform.daapi.view.battle.shared.postmortem_panel import PostmortemPanel

class PvePostmortemPanelMeta(PostmortemPanel):

    def as_setHintTitleS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setHintTitle(value)

    def as_setHintDescrS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setHintDescr(value)

    def as_setTimerS(self, totalTime, currentTime):
        if self._isDAAPIInited():
            return self.flashObject.as_setTimer(totalTime, currentTime)

    def as_setCanExitS(self, canExit):
        if self._isDAAPIInited():
            return self.flashObject.as_setCanExit(canExit)

    def as_showLockedLivesS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_showLockedLives()

    def as_hidePanelS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hidePanel()