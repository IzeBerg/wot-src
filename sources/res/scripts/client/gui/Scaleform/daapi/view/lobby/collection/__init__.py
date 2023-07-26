from gui.Scaleform.framework import ScopeTemplates, ComponentSettings
from gui.Scaleform.genConsts.HANGAR_ALIASES import HANGAR_ALIASES

def getContextMenuHandlers():
    return ()


def getViewSettings():
    from gui.Scaleform.daapi.view.lobby.collection.collection_entry_point import CollectionEntryPoint
    return (
     ComponentSettings(HANGAR_ALIASES.COLLECTION_ENTRY_POINT, CollectionEntryPoint, ScopeTemplates.DEFAULT_SCOPE),)


def getBusinessHandlers():
    return ()