from gui.Scaleform.framework import WindowLayer, ScopeTemplates, ViewSettings, ComponentSettings, GroupedViewSettings
from gui.Scaleform.genConsts.HANGAR_ALIASES import HANGAR_ALIASES

def getContextMenuHandlers():
    return ()


def getViewSettings():
    from versus_ai.gui.Scaleform.daapi.view.lobby.hangar.carousel.tank_carousel import VersusAITankCarousel
    return (
     ComponentSettings(HANGAR_ALIASES.VERSUS_AI_TANK_CAROUSEL, VersusAITankCarousel, ScopeTemplates.DEFAULT_SCOPE),)


def getBusinessHandlers():
    return ()