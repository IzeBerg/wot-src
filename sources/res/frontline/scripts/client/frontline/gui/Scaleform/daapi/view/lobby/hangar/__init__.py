from gui.Scaleform.framework import ComponentSettings, ScopeTemplates
from gui.Scaleform.genConsts.EPICBATTLES_ALIASES import EPICBATTLES_ALIASES
from entry_point import EpicBattlesEntryPoint

def getContextMenuHandlers():
    return ()


def getViewSettings():
    return (
     ComponentSettings(EPICBATTLES_ALIASES.EPIC_BATTLES_ENTRY_POINT, EpicBattlesEntryPoint, ScopeTemplates.DEFAULT_SCOPE),)


def getBusinessHandlers():
    return ()