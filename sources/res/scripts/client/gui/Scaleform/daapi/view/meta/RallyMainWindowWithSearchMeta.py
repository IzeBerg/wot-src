from gui.Scaleform.daapi.view.lobby.rally.BaseRallyMainWindow import BaseRallyMainWindow

class RallyMainWindowWithSearchMeta(BaseRallyMainWindow):

    def onAutoMatch(self, value, values):
        self._printOverrideError('onAutoMatch')

    def autoSearchApply(self, value):
        self._printOverrideError('autoSearchApply')

    def autoSearchCancel(self, value):
        self._printOverrideError('autoSearchCancel')

    def as_autoSearchEnableBtnS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_autoSearchEnableBtn(value)

    def as_changeAutoSearchStateS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_changeAutoSearchState(value)

    def as_changeAutoSearchBtnsStateS(self, waitingPlayers, searchEnemy):
        if self._isDAAPIInited():
            return self.flashObject.as_changeAutoSearchBtnsState(waitingPlayers, searchEnemy)

    def as_hideAutoSearchS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideAutoSearch()

    def as_changeAutoSearchMainLabelS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_changeAutoSearchMainLabel(value)

    def as_changeAutoSearchTimeDirectionS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_changeAutoSearchTimeDirection(value)

    def as_changeAutoSearchCountDownSecondsS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_changeAutoSearchCountDownSeconds(value)