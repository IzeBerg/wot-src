from gui.Scaleform.framework.entities.View import View

class BattleStrongholdsQueueMeta(View):

    def exitClick(self):
        self._printOverrideError('exitClick')

    def onEscape(self):
        self._printOverrideError('onEscape')

    def as_setTimerS(self, textLabel, timeLabel):
        if self._isDAAPIInited():
            return self.flashObject.as_setTimer(textLabel, timeLabel)

    def as_setTypeInfoS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setTypeInfo(data)

    def as_setLeaguesS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setLeagues(data)

    def as_showExitS(self, vis):
        if self._isDAAPIInited():
            return self.flashObject.as_showExit(vis)

    def as_showWaitingS(self, description):
        if self._isDAAPIInited():
            return self.flashObject.as_showWaiting(description)

    def as_hideWaitingS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideWaiting()