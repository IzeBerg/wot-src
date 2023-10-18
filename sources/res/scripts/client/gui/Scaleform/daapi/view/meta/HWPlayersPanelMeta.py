from gui.Scaleform.daapi.view.battle.classic.players_panel import PlayersPanel

class HWPlayersPanelMeta(PlayersPanel):

    def as_setPlayerBuffS(self, isAlly, index, image):
        if self._isDAAPIInited():
            return self.flashObject.as_setPlayerBuff(isAlly, index, image)