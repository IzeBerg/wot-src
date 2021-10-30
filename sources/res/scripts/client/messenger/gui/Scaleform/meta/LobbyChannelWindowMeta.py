from messenger.gui.Scaleform.view.lobby.SimpleChannelWindow import SimpleChannelWindow

class LobbyChannelWindowMeta(SimpleChannelWindow):

    def onWarningClose(self):
        self._printOverrideError('onWarningClose')

    def as_getMembersDPS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_getMembersDP()

    def as_hideMembersListS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideMembersList()

    def as_showWarningS(self, warning):
        if self._isDAAPIInited():
            return self.flashObject.as_showWarning(warning)