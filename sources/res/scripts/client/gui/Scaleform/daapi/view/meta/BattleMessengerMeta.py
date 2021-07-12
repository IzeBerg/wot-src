from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class BattleMessengerMeta(BaseDAAPIComponent):

    def sendMessageToChannel(self, cid, message):
        self._printOverrideError('sendMessageToChannel')

    def focusReceived(self):
        self._printOverrideError('focusReceived')

    def focusLost(self):
        self._printOverrideError('focusLost')

    def getToxicStatus(self, messageID):
        self._printOverrideError('getToxicStatus')

    def onToxicButtonClicked(self, messageID, actionID):
        self._printOverrideError('onToxicButtonClicked')

    def onToxicPanelClosed(self, messageID):
        self._printOverrideError('onToxicPanelClosed')

    def as_enableToxicPanelS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_enableToxicPanel()

    def as_updateMessagesS(self, messageID, value):
        if self._isDAAPIInited():
            return self.flashObject.as_updateMessages(messageID, value)

    def as_showGreenMessageS(self, message, messageID):
        if self._isDAAPIInited():
            return self.flashObject.as_showGreenMessage(message, messageID)

    def as_showRedMessageS(self, message, messageID):
        if self._isDAAPIInited():
            return self.flashObject.as_showRedMessage(message, messageID)

    def as_showBlackMessageS(self, message, messageID):
        if self._isDAAPIInited():
            return self.flashObject.as_showBlackMessage(message, messageID)

    def as_showSelfMessageS(self, message, messageID):
        if self._isDAAPIInited():
            return self.flashObject.as_showSelfMessage(message, messageID)

    def as_setupListS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setupList(data)

    def as_setReceiverS(self, data, isResetReceivers):
        if self._isDAAPIInited():
            return self.flashObject.as_setReceiver(data, isResetReceivers)

    def as_changeReceiverS(self, receiver):
        if self._isDAAPIInited():
            return self.flashObject.as_changeReceiver(receiver)

    def as_setActiveS(self, isActive):
        if self._isDAAPIInited():
            return self.flashObject.as_setActive(isActive)

    def as_setFocusS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_setFocus()

    def as_unSetFocusS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_unSetFocus()

    def as_setUserPreferencesS(self, tooltipStr):
        if self._isDAAPIInited():
            return self.flashObject.as_setUserPreferences(tooltipStr)

    def as_setReceiversS(self, receivers):
        if self._isDAAPIInited():
            return self.flashObject.as_setReceivers(receivers)

    def as_enableToSendMessageS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_enableToSendMessage()

    def as_toggleCtrlPressFlagS(self, isCtrlPressed):
        if self._isDAAPIInited():
            return self.flashObject.as_toggleCtrlPressFlag(isCtrlPressed)

    def as_enterPressedS(self, index):
        if self._isDAAPIInited():
            return self.flashObject.as_enterPressed(index)

    def as_updateToxicPanelS(self, messageID, value):
        if self._isDAAPIInited():
            return self.flashObject.as_updateToxicPanel(messageID, value)

    def as_restoreMessagesS(self, messageID):
        if self._isDAAPIInited():
            return self.flashObject.as_restoreMessages(messageID)