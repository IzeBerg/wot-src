from gui.Scaleform.framework.entities.View import View

class PersonalMissionsQuestAwardScreenMeta(View):

    def closeView(self):
        self._printOverrideError('closeView')

    def onNextQuestLinkClick(self):
        self._printOverrideError('onNextQuestLinkClick')

    def onNextQuestBtnClick(self):
        self._printOverrideError('onNextQuestBtnClick')

    def onRecruitBtnClick(self):
        self._printOverrideError('onRecruitBtnClick')

    def onContinueBtnClick(self):
        self._printOverrideError('onContinueBtnClick')

    def onOkBtnClick(self):
        self._printOverrideError('onOkBtnClick')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)