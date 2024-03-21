from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class SpectatorViewMeta(BaseDAAPIComponent):

    def as_setFollowInfoTextS(self, folowText):
        if self._isDAAPIInited():
            return self.flashObject.as_setFollowInfoText(folowText)

    def as_changeModeS(self, mode):
        if self._isDAAPIInited():
            return self.flashObject.as_changeMode(mode)

    def as_focusOnVehicleS(self, focused):
        if self._isDAAPIInited():
            return self.flashObject.as_focusOnVehicle(focused)

    def as_setTimerS(self, time):
        if self._isDAAPIInited():
            return self.flashObject.as_setTimer(time)

    def as_setSpeedS(self, speed):
        if self._isDAAPIInited():
            return self.flashObject.as_setSpeed(speed)

    def as_setHintStringsS(self, movementHeadline, movementDescription, speedHeadline, speedDescription, heightHeadline, heightDescription, spectatorUpBtnText, spectatorDownBtnText):
        if self._isDAAPIInited():
            return self.flashObject.as_setHintStrings(movementHeadline, movementDescription, speedHeadline, speedDescription, heightHeadline, heightDescription, spectatorUpBtnText, spectatorDownBtnText)

    def as_showMovementHintS(self, shouldShow):
        if self._isDAAPIInited():
            return self.flashObject.as_showMovementHint(shouldShow)

    def as_showSpeedHeightHintS(self, shouldShow):
        if self._isDAAPIInited():
            return self.flashObject.as_showSpeedHeightHint(shouldShow)

    def as_showReturnHintS(self, shouldShow):
        if self._isDAAPIInited():
            return self.flashObject.as_showReturnHint(shouldShow)

    def as_showSpeedHintS(self, shouldShow):
        if self._isDAAPIInited():
            return self.flashObject.as_showSpeedHint(shouldShow)

    def as_toggleHintS(self, hintModeId):
        if self._isDAAPIInited():
            return self.flashObject.as_toggleHint(hintModeId)

    def as_handleAsReplayS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_handleAsReplay()

    def as_updateMovementHintControlsS(self, forward, left, backward, right):
        if self._isDAAPIInited():
            return self.flashObject.as_updateMovementHintControls(forward, left, backward, right)