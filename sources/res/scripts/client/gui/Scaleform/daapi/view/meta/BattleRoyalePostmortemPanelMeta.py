from gui.Scaleform.daapi.view.meta.BasePostmortemPanelMeta import BasePostmortemPanelMeta

class BattleRoyalePostmortemPanelMeta(BasePostmortemPanelMeta):

    def as_showDeadReasonS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_showDeadReason()

    def as_setPlayerInfoS(self, playerInfo):
        if self._isDAAPIInited():
            return self.flashObject.as_setPlayerInfo(playerInfo)

    def as_setSpectatorPanelVisibleS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setSpectatorPanelVisible(value)