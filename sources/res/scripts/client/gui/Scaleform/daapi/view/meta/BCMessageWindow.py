from gui.Scaleform.framework.entities.View import View

class BCMessageWindow(View):

    def onMessageRemoved(self):
        self._printOverrideError('onMessageRemoved')

    def as_setMessageDataS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setMessageData(value)