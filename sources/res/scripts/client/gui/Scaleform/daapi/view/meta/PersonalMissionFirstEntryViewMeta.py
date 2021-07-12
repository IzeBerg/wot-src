from gui.Scaleform.framework.entities.View import View

class PersonalMissionFirstEntryViewMeta(View):

    def playVideo(self):
        self._printOverrideError('playVideo')

    def backBtnClicked(self):
        self._printOverrideError('backBtnClicked')

    def onViewClose(self, isAcceptBtnClick):
        self._printOverrideError('onViewClose')

    def onCardClick(self, cardID):
        self._printOverrideError('onCardClick')

    def onNextCardClick(self, cardID):
        self._printOverrideError('onNextCardClick')

    def onPrevCardClick(self, cardID):
        self._printOverrideError('onPrevCardClick')

    def as_setInitDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setInitData(data)

    def as_setDetailedCardDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setDetailedCardData(data)