from gui.Scaleform.framework.entities.View import View

class ImageViewMeta(View):

    def onClose(self):
        self._printOverrideError('onClose')

    def as_setBgPathS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setBgPath(value)