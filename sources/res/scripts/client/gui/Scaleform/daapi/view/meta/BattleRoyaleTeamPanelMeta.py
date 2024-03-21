from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class BattleRoyaleTeamPanelMeta(BaseDAAPIComponent):

    def as_setInitDataS(self, title, names, clans, playerTeamIndex):
        if self._isDAAPIInited():
            return self.flashObject.as_setInitData(title, names, clans, playerTeamIndex)

    def as_setPlayerStateS(self, index, accountDBID, vID, teamIndex, alive, ready, hpPercent, fragsCount, vehicleLevel, icon):
        if self._isDAAPIInited():
            return self.flashObject.as_setPlayerState(index, accountDBID, vID, teamIndex, alive, ready, hpPercent, fragsCount, vehicleLevel, icon)

    def as_setPlayerStatusS(self, index, alive, ready, isRespawning=False):
        if self._isDAAPIInited():
            return self.flashObject.as_setPlayerStatus(index, alive, ready, isRespawning)

    def as_setPlayerHPS(self, index, percent):
        if self._isDAAPIInited():
            return self.flashObject.as_setPlayerHP(index, percent)

    def as_setPlayerFragsS(self, index, count):
        if self._isDAAPIInited():
            return self.flashObject.as_setPlayerFrags(index, count)

    def as_setVehicleLevelS(self, index, level):
        if self._isDAAPIInited():
            return self.flashObject.as_setVehicleLevel(index, level)

    def as_setPlayerVehicleS(self, index, icon):
        if self._isDAAPIInited():
            return self.flashObject.as_setPlayerVehicle(index, icon)