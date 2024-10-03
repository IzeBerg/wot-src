from gui.Scaleform.daapi.view.lobby.battle_queue import BattleQueue

class WTBattleQueueMeta(BattleQueue):

    def onQuickStartPanelAction(self, vehID):
        self._printOverrideError('onQuickStartPanelAction')

    def as_setAverageTimeS(self, textLabel, timeLabel):
        if self._isDAAPIInited():
            return self.flashObject.as_setAverageTime(textLabel, timeLabel)

    def as_setInfoTextS(self, text):
        if self._isDAAPIInited():
            return self.flashObject.as_setInfoText(text)

    def as_showQuickStartPanelS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_showQuickStartPanel(data)

    def as_hideQuickStartPanelS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideQuickStartPanel()