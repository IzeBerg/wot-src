from gui.Scaleform.daapi.view.battle.shared.base_stats import StatsBase

class PlayersPanelMeta(StatsBase):

    def tryToSetPanelModeByMouse(self, panelMode):
        self._printOverrideError('tryToSetPanelModeByMouse')

    def switchToOtherPlayer(self, vehicleID):
        self._printOverrideError('switchToOtherPlayer')

    def as_setPanelModeS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setPanelMode(value)

    def as_setChatCommandsVisibilityS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setChatCommandsVisibility(value)

    def as_setPlayerHPS(self, isAlly, index, percent):
        if self._isDAAPIInited():
            return self.flashObject.as_setPlayerHP(isAlly, index, percent)

    def as_setOverrideExInfoS(self, exOverrideInfo):
        if self._isDAAPIInited():
            return self.flashObject.as_setOverrideExInfo(exOverrideInfo)

    def as_setPanelHPBarVisibilityStateS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setPanelHPBarVisibilityState(value)