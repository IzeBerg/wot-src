from gui.Scaleform.framework.entities.View import View

class WaitingViewMeta(View):

    def as_showWaitingS(self, message, softStart, showBg):
        if self._isDAAPIInited():
            return self.flashObject.as_showWaiting(message, softStart, showBg)

    def as_showBackgroundImgS(self, img):
        if self._isDAAPIInited():
            return self.flashObject.as_showBackgroundImg(img)

    def as_hideWaitingS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideWaiting()