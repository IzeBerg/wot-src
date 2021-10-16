from gui.Scaleform.daapi.view.lobby.shared.web_view import WebView
from uilogging.manual.constants import ManualLogKeys, ManualLogActions
from uilogging.manual.loggers import ManualLogger

class ManualBrowserView(WebView):
    uiManualUILogger = ManualLogger(ManualLogKeys.CHAPTER_VIDEO.value)

    def _populate(self):
        self.uiManualUILogger.log(ManualLogActions.OPEN.value, url=self._url)
        super(ManualBrowserView, self)._populate()

    def _dispose(self):
        self.uiManualUILogger.log(ManualLogActions.CLOSE.value, url=self._url)
        super(ManualBrowserView, self)._dispose()

    def onCloseBtnClick(self):
        self.destroy()