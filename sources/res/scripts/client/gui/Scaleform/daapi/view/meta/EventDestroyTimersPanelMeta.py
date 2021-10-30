from gui.Scaleform.daapi.view.battle.shared.timers_panel import TimersPanel

class EventDestroyTimersPanelMeta(TimersPanel):

    def setComponentsOverlay(self, isRibbonsPanelOverlay, isBuffsPanelOverlay):
        self._printOverrideError('setComponentsOverlay')

    def as_setWarningTextS(self, text):
        if self._isDAAPIInited():
            return self.flashObject.as_setWarningText(text)

    def as_setFillingInProgressS(self, current, total, isActive, visible):
        if self._isDAAPIInited():
            return self.flashObject.as_setFillingInProgress(current, total, isActive, visible)

    def as_setGotoPointTimerS(self, timeLeft, timeMax, message, visible):
        if self._isDAAPIInited():
            return self.flashObject.as_setGotoPointTimer(timeLeft, timeMax, message, visible)

    def as_setWaitForAlliesS(self, visible):
        if self._isDAAPIInited():
            return self.flashObject.as_setWaitForAllies(visible)

    def as_hideAllNotificationsS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideAllNotifications()