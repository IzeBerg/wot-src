from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class PhaseIndicatorMeta(BaseDAAPIComponent):

    def as_setDataS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(value)

    def as_setVisibleS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setVisible(value)