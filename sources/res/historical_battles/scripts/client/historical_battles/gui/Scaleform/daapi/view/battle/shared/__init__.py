from frameworks.wulf import WindowLayer
from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
from gui.Scaleform.framework import ViewSettings, ScopeTemplates
from historical_battles.gui.Scaleform.daapi.view.battle.shared.ingame_menu import HistoricalBattleIngameMenu

def getContextMenuHandlers():
    return ()


def getViewSettings():
    return (
     ViewSettings(VIEW_ALIAS.INGAME_MENU, HistoricalBattleIngameMenu, 'ingameMenu.swf', WindowLayer.TOP_WINDOW, None, ScopeTemplates.DEFAULT_SCOPE, isModal=True, canClose=False, canDrag=False),)


def getBusinessHandlers():
    return ()