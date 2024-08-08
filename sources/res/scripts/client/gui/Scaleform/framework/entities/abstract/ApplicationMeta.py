from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class ApplicationMeta(BaseDAAPIComponent):

    def setLoaderMgr(self, mgr):
        self._printOverrideError('setLoaderMgr')

    def setGlobalVarsMgr(self, mgr):
        self._printOverrideError('setGlobalVarsMgr')

    def setSoundMgr(self, mgr):
        self._printOverrideError('setSoundMgr')

    def setCursorMgr(self, mgr):
        self._printOverrideError('setCursorMgr')

    def setContainerMgr(self, mgr):
        self._printOverrideError('setContainerMgr')

    def setContextMenuMgr(self, mgr):
        self._printOverrideError('setContextMenuMgr')

    def setPopoverMgr(self, mgr):
        self._printOverrideError('setPopoverMgr')

    def setColorSchemeMgr(self, mgr):
        self._printOverrideError('setColorSchemeMgr')

    def setEventLogMgr(self, mgr):
        self._printOverrideError('setEventLogMgr')

    def setTooltipMgr(self, mgr):
        self._printOverrideError('setTooltipMgr')

    def setVoiceChatMgr(self, mgr):
        self._printOverrideError('setVoiceChatMgr')

    def setUtilsMgr(self, mgr):
        self._printOverrideError('setUtilsMgr')

    def setTweenMgr(self, mgr):
        self._printOverrideError('setTweenMgr')

    def setGameInputMgr(self, mgr):
        self._printOverrideError('setGameInputMgr')

    def setCacheMgr(self, mgr):
        self._printOverrideError('setCacheMgr')

    def setTextMgr(self, mgr):
        self._printOverrideError('setTextMgr')

    def setTutorialMgr(self, mgr):
        self._printOverrideError('setTutorialMgr')

    def setImageManager(self, mgr):
        self._printOverrideError('setImageManager')

    def setGraphicsOptimizationManager(self, mgr):
        self._printOverrideError('setGraphicsOptimizationManager')

    def setUILoggerMgr(self, mgr):
        self._printOverrideError('setUILoggerMgr')

    def handleGlobalKeyEvent(self, command):
        self._printOverrideError('handleGlobalKeyEvent')

    def onAsInitializationCompleted(self):
        self._printOverrideError('onAsInitializationCompleted')

    def as_isDAAPIInitedS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_isDAAPIInited()

    def as_populateS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_populate()

    def as_disposeS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_dispose()

    def as_registerManagersS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_registerManagers()

    def as_loadLibrariesS(self, list):
        if self._isDAAPIInited():
            return self.flashObject.as_loadLibraries(list)

    def as_updateStageS(self, w, h, scale):
        if self._isDAAPIInited():
            return self.flashObject.as_updateStage(w, h, scale)

    def as_blurBackgroundViewsS(self, ownLayer, blurAnimRepeatCount, blurRadius):
        if self._isDAAPIInited():
            return self.flashObject.as_blurBackgroundViews(ownLayer, blurAnimRepeatCount, blurRadius)

    def as_unblurBackgroundViewsS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_unblurBackgroundViews()

    def as_setMouseEventsEnabledS(self, enabled):
        if self._isDAAPIInited():
            return self.flashObject.as_setMouseEventsEnabled(enabled)