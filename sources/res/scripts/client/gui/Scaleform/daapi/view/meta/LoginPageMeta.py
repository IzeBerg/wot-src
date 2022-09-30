from gui.Scaleform.framework.entities.View import View

class LoginPageMeta(View):

    def onLogin(self, user, password, host, isSocial):
        self._printOverrideError('onLogin')

    def onRegister(self, host):
        self._printOverrideError('onRegister')

    def onRecovery(self):
        self._printOverrideError('onRecovery')

    def onTextLinkClick(self, linkId):
        self._printOverrideError('onTextLinkClick')

    def onLoginBySocial(self, socialId, host):
        self._printOverrideError('onLoginBySocial')

    def onSetRememberPassword(self, remember):
        self._printOverrideError('onSetRememberPassword')

    def onLoginNameUpdated(self):
        self._printOverrideError('onLoginNameUpdated')

    def isToken(self):
        self._printOverrideError('isToken')

    def resetToken(self):
        self._printOverrideError('resetToken')

    def onEscape(self):
        self._printOverrideError('onEscape')

    def isCSISUpdateOnRequest(self):
        self._printOverrideError('isCSISUpdateOnRequest')

    def isPwdInvalid(self, password):
        self._printOverrideError('isPwdInvalid')

    def isLoginInvalid(self, login):
        self._printOverrideError('isLoginInvalid')

    def startListenCsisUpdate(self, startListenCsis):
        self._printOverrideError('startListenCsisUpdate')

    def showLegal(self):
        self._printOverrideError('showLegal')

    def changeAccount(self):
        self._printOverrideError('changeAccount')

    def onVideoLoaded(self):
        self._printOverrideError('onVideoLoaded')

    def musicFadeOut(self):
        self._printOverrideError('musicFadeOut')

    def videoLoadingFailed(self):
        self._printOverrideError('videoLoadingFailed')

    def switchBgMode(self):
        self._printOverrideError('switchBgMode')

    def setMute(self, value):
        self._printOverrideError('setMute')

    def as_setDefaultValuesS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setDefaultValues(data)

    def as_setErrorMessageS(self, msg, errorCode):
        if self._isDAAPIInited():
            return self.flashObject.as_setErrorMessage(msg, errorCode)

    def as_setVersionS(self, version):
        if self._isDAAPIInited():
            return self.flashObject.as_setVersion(version)

    def as_setCopyrightS(self, copyrightVal, legalInfo):
        if self._isDAAPIInited():
            return self.flashObject.as_setCopyright(copyrightVal, legalInfo)

    def as_setLoginWarningS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setLoginWarning(value)

    def as_showWallpaperS(self, isShow, path, showSwitcher, isMuted):
        if self._isDAAPIInited():
            return self.flashObject.as_showWallpaper(isShow, path, showSwitcher, isMuted)

    def as_showLoginVideoS(self, path, bufferTime, isMuted):
        if self._isDAAPIInited():
            return self.flashObject.as_showLoginVideo(path, bufferTime, isMuted)

    def as_setLoginWarningHideS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_setLoginWarningHide()

    def as_setCapsLockStateS(self, isActive):
        if self._isDAAPIInited():
            return self.flashObject.as_setCapsLockState(isActive)

    def as_setKeyboardLangS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setKeyboardLang(value)

    def as_pausePlaybackS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_pausePlayback()

    def as_resumePlaybackS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_resumePlayback()

    def as_doAutoLoginS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_doAutoLogin()

    def as_enableS(self, enabled):
        if self._isDAAPIInited():
            return self.flashObject.as_enable(enabled)

    def as_switchToAutoAndSubmitS(self, key):
        if self._isDAAPIInited():
            return self.flashObject.as_switchToAutoAndSubmit(key)

    def as_showSimpleFormS(self, isShow, socialList, showRegisterLink):
        if self._isDAAPIInited():
            return self.flashObject.as_showSimpleForm(isShow, socialList, showRegisterLink)

    def as_showFilledLoginFormS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_showFilledLoginForm(data)

    def as_showSteamLoginFormS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_showSteamLoginForm(data)

    def as_resetPasswordS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_resetPassword()

    def as_getServersDPS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_getServersDP()

    def as_setSelectedServerIndexS(self, serverIndex):
        if self._isDAAPIInited():
            return self.flashObject.as_setSelectedServerIndex(serverIndex)

    def as_showHealthNoticeS(self, text):
        if self._isDAAPIInited():
            return self.flashObject.as_showHealthNotice(text)