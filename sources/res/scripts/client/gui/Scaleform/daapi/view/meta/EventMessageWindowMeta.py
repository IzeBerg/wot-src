from gui.Scaleform.framework.entities.abstract.AbstractWindowView import AbstractWindowView

class EventMessageWindowMeta(AbstractWindowView):

    def onResult(self, ok):
        self._printOverrideError('onResult')

    def as_setMessageDataS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setMessageData(value)

    def as_blurOtherWindowsS(self, container):
        if self._isDAAPIInited():
            return self.flashObject.as_blurOtherWindows(container)