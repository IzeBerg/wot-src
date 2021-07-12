from messenger.m_constants import MESSENGER_SCOPE

def setGUIEntries(decorator):
    from messenger.gui.Scaleform.battle_entry import BattleEntry
    from messenger.gui.Scaleform.lobby_entry import LobbyEntry
    decorator.setEntry(MESSENGER_SCOPE.LOBBY, LobbyEntry())
    decorator.setEntry(MESSENGER_SCOPE.BATTLE, BattleEntry())