from gui.Scaleform.daapi.view.meta.DAAPISimpleContainerMeta import DAAPISimpleContainerMeta

class SplashScreenMeta(DAAPISimpleContainerMeta):

    def onComplete(self):
        self._printOverrideError('onComplete')

    def onError(self):
        self._printOverrideError('onError')

    def fadeOutComplete(self):
        self._printOverrideError('fadeOutComplete')

    def as_playVideoS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_playVideo(data)

    def as_setSizeS(self, width, height):
        if self._isDAAPIInited():
            return self.flashObject.as_setSize(width, height)

    def as_fadeOutS(self, time):
        if self._isDAAPIInited():
            return self.flashObject.as_fadeOut(time)