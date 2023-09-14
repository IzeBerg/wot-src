from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class StoryModeTimerMeta(BaseDAAPIComponent):

    def as_updateTimeS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_updateTime(value)

    def as_showMessageS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_showMessage(value)

    def as_hideMessageS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideMessage()

    def as_setTimerStateS(self, state):
        if self._isDAAPIInited():
            return self.flashObject.as_setTimerState(state)

    def as_setTimerBackgroundS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setTimerBackground(value)

    def as_setHintStateS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setHintState(value)

    def as_playFxS(self, value, loop, color):
        if self._isDAAPIInited():
            return self.flashObject.as_playFx(value, loop, color)

    def as_updateTitleS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_updateTitle(value)

    def as_updateObjectiveS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_updateObjective(value)

    def as_updateObjectiveBigS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_updateObjectiveBig(value)

    def as_updateProgressBarS(self, value, vis):
        if self._isDAAPIInited():
            return self.flashObject.as_updateProgressBar(value, vis)