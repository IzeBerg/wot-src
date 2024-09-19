from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class EventOvertimeMeta(BaseDAAPIComponent):

    def as_updateOvertimeTimerS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_updateOvertimeTimer(value)

    def as_getOvertimeInfoS(self, isBoss, isLowQuality):
        if self._isDAAPIInited():
            return self.flashObject.as_getOvertimeInfo(isBoss, isLowQuality)