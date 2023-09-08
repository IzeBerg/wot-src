from frameworks.wulf import WindowLayer
from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
from gui.Scaleform.framework import ScopeTemplates, ViewSettings
from story_mode.gui.impl.lobby.web_view import StoryModeWebViewTransparent

def getContextMenuHandlers():
    return ()


def getViewSettings():
    return (
     ViewSettings(VIEW_ALIAS.WEB_VIEW_TRANSPARENT, StoryModeWebViewTransparent, 'browserScreen.swf', WindowLayer.FULLSCREEN_WINDOW, VIEW_ALIAS.WEB_VIEW_TRANSPARENT, ScopeTemplates.LOBBY_SUB_SCOPE),)


def getBusinessHandlers():
    return ()