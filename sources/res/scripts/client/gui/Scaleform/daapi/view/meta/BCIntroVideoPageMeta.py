from gui.Scaleform.framework.entities.View import View

class BCIntroVideoPageMeta(View):

    def videoStarted(self):
        self._printOverrideError('videoStarted')

    def videoFinished(self):
        self._printOverrideError('videoFinished')

    def goToBattle(self):
        self._printOverrideError('goToBattle')

    def skipBootcamp(self):
        self._printOverrideError('skipBootcamp')

    def handleError(self, data):
        self._printOverrideError('handleError')

    def onHighlightShow(self):
        self._printOverrideError('onHighlightShow')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)

    def as_updateProgressS(self, percent):
        if self._isDAAPIInited():
            return self.flashObject.as_updateProgress(percent)

    def as_loadedS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_loaded()

    def as_showIntroPageS(self, value, showRewards=False):
        if self._isDAAPIInited():
            return self.flashObject.as_showIntroPage(value, showRewards)

    def as_pausePlaybackS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_pausePlayback()

    def as_resumePlaybackS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_resumePlayback()