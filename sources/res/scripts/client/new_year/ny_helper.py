import typing
from helpers import dependency
from skeletons.gui.lobby_context import ILobbyContext
if typing.TYPE_CHECKING:
    from ny_common.GeneralConfig import GeneralConfig

@dependency.replace_none_kwargs(lobbyCtx=ILobbyContext)
def getNYGeneralConfig(lobbyCtx=None):
    return lobbyCtx.getServerSettings().getNewYearGeneralConfig()