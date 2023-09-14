from gui.Scaleform.framework.entities.View import View

class IntroVideoMeta(View):

    def onVideoStarted(self):
        self._printOverrideError('onVideoStarted')

    def onVideoComplete(self):
        self._printOverrideError('onVideoComplete')

    def onSkipButtonVisible(self):
        self._printOverrideError('onSkipButtonVisible')

    def onSkipButtonClicked(self):
        self._printOverrideError('onSkipButtonClicked')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)

    def as_setCurrentSubtitleS(self, text):
        if self._isDAAPIInited():
            return self.flashObject.as_setCurrentSubtitle(text)

    def as_loadedS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_loaded()

    def as_pausePlaybackS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_pausePlayback()

    def as_resumePlaybackS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_resumePlayback()

    def as_handleKeydownS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_handleKeydown()