from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class NotificationPopUpViewerMeta(BaseDAAPIComponent):

    def setListClear(self):
        self._printOverrideError('setListClear')

    def onMessageHidden(self, byTimeout, wasNotified, typeID, entityID):
        self._printOverrideError('onMessageHidden')

    def onClickAction(self, typeID, entityID, action):
        self._printOverrideError('onClickAction')

    def getMessageActualTime(self, msTime):
        self._printOverrideError('getMessageActualTime')

    def as_hasPopUpIndexS(self, typeID, entityID):
        if self._isDAAPIInited():
            return self.flashObject.as_hasPopUpIndex(typeID, entityID)

    def as_appendMessageS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_appendMessage(data)

    def as_updateMessageS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_updateMessage(data)

    def as_removeMessageS(self, typeID, entityID):
        if self._isDAAPIInited():
            return self.flashObject.as_removeMessage(typeID, entityID)

    def as_removeAllMessagesS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_removeAllMessages()

    def as_initInfoS(self, maxMessagessCount, padding):
        if self._isDAAPIInited():
            return self.flashObject.as_initInfo(maxMessagessCount, padding)

    def as_setViewPaddingS(self, enabled, paddingX, paddingY):
        if self._isDAAPIInited():
            return self.flashObject.as_setViewPadding(enabled, paddingX, paddingY)