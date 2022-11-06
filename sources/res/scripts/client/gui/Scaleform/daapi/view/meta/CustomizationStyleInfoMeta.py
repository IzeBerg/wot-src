from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class CustomizationStyleInfoMeta(BaseDAAPIComponent):

    def onClose(self):
        self._printOverrideError('onClose')

    def onApply(self):
        self._printOverrideError('onApply')

    def onWidthUpdated(self, x, width, height):
        self._printOverrideError('onWidthUpdated')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)

    def as_buttonUpdateS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_buttonUpdate(data)

    def as_setBackgroundAlphaS(self, alpha):
        if self._isDAAPIInited():
            return self.flashObject.as_setBackgroundAlpha(alpha)

    def as_showS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_show()

    def as_hideS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hide()