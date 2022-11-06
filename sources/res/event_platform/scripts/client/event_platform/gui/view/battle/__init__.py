from frameworks.wulf import WindowLayer
from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
from event_platform.gui.impl.event_battle_page import EventBattlePage
from gui.Scaleform.framework import ViewSettings, ScopeTemplates
__all__ = ('EventBattlePage', )

def getContextMenuHandlers():
    return ()


def getViewSettings():
    return (
     ViewSettings(VIEW_ALIAS.CLASSIC_BATTLE_PAGE, EventBattlePage, 'battlePage.swf', WindowLayer.VIEW, None, ScopeTemplates.DEFAULT_SCOPE),)


def getBusinessHandlers():
    return ()