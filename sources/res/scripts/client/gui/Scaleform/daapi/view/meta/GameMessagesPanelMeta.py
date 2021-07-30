from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class GameMessagesPanelMeta(BaseDAAPIComponent):

    def onMessageStarted(self, type, modificator, id):
        self._printOverrideError('onMessageStarted')

    def onMessagePhaseStarted(self, type, modificator, id):
        self._printOverrideError('onMessagePhaseStarted')

    def onMessageEnded(self, type, id):
        self._printOverrideError('onMessageEnded')

    def onMessageHiding(self, type, id):
        self._printOverrideError('onMessageHiding')

    def as_addMessageS(self, messageVO):
        if self._isDAAPIInited():
            return self.flashObject.as_addMessage(messageVO)

    def as_clearMessagesS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_clearMessages()