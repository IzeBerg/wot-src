from gui.Scaleform.framework.entities.View import View

class EpicBattlesBrowserViewMeta(View):

    def onEscapePress(self):
        self._printOverrideError('onEscapePress')

    def onCloseBtnClick(self):
        self._printOverrideError('onCloseBtnClick')

    def onFocusChange(self, hasFocus):
        self._printOverrideError('onFocusChange')

    def viewSize(self, width, height):
        self._printOverrideError('viewSize')

    def as_loadBrowserS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_loadBrowser()