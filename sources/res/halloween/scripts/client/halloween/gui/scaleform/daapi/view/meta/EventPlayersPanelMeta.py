from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class EventPlayersPanelMeta(BaseDAAPIComponent):

    def acceptSquad(self, sessionID):
        self._printOverrideError('acceptSquad')

    def addToSquad(self, sessionID):
        self._printOverrideError('addToSquad')

    def as_setPlayerPanelInfoS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setPlayerPanelInfo(data)

    def as_clearPlayerPanelS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_clearPlayerPanel()

    def as_setPlayerPanelHpS(self, vehID, hpMax, hpCurrent):
        if self._isDAAPIInited():
            return self.flashObject.as_setPlayerPanelHp(vehID, hpMax, hpCurrent)

    def as_setPlayerDeadS(self, vehID):
        if self._isDAAPIInited():
            return self.flashObject.as_setPlayerDead(vehID)

    def as_setPlayerPanelCountSoulsS(self, vehID, countSouls):
        if self._isDAAPIInited():
            return self.flashObject.as_setPlayerPanelCountSouls(vehID, countSouls)

    def as_setCollectorGoalS(self, goal):
        if self._isDAAPIInited():
            return self.flashObject.as_setCollectorGoal(goal)

    def as_setCollectorNeedValueS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setCollectorNeedValue(value)

    def as_setChatCommandS(self, vehicleID, chatCommand, chatCommandFlags):
        if self._isDAAPIInited():
            return self.flashObject.as_setChatCommand(vehicleID, chatCommand, chatCommandFlags)