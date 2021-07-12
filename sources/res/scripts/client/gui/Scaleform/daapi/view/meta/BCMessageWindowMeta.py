from tutorial.gui.Scaleform.pop_ups import TutorialDialog

class BCMessageWindowMeta(TutorialDialog):

    def onMessageRemoved(self):
        self._printOverrideError('onMessageRemoved')

    def onMessageAppear(self, rendrerer):
        self._printOverrideError('onMessageAppear')

    def onMessageDisappear(self, rendrerer):
        self._printOverrideError('onMessageDisappear')

    def onMessageExecuted(self, rendrerer):
        self._printOverrideError('onMessageExecuted')

    def onMessageButtonClicked(self):
        self._printOverrideError('onMessageButtonClicked')

    def hideBlur(self):
        self._printOverrideError('hideBlur')

    def as_setMessageDataS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setMessageData(value)

    def as_blurOtherWindowsS(self, layer):
        if self._isDAAPIInited():
            return self.flashObject.as_blurOtherWindows(layer)