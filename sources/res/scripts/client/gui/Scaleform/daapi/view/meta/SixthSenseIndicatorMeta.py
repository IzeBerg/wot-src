from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class SixthSenseIndicatorMeta(BaseDAAPIComponent):

    def as_showS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_show()

    def as_hideS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hide()

    def as_setIsSmallS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setIsSmall(value)

    def as_setAlphaS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setAlpha(value)