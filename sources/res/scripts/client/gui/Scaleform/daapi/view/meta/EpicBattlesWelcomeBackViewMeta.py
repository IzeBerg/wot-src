from gui.Scaleform.framework.entities.View import View

class EpicBattlesWelcomeBackViewMeta(View):

    def onBackBtnClicked(self):
        self._printOverrideError('onBackBtnClicked')

    def onCloseBtnClicked(self):
        self._printOverrideError('onCloseBtnClicked')

    def onContinueBtnClicked(self):
        self._printOverrideError('onContinueBtnClicked')

    def onChangesLinkClicked(self):
        self._printOverrideError('onChangesLinkClicked')

    def playVideo(self):
        self._printOverrideError('playVideo')

    def as_setInitDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setInitData(data)