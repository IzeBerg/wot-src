from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class SixthSenseMeta(BaseDAAPIComponent):

    def as_showS(self, immidiate):
        if self._isDAAPIInited():
            return self.flashObject.as_show(immidiate)

    def as_showIndicatorS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_showIndicator()

    def as_hideS(self, immidiate):
        if self._isDAAPIInited():
            return self.flashObject.as_hide(immidiate)

    def as_setIsBigS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setIsBig(value)

    def as_setAlphaS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setAlpha(value)