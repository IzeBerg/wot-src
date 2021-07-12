from gui.Scaleform.framework.entities.View import View

class PersonalMissionsPageMeta(View):

    def onBarClick(self, chainID, operationIdx):
        self._printOverrideError('onBarClick')

    def onSkipTaskClick(self):
        self._printOverrideError('onSkipTaskClick')

    def onBackBtnClick(self):
        self._printOverrideError('onBackBtnClick')

    def closeView(self):
        self._printOverrideError('closeView')

    def onTutorialAcceptBtnClicked(self):
        self._printOverrideError('onTutorialAcceptBtnClicked')

    def showAwards(self):
        self._printOverrideError('showAwards')

    def as_setContentVisibleS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setContentVisible(value)

    def as_initViewS(self, pmType, chainsLen):
        if self._isDAAPIInited():
            return self.flashObject.as_initView(pmType, chainsLen)

    def as_reInitViewS(self, pmType, chainsLen):
        if self._isDAAPIInited():
            return self.flashObject.as_reInitView(pmType, chainsLen)

    def as_setHeaderDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setHeaderData(data)

    def as_updateSideBarDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_updateSideBarData(data)

    def as_setStatusDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setStatusData(data)

    def as_setSelectedBranchIndexS(self, index):
        if self._isDAAPIInited():
            return self.flashObject.as_setSelectedBranchIndex(index)

    def as_showFirstAwardSheetObtainedPopupS(self, useAnim, data):
        if self._isDAAPIInited():
            return self.flashObject.as_showFirstAwardSheetObtainedPopup(useAnim, data)

    def as_showFourAwardSheetsObtainedPopupS(self, useAnim, data):
        if self._isDAAPIInited():
            return self.flashObject.as_showFourAwardSheetsObtainedPopup(useAnim, data)

    def as_hideAwardSheetObtainedPopupS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideAwardSheetObtainedPopup()

    def as_showAwardsPopoverForTutorS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_showAwardsPopoverForTutor()