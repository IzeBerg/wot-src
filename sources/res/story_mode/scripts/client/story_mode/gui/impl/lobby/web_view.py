import typing
from gui.Scaleform.daapi.view.lobby.shared.web_view import WebViewTransparent
from story_mode.uilogging.story_mode.consts import LogWindows
from story_mode.uilogging.story_mode.loggers import WindowLogger

class StoryModeWebViewTransparent(WebViewTransparent):

    def __init__(self, ctx=None):
        super(StoryModeWebViewTransparent, self).__init__(ctx)
        self._uiLogger = WindowLogger(LogWindows.INFO_PAGE)

    def _populate(self):
        super(StoryModeWebViewTransparent, self)._populate()
        self._uiLogger.logOpen()

    def _dispose(self):
        self._uiLogger.logClose()
        super(StoryModeWebViewTransparent, self)._dispose()