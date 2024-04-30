from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class HBPhaseIndicatorMeta(BaseDAAPIComponent):

    def as_setDataS(self, current, total):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(current, total)

    def as_setVisibleS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setVisible(value)