from gui.Scaleform.framework.entities.View import View

class PersonalMissionsOperationAwardsScreenMeta(View):

    def onCloseWindow(self):
        self._printOverrideError('onCloseWindow')

    def onPlaySound(self, soundType):
        self._printOverrideError('onPlaySound')

    def as_setInitDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setInitData(data)

    def as_setAwardDataS(self, awardData):
        if self._isDAAPIInited():
            return self.flashObject.as_setAwardData(awardData)

    def as_setCloseBtnEnabledS(self, enabled):
        if self._isDAAPIInited():
            return self.flashObject.as_setCloseBtnEnabled(enabled)

    def as_playAwardsAnimationS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_playAwardsAnimation()