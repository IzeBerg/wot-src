from gui.Scaleform.framework.entities.abstract.AbstractWindowView import AbstractWindowView

class SettingsWindowMeta(AbstractWindowView):

    def applySettings(self, settings, isCloseWnd):
        self._printOverrideError('applySettings')

    def autodetectQuality(self):
        self._printOverrideError('autodetectQuality')

    def startVOIPTest(self, isVoiceTestStarted):
        self._printOverrideError('startVOIPTest')

    def updateCaptureDevices(self):
        self._printOverrideError('updateCaptureDevices')

    def onSettingsChange(self, controlID, controlVal):
        self._printOverrideError('onSettingsChange')

    def altVoicesPreview(self):
        self._printOverrideError('altVoicesPreview')

    def altBulbPreview(self, sampleID):
        self._printOverrideError('altBulbPreview')

    def artyBulbPreview(self, sampleID):
        self._printOverrideError('artyBulbPreview')

    def isSoundModeValid(self):
        self._printOverrideError('isSoundModeValid')

    def showWarningDialog(self, dialogID, settings, isCloseWnd):
        self._printOverrideError('showWarningDialog')

    def onTabSelected(self, tabId):
        self._printOverrideError('onTabSelected')

    def onCounterTargetVisited(self, viewId, subViewId, controlsIDs):
        self._printOverrideError('onCounterTargetVisited')

    def autodetectAcousticType(self):
        self._printOverrideError('autodetectAcousticType')

    def canSelectAcousticType(self, index):
        self._printOverrideError('canSelectAcousticType')

    def openGammaWizard(self, x, y, size):
        self._printOverrideError('openGammaWizard')

    def openColorSettings(self):
        self._printOverrideError('openColorSettings')

    def as_setDataS(self, settingsData):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(settingsData)

    def as_setCaptureDevicesS(self, captureDeviceIdx, devicesData):
        if self._isDAAPIInited():
            return self.flashObject.as_setCaptureDevices(captureDeviceIdx, devicesData)

    def as_updateVideoSettingsS(self, videoSettings):
        if self._isDAAPIInited():
            return self.flashObject.as_updateVideoSettings(videoSettings)

    def as_confirmWarningDialogS(self, isOk, dialogID):
        if self._isDAAPIInited():
            return self.flashObject.as_confirmWarningDialog(isOk, dialogID)

    def as_showLimitedUISettingS(self, isVisible):
        if self._isDAAPIInited():
            return self.flashObject.as_showLimitedUISetting(isVisible)

    def as_ConfirmationOfApplicationS(self, isApplied):
        if self._isDAAPIInited():
            return self.flashObject.as_ConfirmationOfApplication(isApplied)

    def as_openTabS(self, tabIndex):
        if self._isDAAPIInited():
            return self.flashObject.as_openTab(tabIndex)

    def as_setGraphicsPresetS(self, presetNum):
        if self._isDAAPIInited():
            return self.flashObject.as_setGraphicsPreset(presetNum)

    def as_isPresetAppliedS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_isPresetApplied()

    def as_setCountersDataS(self, countersData):
        if self._isDAAPIInited():
            return self.flashObject.as_setCountersData(countersData)

    def as_onSoundSpeakersPresetApplyS(self, isApply):
        if self._isDAAPIInited():
            return self.flashObject.as_onSoundSpeakersPresetApply(isApply)

    def as_disableControlS(self, tabId, controlID, subTabId):
        if self._isDAAPIInited():
            return self.flashObject.as_disableControl(tabId, controlID, subTabId)

    def as_setColorGradingTechniqueS(self, icon, label):
        if self._isDAAPIInited():
            return self.flashObject.as_setColorGradingTechnique(icon, label)

    def as_setFeedbackDataProviderS(self, dataProvider):
        if self._isDAAPIInited():
            return self.flashObject.as_setFeedbackDataProvider(dataProvider)

    def as_setTigerEventS(self, isInEvent):
        if self._isDAAPIInited():
            return self.flashObject.as_setTigerEvent(isInEvent)

    def as_setDisabledTabsOverlayS(self, tabIndexes, text):
        if self._isDAAPIInited():
            return self.flashObject.as_setDisabledTabsOverlay(tabIndexes, text)