from gui.Scaleform.daapi.view.lobby.hangar.BrowserView import BrowserView

class EventBrowserScreenMeta(BrowserView):

    def as_setBrowserPaddingS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setBrowserPadding(value)