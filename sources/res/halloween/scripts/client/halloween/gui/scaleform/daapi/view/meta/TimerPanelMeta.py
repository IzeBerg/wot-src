from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class TimerPanelMeta(BaseDAAPIComponent):

    def as_updateTimeS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_updateTime(value)

    def as_setTimerStateS(self, state):
        if self._isDAAPIInited():
            return self.flashObject.as_setTimerState(state)

    def as_playFxS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_playFx()

    def as_updateTitleS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_updateTitle(value)