from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class PointCounterMeta(BaseDAAPIComponent):

    def as_updateCountS(self, count, reasonType):
        if self._isDAAPIInited():
            return self.flashObject.as_updateCount(count, reasonType)

    def as_enableAnimationS(self, value=True):
        if self._isDAAPIInited():
            return self.flashObject.as_enableAnimation(value)

    def as_setSoulsCapS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setSoulsCap(value)