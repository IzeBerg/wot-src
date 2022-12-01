import typing
from helpers import dependency
from skeletons.gui.lobby_context import ILobbyContext
if typing.TYPE_CHECKING:
    from ny_common.GiftMachineConfig import GiftMachineConfig

@dependency.replace_none_kwargs(lobbyCtx=ILobbyContext)
def getNYMarketplaceConfig(lobbyCtx=None):
    return lobbyCtx.getServerSettings().getNewYearGiftMachineConfig()


def getCoinPrice():
    config = getNYMarketplaceConfig()
    return config.getCoinPrice()