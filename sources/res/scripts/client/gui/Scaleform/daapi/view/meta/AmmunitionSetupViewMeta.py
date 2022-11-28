from gui.Scaleform.framework.entities.View import View

class AmmunitionSetupViewMeta(View):

    def onClose(self):
        self._printOverrideError('onClose')

    def onEscapePress(self):
        self._printOverrideError('onEscapePress')

    def as_gfSizeUpdatedS(self, x, width):
        if self._isDAAPIInited():
            return self.flashObject.as_gfSizeUpdated(x, width)

    def as_showCloseAnimS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_showCloseAnim()

    def as_onAnimationEndS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_onAnimationEnd()