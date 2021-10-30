from gui.Scaleform.framework.entities.View import View

class BrowserScreenMeta(View):

    def onCloseBtnClick(self):
        self._printOverrideError('onCloseBtnClick')

    def onEscapePress(self):
        self._printOverrideError('onEscapePress')

    def onFocusChange(self, hasFocus):
        self._printOverrideError('onFocusChange')

    def viewSize(self, width, height):
        self._printOverrideError('viewSize')

    def as_loadBrowserS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_loadBrowser()

    def as_setBrowserParamsS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setBrowserParams(data)