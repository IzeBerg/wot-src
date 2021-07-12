from constants import ClansConfig
from helpers import dependency
from skeletons.gui.lobby_context import ILobbyContext

@dependency.replace_none_kwargs(lobbyContext=ILobbyContext)
def getClanQuestURL(lobbyContext=None):
    return lobbyContext.getServerSettings().getClansConfig().get(ClansConfig.QUEST_URL)


@dependency.replace_none_kwargs(lobbyContext=ILobbyContext)
def getCraftMachineURL(lobbyContext=None):
    return lobbyContext.getServerSettings().getClansConfig().get(ClansConfig.CRAFT_MACHINE_URL)