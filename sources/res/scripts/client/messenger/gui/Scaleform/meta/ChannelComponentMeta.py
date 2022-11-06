from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class ChannelComponentMeta(BaseDAAPIComponent):

    def isJoined(self):
        self._printOverrideError('isJoined')

    def sendMessage(self, message):
        self._printOverrideError('sendMessage')

    def getHistory(self):
        self._printOverrideError('getHistory')

    def getMessageMaxLength(self):
        self._printOverrideError('getMessageMaxLength')

    def onLinkClick(self, linkCode):
        self._printOverrideError('onLinkClick')

    def as_notifyInfoChangedS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_notifyInfoChanged()

    def as_setJoinedS(self, flag):
        if self._isDAAPIInited():
            return self.flashObject.as_setJoined(flag)

    def as_addMessageS(self, message):
        if self._isDAAPIInited():
            return self.flashObject.as_addMessage(message)

    def as_getLastUnsentMessageS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_getLastUnsentMessage()

    def as_setLastUnsentMessageS(self, message):
        if self._isDAAPIInited():
            return self.flashObject.as_setLastUnsentMessage(message)