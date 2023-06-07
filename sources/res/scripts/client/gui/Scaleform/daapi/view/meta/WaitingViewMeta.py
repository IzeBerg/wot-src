from gui.Scaleform.framework.entities.View import View

class WaitingViewMeta(View):

    def as_showWaitingS(self, message, softStart):
        if self._isDAAPIInited():
            return self.flashObject.as_showWaiting(message, softStart)

    def as_showBackgroundImgS(self, img, showSparks):
        if self._isDAAPIInited():
            return self.flashObject.as_showBackgroundImg(img, showSparks)

    def as_hideWaitingS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideWaiting()