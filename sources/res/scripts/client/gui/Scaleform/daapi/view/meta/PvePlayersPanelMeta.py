from gui.Scaleform.daapi.view.battle.classic.players_panel import PlayersPanel

class PvePlayersPanelMeta(PlayersPanel):

    def as_setCountLivesVisibilityS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setCountLivesVisibility(value)

    def as_setRightPanelVisibilityS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setRightPanelVisibility(value)