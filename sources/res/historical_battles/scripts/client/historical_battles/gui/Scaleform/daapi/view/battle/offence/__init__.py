from frameworks.wulf import WindowLayer
from gui.Scaleform.framework import ViewSettings, ScopeTemplates
from historical_battles.gui.Scaleform.daapi.settings import VIEW_ALIAS
from historical_battles.gui.Scaleform.daapi.view import battle
from historical_battles.gui.Scaleform.daapi.view.battle.page import HistoricalBattlePage

def getContextMenuHandlers():
    return battle.getHBContextMenuHandlers()


def getViewSettings():
    return (
     ViewSettings(VIEW_ALIAS.HISTORICAL_BATTLES, HistoricalBattlePage, 'HBBattlePage.swf', WindowLayer.VIEW, None, ScopeTemplates.DEFAULT_SCOPE),) + battle.getHBViewSettings()


def getBusinessHandlers():
    return battle.getHBBusinessHandlers()