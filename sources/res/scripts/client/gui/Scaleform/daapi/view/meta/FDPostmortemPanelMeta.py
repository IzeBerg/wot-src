from gui.Scaleform.daapi.view.battle.shared.postmortem_panel import PostmortemPanel

class FDPostmortemPanelMeta(PostmortemPanel):

    def as_setHintTitleS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setHintTitle(value)

    def as_setHintDescrS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setHintDescr(value)

    def as_setTimerS(self, time):
        if self._isDAAPIInited():
            return self.flashObject.as_setTimer(time)