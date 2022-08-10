from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class BrowserMeta(BaseDAAPIComponent):

    def browserAction(self, action):
        self._printOverrideError('browserAction')

    def browserMove(self, x, y, z):
        self._printOverrideError('browserMove')

    def browserDown(self, x, y, z):
        self._printOverrideError('browserDown')

    def browserUp(self, x, y, z):
        self._printOverrideError('browserUp')

    def browserFocusOut(self):
        self._printOverrideError('browserFocusOut')

    def onBrowserShow(self, needRefresh):
        self._printOverrideError('onBrowserShow')

    def onBrowserHide(self):
        self._printOverrideError('onBrowserHide')

    def invalidateView(self):
        self._printOverrideError('invalidateView')

    def setBrowserSize(self, width, height, scale):
        self._printOverrideError('setBrowserSize')

    def as_loadBitmapS(self, url):
        if self._isDAAPIInited():
            return self.flashObject.as_loadBitmap(url)

    def as_resizeS(self, width, height):
        if self._isDAAPIInited():
            return self.flashObject.as_resize(width, height)

    def as_loadingStartS(self, showContentUnderWaiting):
        if self._isDAAPIInited():
            return self.flashObject.as_loadingStart(showContentUnderWaiting)

    def as_loadingStopS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_loadingStop()

    def as_showServiceViewS(self, header, description):
        if self._isDAAPIInited():
            return self.flashObject.as_showServiceView(header, description)

    def as_hideServiceViewS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideServiceView()

    def as_changeTitleS(self, title):
        if self._isDAAPIInited():
            return self.flashObject.as_changeTitle(title)