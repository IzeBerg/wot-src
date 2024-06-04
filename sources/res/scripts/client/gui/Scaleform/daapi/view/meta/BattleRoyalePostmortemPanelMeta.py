from gui.Scaleform.daapi.view.battle.shared.postmortem_panel import PostmortemPanel

class BattleRoyalePostmortemPanelMeta(PostmortemPanel):

    def as_setPostmortemPanelCanBeVisibleS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setPostmortemPanelCanBeVisible(value)