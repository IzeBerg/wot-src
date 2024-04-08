from gui.Scaleform.daapi.view.battle.shared.postmortem_panel import PostmortemPanel

class BattleRoyalePostmortemPanelMeta(PostmortemPanel):

    def as_showDeadReasonS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_showDeadReason()

    def as_setPlayerInfoS(self, playerInfo):
        if self._isDAAPIInited():
            return self.flashObject.as_setPlayerInfo(playerInfo)

    def as_setPostmortemPanelVisibleS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setPostmortemPanelVisible(value)