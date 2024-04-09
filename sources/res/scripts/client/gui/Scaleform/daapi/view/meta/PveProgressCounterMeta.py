from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class PveProgressCounterMeta(BaseDAAPIComponent):

    def as_setDataS(self, icon, title, isAnimated=True):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(icon, title, isAnimated)