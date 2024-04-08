from gui.Scaleform.framework.entities.View import View

class LobbyMenuMeta(View):

    def settingsClick(self):
        self._printOverrideError('settingsClick')

    def cancelClick(self):
        self._printOverrideError('cancelClick')

    def refuseTraining(self):
        self._printOverrideError('refuseTraining')

    def logoffClick(self):
        self._printOverrideError('logoffClick')

    def quitClick(self):
        self._printOverrideError('quitClick')

    def postClick(self):
        self._printOverrideError('postClick')

    def onCounterNeedUpdate(self):
        self._printOverrideError('onCounterNeedUpdate')

    def onEscapePress(self):
        self._printOverrideError('onEscapePress')

    def manualClick(self):
        self._printOverrideError('manualClick')

    def showLegal(self):
        self._printOverrideError('showLegal')

    def as_setVersionMessageS(self, message):
        if self._isDAAPIInited():
            return self.flashObject.as_setVersionMessage(message)

    def as_setCounterS(self, counters):
        if self._isDAAPIInited():
            return self.flashObject.as_setCounter(counters)

    def as_removeCounterS(self, counters):
        if self._isDAAPIInited():
            return self.flashObject.as_removeCounter(counters)

    def as_setPostButtonIconsS(self, iconClose, iconOpen):
        if self._isDAAPIInited():
            return self.flashObject.as_setPostButtonIcons(iconClose, iconOpen)

    def as_setPostButtonVisibleS(self, isVisible):
        if self._isDAAPIInited():
            return self.flashObject.as_setPostButtonVisible(isVisible)

    def as_showManualButtonS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_showManualButton(value)

    def as_setManualButtonIconS(self, icon):
        if self._isDAAPIInited():
            return self.flashObject.as_setManualButtonIcon(icon)

    def as_setMenuStateS(self, state):
        if self._isDAAPIInited():
            return self.flashObject.as_setMenuState(state)

    def as_setCopyrightS(self, copyrightVal, legalInfo):
        if self._isDAAPIInited():
            return self.flashObject.as_setCopyright(copyrightVal, legalInfo)

    def as_showVersionS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_showVersion(value)