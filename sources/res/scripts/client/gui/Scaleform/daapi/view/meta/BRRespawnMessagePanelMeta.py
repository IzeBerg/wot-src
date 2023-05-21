from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class BRRespawnMessagePanelMeta(BaseDAAPIComponent):

    def as_addMessageS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_addMessage(data)

    def as_hideMessageS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideMessage()

    def as_setMessageTimeS(self, seconds):
        if self._isDAAPIInited():
            return self.flashObject.as_setMessageTime(seconds)