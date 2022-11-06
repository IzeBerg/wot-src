from gui.Scaleform.framework import ScopeTemplates, ComponentSettings
from gui.Scaleform.genConsts.HANGAR_ALIASES import HANGAR_ALIASES

def getContextMenuHandlers():
    return ()


def getViewSettings():
    from gui.Scaleform.daapi.view.lobby.marathon.marathon_entry_point import MarathonEntryPointWrapper
    return (
     ComponentSettings(HANGAR_ALIASES.MARATHON_ENTRY_POINT, MarathonEntryPointWrapper, ScopeTemplates.DEFAULT_SCOPE),)


def getBusinessHandlers():
    return ()