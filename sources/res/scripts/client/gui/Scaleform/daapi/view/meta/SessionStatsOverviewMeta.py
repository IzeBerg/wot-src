from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class SessionStatsOverviewMeta(BaseDAAPIComponent):

    def onClickMoreBtn(self):
        self._printOverrideError('onClickMoreBtn')

    def onClickResetBtn(self):
        self._printOverrideError('onClickResetBtn')

    def onClickSettingsBtn(self):
        self._printOverrideError('onClickSettingsBtn')

    def onExpanded(self, value):
        self._printOverrideError('onExpanded')

    def onTabSelected(self, alias):
        self._printOverrideError('onTabSelected')

    def onCounterUpdated(self):
        self._printOverrideError('onCounterUpdated')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)

    def as_setButtonsStateS(self, states):
        if self._isDAAPIInited():
            return self.flashObject.as_setButtonsState(states)

    def as_setHeaderTooltipS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setHeaderTooltip(value)