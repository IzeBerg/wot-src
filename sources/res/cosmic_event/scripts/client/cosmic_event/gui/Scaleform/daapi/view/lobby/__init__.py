from cosmic_event.gui.Scaleform.daapi.view.lobby.cosmic_banner_entry_point import CosmicBannerEntryPoint
from gui.Scaleform.framework import ScopeTemplates, ComponentSettings
from cosmic_constants import COSMIC_BANNER_ENTRY_POINT
__all__ = []

def getContextMenuHandlers():
    return ()


def getViewSettings():
    return (
     ComponentSettings(COSMIC_BANNER_ENTRY_POINT, CosmicBannerEntryPoint, ScopeTemplates.DEFAULT_SCOPE),)


def getBusinessHandlers():
    return ()