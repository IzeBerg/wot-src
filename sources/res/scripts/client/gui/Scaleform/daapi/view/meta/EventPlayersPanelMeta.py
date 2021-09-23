from gui.Scaleform.daapi.view.battle.classic.players_panel import PlayersPanel

class EventPlayersPanelMeta(PlayersPanel):

    def as_setIsBossS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setIsBoss(value)

    def as_setBossBotInfoS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setBossBotInfo(data)

    def as_updateBossBombTimerS(self, id, timeLeft, timeTotal, replaySpeed=1):
        if self._isDAAPIInited():
            return self.flashObject.as_updateBossBombTimer(id, timeLeft, timeTotal, replaySpeed)

    def as_updateBossBotHpS(self, vehID, hpMax, hpCurrent):
        if self._isDAAPIInited():
            return self.flashObject.as_updateBossBotHp(vehID, hpMax, hpCurrent)

    def as_setBossBotSpottedS(self, vehID, status):
        if self._isDAAPIInited():
            return self.flashObject.as_setBossBotSpotted(vehID, status)

    def as_clearBossBotCampS(self, campId):
        if self._isDAAPIInited():
            return self.flashObject.as_clearBossBotCamp(campId)