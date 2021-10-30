from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class EventCoinsCounterMeta(BaseDAAPIComponent):

    def as_setCoinsCountS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setCoinsCount(value)

    def as_setCoinsTooltipS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setCoinsTooltip(value)