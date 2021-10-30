from gui.Scaleform.daapi.view.battle.classic.players_panel import PlayersPanel

class SuperPlatoonPanelMeta(PlayersPanel):

    def as_setPlatoonTitleS(self, title):
        if self._isDAAPIInited():
            return self.flashObject.as_setPlatoonTitle(title)

    def as_setMaxDisplayedInviteMessagesS(self, maxInvites):
        if self._isDAAPIInited():
            return self.flashObject.as_setMaxDisplayedInviteMessages(maxInvites)