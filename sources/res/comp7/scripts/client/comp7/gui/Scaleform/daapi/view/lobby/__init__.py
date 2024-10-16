from gui.Scaleform.framework import ComponentSettings, ScopeTemplates
from gui.Scaleform.genConsts.HANGAR_ALIASES import HANGAR_ALIASES

def getContextMenuHandlers():
    return ()


def getViewSettings():
    from comp7.gui.Scaleform.daapi.view.lobby.hangar.comp7_modifiers_panel import Comp7ModifiersPanelInject
    from gui.impl.lobby.comp7.tournaments_widget import TournamentsWidgetComponent
    from comp7.gui.impl.lobby.comp7.comp7_grand_tournament_widget import Comp7GrandTournamentsWidgetComponent
    return (
     ComponentSettings(HANGAR_ALIASES.COMP7_MODIFIERS_PANEL, Comp7ModifiersPanelInject, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(HANGAR_ALIASES.COMP7_TOURNAMENT_BANNER, TournamentsWidgetComponent, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(HANGAR_ALIASES.COMP7_GRAND_TOURNAMENT_BANNER, Comp7GrandTournamentsWidgetComponent, ScopeTemplates.DEFAULT_SCOPE))


def getBusinessHandlers():
    return ()