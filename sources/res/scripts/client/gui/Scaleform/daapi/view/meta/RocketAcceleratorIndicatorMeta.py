from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class RocketAcceleratorIndicatorMeta(BaseDAAPIComponent):

    def as_setStateS(self, state):
        if self._isDAAPIInited():
            return self.flashObject.as_setState(state)

    def as_setVisibleS(self, visible):
        if self._isDAAPIInited():
            return self.flashObject.as_setVisible(visible)

    def as_setCountS(self, count):
        if self._isDAAPIInited():
            return self.flashObject.as_setCount(count)

    def as_setProgressS(self, progress):
        if self._isDAAPIInited():
            return self.flashObject.as_setProgress(progress)

    def as_setActiveTimeS(self, time):
        if self._isDAAPIInited():
            return self.flashObject.as_setActiveTime(time)

    def as_updateLayoutS(self, x, y):
        if self._isDAAPIInited():
            return self.flashObject.as_updateLayout(x, y)