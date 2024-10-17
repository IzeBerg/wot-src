from gui.Scaleform.daapi.view.battle.shared.postmortem_panel import PostmortemPanel

class PostmortemPanelMeta(PostmortemPanel):

    def as_setHintTitleS(self, value, isShadow=True):
        if self._isDAAPIInited():
            return self.flashObject.as_setHintTitle(value, isShadow)

    def as_setHintDescrS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setHintDescr(value)

    def as_showRespawnIconS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_showRespawnIcon(value)

    def as_setCanExitS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setCanExit(value)

    def as_showSpectatorPanelS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_showSpectatorPanel(value)