from gui.Scaleform.framework import ScopeTemplates, ComponentSettings

def getContextMenuHandlers():
    return ()


def getViewSettings():
    from messenger.gui.Scaleform.view.battle import messenger_view
    from gui.Scaleform.genConsts.BATTLE_VIEW_ALIASES import BATTLE_VIEW_ALIASES
    return (
     ComponentSettings(BATTLE_VIEW_ALIASES.BATTLE_MESSENGER, messenger_view.BattleMessengerView, ScopeTemplates.DEFAULT_SCOPE),)


def getBusinessHandlers():
    return ()