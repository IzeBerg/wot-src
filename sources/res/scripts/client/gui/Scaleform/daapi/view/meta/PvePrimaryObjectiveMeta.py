from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class PvePrimaryObjectiveMeta(BaseDAAPIComponent):

    def as_showMessageS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_showMessage(value)

    def as_hideMessageS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideMessage()

    def as_playFxS(self, value, loop):
        if self._isDAAPIInited():
            return self.flashObject.as_playFx(value, loop)

    def as_setHintStateS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setHintState(value)

    def as_setTimerBackgroundS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setTimerBackground(value)

    def as_setTimerStateS(self, state):
        if self._isDAAPIInited():
            return self.flashObject.as_setTimerState(state)

    def as_updateTimeS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_updateTime(value)

    def as_updateProgressBarS(self, value, vis):
        if self._isDAAPIInited():
            return self.flashObject.as_updateProgressBar(value, vis)

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)

    def as_showResultS(self, isWin, icon, header):
        if self._isDAAPIInited():
            return self.flashObject.as_showResult(isWin, icon, header)

    def as_hideResultS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideResult()