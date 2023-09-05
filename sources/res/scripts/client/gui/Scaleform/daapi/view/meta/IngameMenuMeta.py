from gui.Scaleform.framework.entities.abstract.AbstractWindowView import AbstractWindowView

class IngameMenuMeta(AbstractWindowView):

    def quitBattleClick(self):
        self._printOverrideError('quitBattleClick')

    def settingsClick(self):
        self._printOverrideError('settingsClick')

    def helpClick(self):
        self._printOverrideError('helpClick')

    def cancelClick(self):
        self._printOverrideError('cancelClick')

    def onCounterNeedUpdate(self):
        self._printOverrideError('onCounterNeedUpdate')

    def as_setServerSettingS(self, serverName, tooltipFullData, serverState):
        if self._isDAAPIInited():
            return self.flashObject.as_setServerSetting(serverName, tooltipFullData, serverState)

    def as_setServerStatsS(self, stats, tooltipType):
        if self._isDAAPIInited():
            return self.flashObject.as_setServerStats(stats, tooltipType)

    def as_setCounterS(self, counters):
        if self._isDAAPIInited():
            return self.flashObject.as_setCounter(counters)

    def as_removeCounterS(self, counters):
        if self._isDAAPIInited():
            return self.flashObject.as_removeCounter(counters)

    def as_setMenuButtonsLabelsS(self, helpLabel, settingsLabel, cancelLabel, quitLabel):
        if self._isDAAPIInited():
            return self.flashObject.as_setMenuButtonsLabels(helpLabel, settingsLabel, cancelLabel, quitLabel)

    def as_setMenuButtonsS(self, buttons):
        if self._isDAAPIInited():
            return self.flashObject.as_setMenuButtons(buttons)

    def as_setVisibilityS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setVisibility(value)