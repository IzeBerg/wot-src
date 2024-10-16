from gui.Scaleform.daapi.view.battle.classic.players_panel import PlayersPanel

class HWPlayersPanelMeta(PlayersPanel):

    def as_setPlayerPanelInfoS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setPlayerPanelInfo(data)

    def as_setPlayerPanelHpS(self, vehID, hpMax, hpCurrent):
        if self._isDAAPIInited():
            return self.flashObject.as_setPlayerPanelHp(vehID, hpMax, hpCurrent)

    def as_setPlayerDeadS(self, vehID):
        if self._isDAAPIInited():
            return self.flashObject.as_setPlayerDead(vehID)

    def as_setPostmortemS(self, isPostmortem):
        if self._isDAAPIInited():
            return self.flashObject.as_setPostmortem(isPostmortem)