from gui.Scaleform.framework.entities.View import View

class IntroPageMeta(View):

    def stopVideo(self):
        self._printOverrideError('stopVideo')

    def handleError(self, data):
        self._printOverrideError('handleError')

    def tweenComplete(self):
        self._printOverrideError('tweenComplete')

    def videoStarted(self):
        self._printOverrideError('videoStarted')

    def as_playVideoS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_playVideo(data)

    def as_fadeOutS(self, time):
        if self._isDAAPIInited():
            return self.flashObject.as_fadeOut(time)