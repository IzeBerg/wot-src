from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class PveBossIndicatorProgressMeta(BaseDAAPIComponent):

    def as_setValueS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setValue(value)

    def as_setIndicatorEnabledS(self, isEnabled):
        if self._isDAAPIInited():
            return self.flashObject.as_setIndicatorEnabled(isEnabled)