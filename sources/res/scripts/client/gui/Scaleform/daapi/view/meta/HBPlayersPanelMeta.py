from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class HBPlayersPanelMeta(BaseDAAPIComponent):

    def acceptSquad(self, sessionID):
        self._printOverrideError('acceptSquad')

    def addToSquad(self, sessionID):
        self._printOverrideError('addToSquad')

    def switchToOtherPlayer(self, vehicleID):
        self._printOverrideError('switchToOtherPlayer')

    def as_getDPS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_getDP()

    def as_setPlayerHpS(self, vehID, hpMax, hpCurrent, isSkipAnimation=False):
        if self._isDAAPIInited():
            return self.flashObject.as_setPlayerHp(vehID, hpMax, hpCurrent, isSkipAnimation)

    def as_setPlayerCountLivesS(self, vehID, countLives):
        if self._isDAAPIInited():
            return self.flashObject.as_setPlayerCountLives(vehID, countLives)

    def as_setChatCommandS(self, vehID, chatCommand, chatCommandFlags):
        if self._isDAAPIInited():
            return self.flashObject.as_setChatCommand(vehID, chatCommand, chatCommandFlags)

    def as_setChatCommandsVisibilityS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setChatCommandsVisibility(value)

    def as_setPlayersSwitchingAllowedS(self, isAllowed):
        if self._isDAAPIInited():
            return self.flashObject.as_setPlayersSwitchingAllowed(isAllowed)